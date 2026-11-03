# SSH2HUJI – Agent Context

Implementation guide for coding agents changing **SSH2HUJI**. Product pitch and user-facing install: [`README.md`](README.md).

---

## Orientation

| Question | Answer |
| -------- | ------ |
| What is this? | Shell helpers that wrap SSH ProxyJump into HUJI CS lab machines |
| Entry points | `SSH2HUJI_unix.sh` (bash), `SSH2HUJI_windows.bat` (cmd) |
| Toolchain | Plain shell — no package manager, no language runtime beyond `bash`/`cmd` |
| Tests | None today (CI may use `allow-empty: true`) |
| Secrets | Never commit passwords, private keys, tokens, or personal usernames |

```text
.
├── .github/                 # When present: CODEOWNERS, dependabot, thin CI
├── SSH2HUJI_unix.sh         # Unix / macOS flow
├── SSH2HUJI_windows.bat     # Windows OpenSSH flow
├── version                  # Semver string fetched at runtime from main
├── README.md                # Marketing / user docs
└── AGENTS.md                # This file
```

Shared CI (when workflows exist): [`danielnachumdev/actions`](https://github.com/danielnachumdev/actions) — prefer thin orchestrators with **`@latest`** / `standards-ref: latest`, and `allow-empty: true` until real checks exist. How to adopt: [`HOW-TO-USE.md`](https://github.com/danielnachumdev/actions/blob/v1/HOW-TO-USE.md).

---

## Develop

There is no build step. Edit the scripts and exercise them locally against a disposable SSH target if needed — **do not** use live student credentials or production passwords in transcripts, PRs, or fixtures.

| Task | Notes |
| ---- | ----- |
| Smoke Unix | `bash -n SSH2HUJI_unix.sh` (syntax); full run needs `curl`, `ssh`, `bc` |
| Smoke Windows | Run under `cmd.exe` with OpenSSH + `curl` on `PATH` |
| Version bump | Update **both** scripts’ `current_version=` **and** the root `version` file together |

### Runtime dependencies

- **Both:** `curl`, `ssh` (`ssh-keyscan` for first-run known_hosts)
- **Unix version compare:** `bc` (used in the arithmetic check against `version`)

### Domain notes

- Keep Unix and Windows flows behaviorally aligned (version check → known_hosts → prompt → `ssh -CXJ …`).
- Hostnames / jump targets are **literals inside the scripts**. Prefer placeholders like `jump.example.edu` / `lab-host-01` in docs, tests, and PR text; do not paste real credentials.
- Version source of truth for *users* is the embedded `current_version` vs remote `version` on `main`. Release tags should match those strings when you cut a GitHub Release.
- Do not rewrite these into another language in a drive-by PR; keep them as small shell helpers unless the product direction changes deliberately.
- `.gitignore` already ignores a local `tmp` file (used as the downloaded version scratch path).

---

## PRs, CI, and releases

1. Branch off `main`; open a PR into `main`.
2. Attach **exactly one** semver label: `noBump` | `bumpPatch` | `bumpMinor` | `bumpMajor`.
3. **CI** (when present) — thin `.github/workflows/ci.yml` calling `danielnachumdev/actions` (`ci.yml` + `semver-ci.yml`). Prefer required checks **`CI / CI`** and **`Semver / Semver`**.
4. Dependabot PRs stay on `noBump`.
5. Change shared CI/semver behavior in **`danielnachumdev/actions`**, not by re-vendoring here.
6. User-facing releases are **GitHub Releases** (scripts + `version`); bump the embedded versions in the same change that cuts the release.

### Repo gates (when configured)

- `.github/CODEOWNERS` — `@danielnachumdev`
- Prefer private vulnerability reporting via GitHub Security Advisories

---

## Sensitive / ignored

Do not commit: passwords, SSH private keys, personal CSE usernames, API tokens, or live operator inventory. Do not paste real jump/lab hostnames into PR bodies or screenshots when placeholders suffice. Track `version`. Respect `.gitignore` (`tmp`, local editor history).
