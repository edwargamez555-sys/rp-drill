# rp-drill

Public artifact host for the **RenovaPro Module F MinIO restore-drill validation script**. Non-secret. Governed by `renovapro-app` Module E lineage.

## What this repo is

A minimal, content-addressable, public host for a single non-secret shell script and its sha256 checksum sidecar. The script is intended for one purpose only: pickup by a Render Cron Job during a separately authorized **Module F Strategy 2** drill cycle, executed inside Render's private network against a **temporary** MinIO drill server (`rp-minio-drill`). The drill is non-destructive against any production resource.

## What this repo is NOT

- Not a production repo.
- Not a code mirror of `renovapro-app`.
- Not a credential store. **No secrets, no env files, no Render tokens, no GitHub PATs, no MinIO root keys, no MinIO drill access/secret keys**, no IP addresses, and no production or staging hostnames are stored here. The only internal-hostname references in this repo are the **governance-approved temporary drill resource names** `rp-minio-drill` (the temporary MinIO drill server) and `rp-minio-drill-client` (the temporary Cron Job that runs `v.sh`); both are non-secret per the Module E lineage and exist only during the drill window.
- Not a runtime environment. The script is **not executed** by anything in this repo (no CI, no Actions, no Pages).
- Not a place to put the production validation logic from `renovapro-app`.

## File inventory

| Path | Purpose |
|---|---|
| `README.md` | this file |
| `LICENSE` | MIT |
| `v.sh` | the validation script — POSIX `/bin/sh`, Alpine-compatible, ~80–110 lines |
| `v.sh.sha256` | sha256 sidecar in GNU `sha256sum` format (`<64hex>  v.sh`) |

## Why the script is named `v.sh`

The future Render Cron Job's `dockerCommand` field has a working-hypothesis upper bound of 256 characters. The `dockerCommand` shape is:

```
wget -qO /tmp/v.sh https://raw.githubusercontent.com/edwargamez555-sys/rp-drill/<commit-sha>/v.sh && echo '<script-sha256>  /tmp/v.sh' | sha256sum -c - && sh /tmp/v.sh
```

The longer the script's filename in this repo, the longer the `dockerCommand`. A 26-character filename like `minio-drill-validation.sh` would push the command **over** the 256-character cap. The two-character filename `v.sh` keeps the command at ~244 chars, comfortably within the cap with margin.

## Canonical governance

The validation script's existence, its purpose, the drill protocol it serves, the `mc` pinning policy, the cleanup contract, and every other rule binding on its execution live in:

- [`docs/deploy/phase-9b-snapshots-backups-posture.md`](https://github.com/edwargamez555-sys/renovapro-app/blob/main/docs/deploy/phase-9b-snapshots-backups-posture.md)

That file is the canonical Module E / E.1 / E.2 / E.3 / (eventual E.4) ruling chain. **If anything in this repo disagrees with that file, that file wins.**

## Intended runtime

This script is intended to be fetched and executed **only** by a Render Cron Job under a separately authorized Module F Strategy 2 execution packet. It is **not** for local execution by any operator. There are no `make run` targets, no docker-compose files, no example commands. The script reads two drill-only environment variables (`MINIO_DRILL_ACCESS_KEY`, `MINIO_DRILL_SECRET_KEY`) that exist solely on the temporary `rp-minio-drill-client` Cron Job created during a drill cycle.

## Non-authorization

The existence of this repository does **NOT** authorize:

- Module F retry execution.
- Module F+1 / Stage 2 execution.
- Render mutation of any kind.
- Pro workspace upgrade.
- Production action of any kind.
- Marking the real-data gate satisfied.
- Marking `runbook.md` §11.2 in `renovapro-app` satisfied.
- Marking MinIO Stage 1 satisfied.

Authorization for any of the above lives in `renovapro-app` rulings, not here.
