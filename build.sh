#!/bin/bash
set -e

# Load environment variables
if [ ! -f .env ]; then
  echo "Error: .env file not found. Copy .env.example to .env and fill in your values."
  exit 1
fi
source .env

# Copy legal pages into content, substituting placeholders
for f in legal/*.md; do
  sed -e "s|{{IMPRESSUM_NAME}}|$IMPRESSUM_NAME|g" \
      -e "s|{{IMPRESSUM_ADDRESS}}|$IMPRESSUM_ADDRESS|g" \
      -e "s|{{IMPRESSUM_CITY}}|$IMPRESSUM_CITY|g" \
      -e "s|{{IMPRESSUM_EMAIL}}|$IMPRESSUM_EMAIL|g" \
      "$f" > "content/$(basename "$f")"
done

# Build or serve
if [ "$1" = "--serve" ]; then
  npx quartz build --serve
else
  npx quartz build
fi
