#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_DIR="$SCRIPT_DIR"

# shellcheck disable=SC1091
source "$REPO_DIR/scripts/legal-pages.sh"

load_env_file "$REPO_DIR/.env"
require_legal_env
generate_legal_pages "$REPO_DIR"
trap 'cleanup_legal_pages "$REPO_DIR"' EXIT

cd "$REPO_DIR"

if [ "${1:-}" = "--serve" ]; then
  shift
  npx quartz build --serve "$@"
else
  npx quartz build "$@"
fi
