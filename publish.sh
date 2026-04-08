#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"

# shellcheck disable=SC1091
source "$REPO_DIR/scripts/legal-pages.sh"

load_env_file "$REPO_DIR/.env"

VAULT_PATH="${VAULT_PATH:-$HOME/vault_obsidian}"
NOTES_DIR="${NOTES_DIR:-20 Notes}"
RESOURCES_DIR="${RESOURCES_DIR:-$VAULT_PATH/90 Sources/Resources}"
PUBLISH_BRANCH="${PUBLISH_BRANCH:-main}"
CONTENT_DIR="$REPO_DIR/content"
ATTACHMENTS_DIR="$CONTENT_DIR/Attachments"
SKIP_DIRS="00 Inbox|01 Daily Notes|10 Lectures|30 MOCs|99 Templates|.obsidian"
SKIP_FILES="impressum.md|datenschutz.md"
IMAGE_EXT="png|jpg|jpeg|gif|svg|webp|pdf"

DRY_RUN=0
NO_PUSH=0

usage() {
  cat <<'EOF'
Usage: ./publish.sh [--dry-run] [--no-push]

  --dry-run  Sync and validate without committing or pushing.
  --no-push  Commit locally but skip the push step.
EOF
}

while [ "$#" -gt 0 ]; do
  case "$1" in
    --dry-run)
      DRY_RUN=1
      ;;
    --no-push)
      NO_PUSH=1
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown option '$1'" >&2
      usage >&2
      exit 1
      ;;
  esac
  shift
done

PUBLISH_LIST=$(mktemp)
PUBLISH_PATH_LIST=$(mktemp)
IMAGE_REF_LIST=$(mktemp)
cleanup() {
  cleanup_legal_pages "$REPO_DIR"
  rm -f "$PUBLISH_LIST" "$PUBLISH_PATH_LIST" "$IMAGE_REF_LIST"
}
trap cleanup EXIT

record_publish_file() {
  local rel_path="$1"
  local source_file="$2"

  printf "%s|%s\n" "$rel_path" "$source_file" >> "$PUBLISH_LIST"
  printf "%s\n" "$rel_path" >> "$PUBLISH_PATH_LIST"
}

has_publish_true() {
  awk '/^---$/ { if (++c == 2) exit } c == 1 { print }' "$1" \
    | grep -qi '^publish: *true'
}

has_publish_false() {
  awk '/^---$/ { if (++c == 2) exit } c == 1 { print }' "$1" \
    | grep -qi '^publish: *false'
}

is_newer() {
  [ ! -f "$2" ] && return 0
  [ "$1" -nt "$2" ]
}

get_frontmatter_field() {
  local file="$1" field="$2"
  awk '/^---$/ { if (++c == 2) exit } c == 1 { print }' "$file" \
    | grep -i "^${field}:" \
    | head -1 \
    | sed -E "s/^${field}: *//i" \
    | tr -d '"' \
    | tr -d "'" || true
}

get_file_mdate() {
  stat -f '%Sm' -t '%Y-%m-%d' "$1"
}

copy_with_dates() {
  local vault_file="$1" dest="$2"
  local today
  today=$(date '+%Y-%m-%d')

  local vault_mdate
  vault_mdate=$(get_file_mdate "$vault_file")

  local created modified published

  if [ -f "$dest" ]; then
    created=$(get_frontmatter_field "$dest" "created")
    published=$(get_frontmatter_field "$dest" "published")
    modified="$vault_mdate"
    [ -z "$created" ] && created="$vault_mdate"
    [ -z "$published" ] && published="$today"
  else
    created=$(get_frontmatter_field "$vault_file" "created")
    [ -z "$created" ] && created="$vault_mdate"
    modified="$vault_mdate"
    published="$today"
  fi

  local first_line
  first_line=$(head -1 "$vault_file")

  mkdir -p "$(dirname "$dest")"

  if [ "$first_line" = "---" ]; then
    awk -v created="$created" -v modified="$modified" -v published="$published" '
    BEGIN { in_fm = 0; fm_count = 0; printed_created = 0; printed_modified = 0; printed_published = 0 }
    /^---$/ {
      fm_count++
      if (fm_count == 1) {
        in_fm = 1
        print
        next
      }
      if (fm_count == 2) {
        if (!printed_created) print "created: " created
        if (!printed_modified) print "modified: " modified
        if (!printed_published) print "published: " published
        in_fm = 0
        print
        next
      }
    }
    in_fm == 1 && /^created:/ {
      print "created: " created
      printed_created = 1
      next
    }
    in_fm == 1 && /^modified:/ {
      print "modified: " modified
      printed_modified = 1
      next
    }
    in_fm == 1 && /^published:/ {
      print "published: " published
      printed_published = 1
      next
    }
    { print }
    ' "$vault_file" > "$dest"
  else
    {
      echo "---"
      echo "created: $created"
      echo "modified: $modified"
      echo "published: $published"
      echo "---"
      echo ""
      cat "$vault_file"
    } > "$dest"
  fi
}

