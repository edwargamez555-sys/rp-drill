# CLAUDE.md — rp-drill

## What this repo is governed by

`rp-drill` is governed **by reference** to the `renovapro-app` Phase 9b canon. It is not a parallel canonical authority and must not be treated as one.

Authoritative source-of-truth (in this order):

1. `renovapro-app/docs/deploy/phase-9b-snapshots-backups-posture.md` — Module E + E.1 + E.2 + E.3 + E.4 lineage; pinned `v.sh` SHA256, `MC_RELEASE`, `MC_SHA256`, two-resource Stage 1 shape, Render API token scope rule, cleanup contract.
2. `renovapro-app/docs/deploy/phase-9b-module-g-strategy-2-redesign-ruling.md` — Module-G ruling: pre-baked validation image with `ENTRYPOINT`; runtime reference by content digest only at `ghcr.io/edwargamez555-sys/rp-drill-client@sha256:<digest>`.
3. `renovapro-app/docs/deploy/phase-9b-module-f0-preflight-protocol.md` — Module F-0 preflight protocol; eight named verdicts; `MODULE_F0_REQUIRED_BEFORE_MODULE_G_EXECUTION`.
4. `renovapro-app/docs/deploy/phase-9b-module-f-strategy-2-off-canon-smoke-incident.md` — PR #78 binding rule (§8): natural-language follow-ups never carry execution authorization across turns; every Module-F-shaped Render mutation requires its own docs-anchored Authorization packet; exploratory parser/runtime smokes must be ruled in docs before execution.
5. `renovapro-app/docs/deploy/phase-9b-module-f-strategy-1-closeout.md` — `MODULE_F_RETRY_STRATEGY_1_FAILED_CLEANED_UP`; root-cause class §6.3.
6. `renovapro-app/docs/deploy/phase-9b-status-index.md` — Phase 9b status index.
7. `renovapro-app/docs/deploy/runbook.md` §11 — pre-real-data PITR gate checklist.

If a sentence in this `CLAUDE.md` ever contradicts any of those `renovapro-app` docs, **the `renovapro-app` doc wins** and this file is updated, never the other way around.

## What `v.sh` is

`v.sh` is the only runtime artifact in this repo. Its content is **pinned by SHA256** in `renovapro-app` Module E.4 / Module-G inherited canon as `daa6f65a6894d5cdb43df26277aed050be7a462a4d42c1ce90f12e97a241596d`. The rp-drill commit pin that hosts it is `bb350f79512b629945f6bb831f86e794340b90a0`. Any change to `v.sh` content, to `v.sh.sha256`, or to the commit pin invalidates the inherited canon and requires reopening Module E.4 + Module-G + Module F-0 simultaneously under separate authorization. Do not edit `v.sh` or `v.sh.sha256` casually; do not edit them at all without a separately-authorized future ruling that names the change.

## What is NOT authorized by natural language

The PR #78 binding rule applies in full to this repo: **natural-language follow-ups never carry execution authorization across turns; every Module-F-shaped Render mutation requires its own docs-anchored Authorization packet; exploratory parser/runtime smokes must be ruled in docs before execution.**

In rp-drill terms, none of the following is ever authorized by a conversational suggestion, a "just try it once", a "let's see if it builds", or any equivalent natural-language framing. Each of the following requires its own separately-authorized future docs-anchored packet:

- Authoring a `Dockerfile`.
- Authoring a `.github/workflows/*.yml` file.
- Building any container image (locally, in CI, or in any environment).
- Pushing, pulling, tagging, moving, or deleting any image in GHCR or any other registry.
- Capturing an image digest into `renovapro-app` canon.
- Running any GitHub Actions workflow (`workflow_dispatch`, push-trigger, manual-run).
- Creating any GHCR PAT, registry token, or Render API token; logging in to any registry.
- Editing `v.sh`, `v.sh.sha256`, `LICENSE`, or moving the commit pin.
- Executing `v.sh` locally or in any environment.
- Touching any Render resource (production or otherwise), any production envVarGroup, or any production database/Redis/MinIO surface.
- Module F-0 execution; Module-G execution; Module F retry execution.
- Any Pro upgrade click, billing change, production password rotation, second admin / break-glass action, or `runbook.md` §11.2 checkbox flip.

## What this repo CAN do today

- Receive **docs-only ruling PRs** that add or amend governance documents under `docs/`.
- Receive **additive cross-reference edits** to `README.md` that point at new ruling documents under `docs/`.
- Receive small `CLAUDE.md` adjustments that keep this pointer file aligned with `renovapro-app` canon.

Every PR must be self-evidently docs-only or ruling-anchored. A PR diff that touches `Dockerfile`, `.github/**`, `scripts/**`, `package.json`, `v.sh`, `v.sh.sha256`, `LICENSE`, or any executable artifact is **out of scope** of every PR opened under this contract until a separately-authorized future ruling explicitly authorizes that scope.

## STOP conditions

- A reviewer or tool suggests authoring a `Dockerfile` or `.github/workflows/*.yml` "just to see how the build looks." STOP — that is a separately-authorized future packet.
- A reviewer or tool suggests building / pushing / digest-capturing now. STOP — that is a separately-authorized future packet.
- A reviewer or tool suggests editing `v.sh` / `v.sh.sha256` / commit pin / `LICENSE`. STOP — those are pinned in `renovapro-app` canon; any change requires reopening the inherited rulings.
- The `v.sh` git-blob SHA256 ever ceases to match `daa6f65a6894d5cdb43df26277aed050be7a462a4d42c1ce90f12e97a241596d`. STOP — the inherited canon is invalid; reopen Module E.4 + Module-G + Module F-0 in `renovapro-app` before any rp-drill action.
