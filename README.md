This repository contains my personal website and digital garden, built on top of [Quartz](https://github.com/jackyzha0/quartz).

Quartz remains the site generator, but the repo is set up around a local-first Obsidian workflow:

- notes live in Obsidian
- selected notes are synced into `content/`
- Quartz builds the published site
- GitHub Actions deploys the built site to Hetzner on pushes to `v4`

## Prerequisites

- Node.js 22+
- npm 10+
- a local `.env` copied from `.env.example`
- an Obsidian vault at the configured path if you want to use `publish.sh`

## Environment Setup

Copy the example file and fill in the required values:

```bash
cp .env.example .env
```

Required for local builds:

- `IMPRESSUM_NAME`
- `IMPRESSUM_ADDRESS`
- `IMPRESSUM_CITY`
- `IMPRESSUM_EMAIL`

Optional local-first publishing variables:

- `VAULT_PATH`
- `NOTES_DIR`
- `RESOURCES_DIR`
- `PUBLISH_BRANCH`

Deploy-specific variables are still listed in `.env.example`, but production deploys happen through GitHub Actions secrets.

## Canonical Commands

```bash
npm ci
npm run check
npm run build
```

Local preview:

```bash
npm run dev
```

Automatic publish from the Obsidian workflow:

```bash
./publish.sh
```

Safe validation modes:

```bash
./publish.sh --dry-run
./publish.sh --no-push
```

## Publishing Behavior

`publish.sh` is intentionally local-first and automatic by default. It:

- syncs publishable notes into `content/`
- syncs referenced attachments into `content/Attachments`
- generates legal pages from templates and env values
- runs `npm run check`
- runs `npm run build`
- commits changed published content
- pushes the result to `v4` by default

If validation fails, the script exits before commit and push.

Generated legal pages are build-time artifacts. They are created when needed for validation/build and are not meant to be committed.

## Launchd Automation

This repo includes `com.benedict.quartz-publish.plist` for optional macOS `launchd` automation.

Typical workflow:

```bash
cp com.benedict.quartz-publish.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/com.benedict.quartz-publish.plist
```

Unload it with:

```bash
launchctl unload ~/Library/LaunchAgents/com.benedict.quartz-publish.plist
```

## Attribution

Quartz is created and maintained by [jackyzha0](https://github.com/jackyzha0) and contributors. This repository keeps that foundation and customizes it for my site and workflow.
