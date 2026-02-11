#!/bin/bash
set -e

# Copy legal pages into content before building
cp legal/*.md content/

# Build or serve
if [ "$1" = "--serve" ]; then
  npx quartz build --serve
else
  npx quartz build
fi