if [ -L "$CONTENT_DIR" ]; then
  echo "Error: $CONTENT_DIR is a symlink. Refusing to operate."
  exit 1
fi

if [ ! -d "$CONTENT_DIR" ]; then
  echo "Error: content directory not found at $CONTENT_DIR"
  exit 1
fi

if [ ! -d "$VAULT_PATH" ]; then
  echo "Error: Vault not found at $VAULT_PATH"
  exit 1
fi

if [ -d "$VAULT_PATH/$NOTES_DIR" ]; then
  while IFS= read -r -d '' file; do
    filename="$(basename "$file")"
    if echo "$filename" | grep -qE "^(${SKIP_FILES})$"; then
      continue
    fi
    if has_publish_false "$file"; then
      continue
    fi
    rel_path="${file#$VAULT_PATH/$NOTES_DIR/}"
    record_publish_file "$rel_path" "$file"
  done < <(find "$VAULT_PATH/$NOTES_DIR" -type f -name '*.md' -print0)
fi

while IFS= read -r -d '' dir; do
  dirname="$(basename "$dir")"
  if [ "$dirname" = "$NOTES_DIR" ] || echo "$dirname" | grep -qE "^(${SKIP_DIRS})$"; then
    continue
  fi
  while IFS= read -r -d '' file; do
    filename="$(basename "$file")"
    if echo "$filename" | grep -qE "^(${SKIP_FILES})$"; then
      continue
    fi
    if has_publish_true "$file"; then
      rel_path="${file#$VAULT_PATH/}"
      record_publish_file "$rel_path" "$file"
    fi
  done < <(find "$dir" -type f -name '*.md' -print0)
done < <(find "$VAULT_PATH" -maxdepth 1 -mindepth 1 -type d -print0)

while IFS= read -r -d '' file; do
  filename="$(basename "$file")"
  if echo "$filename" | grep -qE "^(${SKIP_FILES})$"; then
    continue
  fi
  if has_publish_true "$file"; then
    rel_path="${file#$VAULT_PATH/}"
    record_publish_file "$rel_path" "$file"
  fi
done < <(find "$VAULT_PATH" -maxdepth 1 -type f -name '*.md' -print0)

sort -u "$PUBLISH_PATH_LIST" -o "$PUBLISH_PATH_LIST"

note_count=$(wc -l < "$PUBLISH_LIST" | tr -d ' ')
echo "Found $note_count publishable note(s)"

copied=0
skipped=0
removed=0

while IFS='|' read -r rel_path vault_file; do
  [ -z "$rel_path" ] && continue
  dest="$CONTENT_DIR/$rel_path"

  if is_newer "$vault_file" "$dest"; then
    copy_with_dates "$vault_file" "$dest"
    touch -r "$vault_file" "$dest"
    copied=$((copied + 1))
  else
    skipped=$((skipped + 1))
  fi
done < "$PUBLISH_LIST"

