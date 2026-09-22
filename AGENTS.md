# AI Rules & Guidelines

This document outlines the rules and conventions that AI agents and automated contributors must follow when contributing to this repository.

---

## Add-on Versioning and Update Rules

Home Assistant requires explicit, changing version numbers to detect add-on updates. All add-ons in this repository must comply with the following versioning guidelines:

### 1. Mandatory `version` in `config.yaml`
- Every add-on must specify a concrete `version` string in its `config.yaml` (or `config.yml`).
- **Never use `latest`** (or leave version omitted/static). Home Assistant relies on string comparison of the `version` field to recognize updates and prompt users to update.

### 2. 1:1 Version Matching with Docker Images
- When the upstream Docker image has a specific version tag (e.g., `iproyal/pawns-cli:0.36.6`, `honeygain/honeygain:0.9.0`, `packetstream/psclient` tagged `v2.4.3`), the `version` in `config.yaml` **must match the Docker image version 1:1**.
- If an add-on uses a custom Docker image (via a `Dockerfile` and/or `build.yaml` in the add-on directory), the add-on `version` in `config.yaml` and the custom image version must be identical.

### 3. Custom Image & Calendar Versioning (CalVer) for Unversioned Images
- When the upstream Docker image does not supply semantic or numbered version tags (e.g., only `latest` or architecture-only tags such as `:arm64v8`):
  1. **Create a custom Docker image** (`Dockerfile` / `build.yaml`) for the add-on.
  2. **Use custom Calendar Versioning (CalVer)** reflecting the date of the latest upstream Docker image release/update.
  3. **CalVer Format**: `YYYY.MM.DD` (for example `2026.08.17` represents the release based on an upstream image updated on 2026-08-17).
