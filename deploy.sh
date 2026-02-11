#!/bin/bash
set -e

# Load environment variables
if [ ! -f .env ]; then
  echo "Error: .env file not found. Copy .env.example to .env and fill in your values."
  exit 1
fi
source .env

# Build
./build.sh

# Deploy
rsync -avz --delete public/ "${DEPLOY_HOST}:${DEPLOY_PATH}"