while IFS= read -r -d '' content_file; do
  rel_path="${content_file#$CONTENT_DIR/}"

  case "$rel_path" in
    Attachments/*|.gitkeep) continue ;;
  esac

  if ! grep -Fqx "$rel_path" "$PUBLISH_PATH_LIST" 2>/dev/null; then
    rm "$content_file"
    removed=$((removed + 1))
  fi
done < <(find "$CONTENT_DIR" -type f -name '*.md' -print0)

find "$CONTENT_DIR" -mindepth 1 -type d -empty -not -name 'Attachments' -delete 2>/dev/null || true

echo "Notes: $copied copied, $skipped unchanged, $removed removed"

while IFS= read -r -d '' note; do
  grep -oE "\!\[\[[^]]+\.(${IMAGE_EXT})\]\]" "$note" 2>/dev/null \
    | sed -E 's/!\[\[(.+)\]\]/\1/' \
    | xargs -I{} basename "{}" >> "$IMAGE_REF_LIST" || true

  grep -oE "\!\[[^]]*\]\([^)]+\.(${IMAGE_EXT})\)" "$note" 2>/dev/null \
    | sed -E 's/!\[[^]]*\]\((.+)\)/\1/' \
    | xargs -I{} basename "{}" >> "$IMAGE_REF_LIST" || true
done < <(find "$CONTENT_DIR" -type f -name '*.md' -print0)

if [ -f "$IMAGE_REF_LIST" ]; then
  sort -u "$IMAGE_REF_LIST" -o "$IMAGE_REF_LIST"
fi

img_count=$(wc -l < "$IMAGE_REF_LIST" | tr -d ' ')
echo "Found $img_count unique image reference(s)"

img_copied=0
img_skipped=0
img_missing=0

if [ "$img_count" -gt 0 ]; then
  mkdir -p "$ATTACHMENTS_DIR"

  while IFS= read -r img_name; do
    [ -z "$img_name" ] && continue
    dest="$ATTACHMENTS_DIR/$img_name"

    vault_img=""
    if [ -f "$RESOURCES_DIR/$img_name" ]; then
      vault_img="$RESOURCES_DIR/$img_name"
    else
      vault_img="$(find "$VAULT_PATH" -type f -name "$img_name" -not -path "*/.obsidian/*" -print -quit 2>/dev/null)" || true
    fi

    if [ -n "$vault_img" ]; then
      if is_newer "$vault_img" "$dest"; then
        cp "$vault_img" "$dest"
        img_copied=$((img_copied + 1))
      else
        img_skipped=$((img_skipped + 1))
      fi
    else
      echo "  Warning: referenced image not found in vault: $img_name"
      img_missing=$((img_missing + 1))
    fi
  done < "$IMAGE_REF_LIST"
fi

img_removed=0
if [ -d "$ATTACHMENTS_DIR" ]; then
  while IFS= read -r -d '' img_file; do
    img_name="$(basename "$img_file")"
    if ! grep -qx "$img_name" "$IMAGE_REF_LIST" 2>/dev/null; then
      rm "$img_file"
      img_removed=$((img_removed + 1))
    fi
  done < <(find "$ATTACHMENTS_DIR" -type f -print0)

  rmdir "$ATTACHMENTS_DIR" 2>/dev/null || true
fi

echo "Images: $img_copied copied, $img_skipped unchanged, $img_removed removed, $img_missing missing"

generate_legal_pages "$REPO_DIR"

echo "Running checks"
npm run check

echo "Building site"
npm run build

cleanup_legal_pages "$REPO_DIR"

cd "$REPO_DIR"

git add content/

if git diff --cached --quiet; then
  echo "No changes to publish — exiting."
  exit 0
fi

if [ "$DRY_RUN" -eq 1 ]; then
  echo "Dry run complete. Staged content diff:"
  git diff --cached --stat
  git reset --quiet HEAD -- content/
  echo "Dry run finished without commit or push."
  exit 0
fi

timestamp=$(date '+%Y-%m-%d %H:%M')
git commit -m "publish: $timestamp"

if [ "$NO_PUSH" -eq 1 ]; then
  echo "Committed locally at $timestamp (push skipped)."
  exit 0
fi

git push origin "HEAD:${PUBLISH_BRANCH}"

echo "Published and pushed at $timestamp"
