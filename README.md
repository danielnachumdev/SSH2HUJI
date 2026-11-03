# SSH2HUJI

**Small SSH helper for HUJI CS students** — version-check, first-time host-key setup, then ProxyJump into a lab machine with one prompt for your CSE username.

[![License](https://img.shields.io/badge/license-see%20repo-lightgrey.svg)](https://github.com/danielnachumdev/SSH2HUJI)

Shell scripts for **Unix** (`SSH2HUJI_unix.sh`) and **Windows** (`SSH2HUJI_windows.bat`). No installer, no package manager — download a release and run.

## Why this repo?

Connecting to the CS “aquarium” lab machines normally means remembering jump-host syntax, accepting host keys, and typing a long `ssh` line. These scripts wrap that into a short interactive flow.

- **One username prompt** — builds the ProxyJump SSH command for you
- **Version check** — compares the script’s embedded version to the repo `version` file on `main`
- **First-run host keys** — uses `ssh-keyscan` when the jump host is missing from `known_hosts`
- **Cross-platform** — bash for macOS/Linux; batch for Windows OpenSSH

## Quick start

1. Download the [latest release](https://github.com/danielnachumdev/SSH2HUJI/releases/latest) and keep the script for your OS.
2. **Unix / macOS:** make it executable and run it:

   ```bash
   chmod +x SSH2HUJI_unix.sh
   ./SSH2HUJI_unix.sh
   ```

3. **Windows:** double-click `SSH2HUJI_windows.bat` (or run it from a terminal). If SmartScreen blocks an unverified publisher, use **More info → Run anyway**.
4. Enter your **CSE username** when prompted. The script starts an interactive SSH session (X11 forwarding + compression flags as coded).

Requires `curl` and `ssh` on `PATH`. The Unix script’s version compare also needs `bc`.

Jump and lab hostnames are **hardcoded in the scripts** — edit those files if you need different targets. Never put passwords or private keys into the repo.

## What you get

| File | Role |
| ---- | ---- |
| `SSH2HUJI_unix.sh` | Bash helper (version check → known_hosts → SSH) |
| `SSH2HUJI_windows.bat` | Windows batch equivalent |
| `version` | Latest published version string (fetched from `main` at runtime) |

## Contributing & development

Agent/developer workflow (layout, version bumps, CI labels, secrets): see [`AGENTS.md`](./AGENTS.md).

Report security issues privately via [GitHub advisories](https://github.com/danielnachumdev/SSH2HUJI/security/advisories/new) — please do not open a public issue for vulnerabilities.
