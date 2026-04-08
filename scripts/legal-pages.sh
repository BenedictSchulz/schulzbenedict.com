#!/bin/bash

LEGAL_PAGE_VARS=(
  IMPRESSUM_NAME
  IMPRESSUM_ADDRESS
  IMPRESSUM_CITY
  IMPRESSUM_EMAIL
)

load_env_file() {
  local env_file="${1:-.env}"

  if [ -f "$env_file" ]; then
    set -a
    # shellcheck disable=SC1090
    source "$env_file"
    set +a
  fi
}

require_env_vars() {
  local missing=()
  local var_name

  for var_name in "$@"; do
    if [ -z "${!var_name:-}" ]; then
      missing+=("$var_name")
    fi
  done

  if [ "${#missing[@]}" -gt 0 ]; then
    echo "Error: missing required environment variables: ${missing[*]}" >&2
    return 1
  fi
}

require_legal_env() {
  require_env_vars "${LEGAL_PAGE_VARS[@]}"
}

escape_sed_replacement() {
  printf "%s" "$1" | sed -e 's/[&|\\]/\\&/g'
}

generate_legal_pages() {
  local repo_dir="${1:?repository directory required}"
  local escaped_name escaped_address escaped_city escaped_email
  local template

  require_legal_env

  escaped_name=$(escape_sed_replacement "${IMPRESSUM_NAME}")
  escaped_address=$(escape_sed_replacement "${IMPRESSUM_ADDRESS}")
  escaped_city=$(escape_sed_replacement "${IMPRESSUM_CITY}")
  escaped_email=$(escape_sed_replacement "${IMPRESSUM_EMAIL}")

  mkdir -p "$repo_dir/content"

  for template in "$repo_dir"/legal/*.md; do
    [ -f "$template" ] || continue

    sed -e "s|{{IMPRESSUM_NAME}}|${escaped_name}|g" \
      -e "s|{{IMPRESSUM_ADDRESS}}|${escaped_address}|g" \
      -e "s|{{IMPRESSUM_CITY}}|${escaped_city}|g" \
      -e "s|{{IMPRESSUM_EMAIL}}|${escaped_email}|g" \
      "$template" > "$repo_dir/content/$(basename "$template")"
  done
}

cleanup_legal_pages() {
  local repo_dir="${1:?repository directory required}"

  rm -f "$repo_dir/content/impressum.md" "$repo_dir/content/datenschutz.md"
}
