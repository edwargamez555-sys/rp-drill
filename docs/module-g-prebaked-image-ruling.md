# Module-G pre-baked image build/push ruling (rp-drill side)

## 1. Header / scope

- **Type**: docs-only ruling **in `rp-drill`**. Rules the build / push / digest-capture mechanism for the future Module-G validation image at `ghcr.io/edwargamez555-sys/rp-drill-client`.
- **Posture**: read-only ruling layer. **This document does NOT execute the build, the push, the digest capture, or any subsequent step.** The future Module-G execution path requires several distinct, separately-authorized packets after this one (see §11). This ruling rules the **mechanism**; every subsequent step is its own future authorization.
- **Mutation surface during writing**: zero — no Dockerfile authored, no GitHub Actions workflow authored, no image built, no image pushed, no GHCR registry operation, no Docker pull / run / build, no token created, no `v.sh` execution, no `v.sh` / `v.sh.sha256` / `LICENSE` edit, no commit-pin move, no Render API call, no production touch.
- **Authoritative cross-references** (any disagreement: the linked source doc wins; this rp-drill ruling page is updated to align, never the other way around):
  - `renovapro-app/docs/deploy/phase-9b-module-g-strategy-2-redesign-ruling.md` — Module-G ruling (mechanism canon for the redesigned Strategy 2 path; pinned tokens; future Module F-0 / execution prerequisites in its §13; image-reference-by-digest binding rule).
  - `renovapro-app/docs/deploy/phase-9b-module-f0-preflight-protocol.md` — Module F-0 preflight protocol; eight named verdicts; `MODULE_F0_REQUIRED_BEFORE_MODULE_G_EXECUTION`.
  - `renovapro-app/docs/deploy/phase-9b-module-f-strategy-2-off-canon-smoke-incident.md` — PR #78 binding rule §8.
  - `renovapro-app/docs/deploy/phase-9b-module-f-strategy-1-closeout.md` — `MODULE_F_RETRY_STRATEGY_1_FAILED_CLEANED_UP`; root-cause class §6.3.
  - `renovapro-app/docs/deploy/phase-9b-snapshots-backups-posture.md` — Module E + E.1 + E.2 + E.3 + E.4 + Module-G + Module F-0 Follow-up chain.
  - `renovapro-app/docs/deploy/runbook.md` §11.2 / §11.3.
  - `renovapro-app/docs/deploy/phase-9b-status-index.md`.
  - `rp-drill/CLAUDE.md` (this repo's pointer governance file).
  - `rp-drill/README.md` (repo posture description).

## 2. Final ruling tokens

- `RP_DRILL_BUILD_IMAGE_MECHANISM_RULED`
- `RP_DRILL_BUILD_IMAGE_EXECUTION_NOT_AUTHORIZED`
- `RP_DRILL_GOVERNED_BY_RENOVAPRO_APP_CANON`
- `RP_DRILL_INHERITS_PR78_PR80_PR82_GOVERNANCE`

These tokens describe **what is ruled by this document**. They do **not** describe an execution event. None of them authorizes any image build, GHCR push, workflow run, digest capture, Dockerfile creation, workflow-file creation, Render mutation, Module F-0 execution, Module-G execution, Module F retry, Pro upgrade, password rotation, or second-admin action. None of them flips any `runbook.md` §11.2 checkbox in `renovapro-app`.

## 3. Baseline

- **rp-drill HEAD at the time of authoring this ruling**: `bb350f79512b629945f6bb831f86e794340b90a0`. This is also the rp-drill commit pin inherited by `renovapro-app` Module E.4 / Module-G.
- **`v.sh` SHA256 (computed read-only via `git cat-file -p HEAD:v.sh | sha256sum`)**: `daa6f65a6894d5cdb43df26277aed050be7a462a4d42c1ce90f12e97a241596d`. Exact match to `renovapro-app` Module E.4 / Module-G inherited pin.
- **`v.sh.sha256` sidecar content**: `daa6f65a6894d5cdb43df26277aed050be7a462a4d42c1ce90f12e97a241596d  v.sh`. Matches.
- **renovapro-app main HEAD at the time of authoring this ruling**: `9e0f10118e890813274ec966b5ac67d3863da3cb` (post-PR #82, the Module F-0 preflight protocol).
- **Tracked files in rp-drill at this HEAD**: `LICENSE`, `README.md`, `v.sh`, `v.sh.sha256` (4 files, no `Dockerfile`, no `.github/`, no `docs/` prior to this ruling, no GHCR package).
- **Inherited from `renovapro-app` Module E.4 / Module-G (do NOT change here)**:
  - `MC_RELEASE = mc.RELEASE.2025-08-13T08-35-41Z`.
  - `MC_SHA256 = 01f866e9c5f9b87c2b09116fa5d7c06695b106242d829a8bb32990c00312e891`.
  - target image path: `ghcr.io/edwargamez555-sys/rp-drill-client`.
  - runtime-reference rule: **digest only, never tag** — `ghcr.io/edwargamez555-sys/rp-drill-client@sha256:<digest>`.
  - six required success sentinels: `MODULE_F_STRATEGY2_CLIENT_STARTED`, `MODULE_F_STRATEGY2_MC_SHA256_OK`, `MODULE_F_STRATEGY2_ALIAS_OK`, `MODULE_F_STRATEGY2_BUCKETS_OK`, `MODULE_F_STRATEGY2_LS_OK`, `MODULE_F_STRATEGY2_VALIDATION_OK`.
  - failure sentinel: `MODULE_F_STRATEGY2_FAILED` + stage-specific exit codes 11–18.
  - two-resource Stage 1 shape: `rp-minio-drill` (server, MinIO image pinned per Module E.1) + `rp-minio-drill-client` (client; under Module-G, references the pre-baked image at `ghcr.io/edwargamez555-sys/rp-drill-client@sha256:<digest>`).
  - Render API token scope rule (denylist by production resource name; allow delete on `rp-minio-drill*` / `rp-minio-drill-client*`).
  - cleanup contract (3-signal Render cleanup + token revocation + local env scrubbing).
- **Pin not yet captured** (and **not** captured by this ruling): the runtime image digest. It is named in `renovapro-app` Module-G §6.2 as `TO BE CAPTURED at first build under a separately-authorized rp-drill build / image packet`. Module F-0 §7's expected verdict at the time of this ruling is `MODULE_F0_PREFLIGHT_NOT_READY_IMAGE_DIGEST_MISSING`.

## 4. Mechanism ruled (descriptive only — no executable artifacts created here)

This ruling describes the build/image mechanism at the document level. It does **not** create a Dockerfile or a workflow file. It does **not** build, push, tag, or pull any image. It does **not** capture any digest. Each of those is its own future, separately-authorized packet (see §10 + §11).

### 4.1 Target image

- **Registry**: GHCR (PUBLIC, matching `rp-drill`'s own PUBLIC posture).
- **Image path**: `ghcr.io/edwargamez555-sys/rp-drill-client`.
- **Visibility**: PUBLIC. The image is non-secret. It bakes only `v.sh` (already public in this repo) and the `mc` binary (already public at MinIO's archive URL). No env-var values, no Render keys, no MinIO credentials, no JWT secrets are baked into the image.

### 4.2 Runtime reference rule (BINDING for any future runtime use)

- **Digest only**: `ghcr.io/edwargamez555-sys/rp-drill-client@sha256:<digest>`.
- **Tags are forbidden at runtime.** Tags MAY exist in GHCR for human navigation (e.g., `rp-drill-client-<rp-drill-commit-SHA>`) but a Render Cron Job referencing the image at runtime MUST use `@sha256:<digest>` form, never `:<tag>` form. This is inherited from `renovapro-app` Module-G §5 and is restated here as binding for rp-drill's own canon.

### 4.3 Base image

- **Base**: `docker.io/library/alpine:<alpine-pin>`. The specific `<alpine-pin>` is **TO BE CAPTURED** in the future Dockerfile-creation packet (see §11) at the moment that packet is itself ruled. Until then, no Alpine version is implied here.
- **Discipline**: per Module E.2, the Alpine version is pinned in writing in the Dockerfile-creation packet's body and in the resulting Dockerfile's `FROM` line. No `:latest`, no floating tag, no implicit-default version.

### 4.4 Build-time payload embedding

- **`v.sh` embedding**: at build time, `v.sh` is `COPY`-ed from the rp-drill commit pin (`bb350f79512b629945f6bb831f86e794340b90a0`) to a stable absolute path inside the image (proposed: `/v.sh`). The COPY happens at image-build time; **no runtime fetch of the script** under Module-G.
- **`mc` binary embedding**: at build time, the `mc` binary is fetched from `https://dl.min.io/client/mc/release/linux-amd64/archive/mc.RELEASE.2025-08-13T08-35-41Z`, SHA256-verified at build time against `MC_SHA256 = 01f866e9c5f9b87c2b09116fa5d7c06695b106242d829a8bb32990c00312e891`, embedded at `/usr/local/bin/mc`, and made executable. **No runtime fetch of `mc` under Module-G.**
- **Both fetches happen at image-build time, never at runtime.** This is the structural difference from Module E.4 and is what removes the long / scripted `dockerCommand` runtime-parsing failure class.

### 4.5 Image runtime contract

- **`ENTRYPOINT`**: `["/bin/sh", "/v.sh"]`. The image's `ENTRYPOINT` runs the validation script directly. The Render Cron Job's `dockerCommand` is **empty / inert** under Module-G.
- **`USER`**: non-root recommended. Specific user value **TO BE CAPTURED** in the future Dockerfile-creation packet.
- **`WORKDIR`**: ephemeral path (e.g. `/tmp`). Specific value **TO BE CAPTURED** in the future Dockerfile-creation packet.
- **Env-vars baked into the image**: **NONE**. The drill-time `MINIO_DRILL_ACCESS_KEY` and `MINIO_DRILL_SECRET_KEY` are passed at runtime by the Render Cron Job per `renovapro-app` Module E.4 / Module-G; they are **never baked into the image** and **never appear in this rp-drill repo or in any docs-only PR here**.
- **Filesystem**: read-only acceptable. No persistent volume, no writable disk. The validation script writes to `/tmp` only and does not depend on persistence.

## 5. Build workflow shape (descriptive only — no workflow file authored here)

This section describes what a future GitHub Actions workflow under `.github/workflows/build-image.yml` must satisfy when it is itself authored under a separately-authorized future Dockerfile-creation packet. **No workflow file is created in this PR.** The workflow's existence, its precise step shape, its trigger surface, and its token scope are all documented requirements of the future packet, not of this ruling.

### 5.1 File path

- Proposed: `.github/workflows/build-image.yml`. Final path **TO BE CAPTURED** in the future Dockerfile-creation packet at the moment that packet is itself ruled.

### 5.2 Trigger surface

- **`workflow_dispatch` ONLY** in the rp-drill posture ruled here. No automatic build on push. No automatic build on PR. The first build is operator-driven and runs only under a separately-authorized future build-execution packet.
- **No scheduled triggers.** No `schedule:` block. No `cron:` block.

### 5.3 Workflow steps (descriptive, not authoritative — the future packet pins exact commands and versions)

1. Checkout `rp-drill` at the captured commit pin (`bb350f79512b629945f6bb831f86e794340b90a0`).
2. Read `v.sh` SHA256 from `v.sh.sha256` sidecar; verify it matches `daa6f65a6894d5cdb43df26277aed050be7a462a4d42c1ce90f12e97a241596d`. Fail the workflow if the SHA256 does not match.
3. Set up Docker buildx (no privileged actions beyond standard buildx).
4. Log in to GHCR using a workflow-scoped `GITHUB_TOKEN` (preferred) OR a dedicated PAT with `packages:write` scope only (fallback). Token-scope rule per §9 below.
5. Build the image (no push). Capture the local image's resulting digest.
6. Tag the image by both `<rp-drill-commit-SHA>` (for human navigation) AND by content digest (digest is the **BINDING runtime pin**; the SHA tag exists for human navigation only and **MUST NOT be used as runtime authority**).
7. Push the image to `ghcr.io/edwargamez555-sys/rp-drill-client`.
8. Emit the captured digest as a workflow output, structured to be auditable and copy-pastable into a follow-up `renovapro-app` docs-only PR that updates Module-G §6.2.

### 5.4 Concurrency

- **Single-run-at-a-time per ref.** A `concurrency:` block in the workflow file enforces serialization to prevent racing image builds.

### 5.5 Permissions

- **Minimum necessary.** `permissions: { packages: write, contents: read }`. No `actions:`, no `id-token:` (unless SLSA attestation is later adopted), no `pull-requests:`, no `issues:`, no `deployments:`, no `pages:`, no `security-events:`, no `statuses:`.

### 5.6 Secrets

- **NONE in this ruling.** Any secret required by the future workflow (e.g., a dedicated GHCR PAT, if `GITHUB_TOKEN` proves insufficient) is captured ONLY inside the future Dockerfile-creation packet's body; secret entry is authorized only there. This rp-drill ruling, this commit, this PR body, the runbook record, and any transcript MUST contain zero credential bytes.

## 6. Digest capture procedure

The digest capture procedure is the bridge between the future rp-drill build-execution packet and `renovapro-app`'s Module-G ruling.

1. The future rp-drill build-execution packet (separate authorization, not this ruling) runs `workflow_dispatch` against the future build workflow.
2. The workflow's step 5 (build) computes the image's content digest.
3. The workflow's step 8 emits the digest as a workflow output in the form `ghcr.io/edwargamez555-sys/rp-drill-client@sha256:<64hex>`.
4. The operator records the digest (and the workflow run id, the rp-drill commit pin, the build timestamp in UTC + Europe/Berlin) in the institutional runbook.
5. A **subsequent, separately-authorized `renovapro-app` docs-only PR** updates `phase-9b-module-g-strategy-2-redesign-ruling.md` §6.2 to replace the `TO BE CAPTURED` row for the image digest with the observed digest. That `renovapro-app` PR is its own authorization; this rp-drill ruling does not author it.
6. After that `renovapro-app` PR merges, a future Module F-0 execution packet (separate authorization) can run the Module F-0 preflight against the live `renovapro-app` main HEAD; the `MODULE_F0_PREFLIGHT_NOT_READY_IMAGE_DIGEST_MISSING` verdict is no longer emitted (the digest is now captured), and a `MODULE_F0_PREFLIGHT_READY_FOR_MODULE_G_EXECUTION_PACKET` verdict becomes possible.
7. After Module F-0 returns `READY`, a future Module-G execution packet (separate authorization) can be drafted. That Module-G execution packet is itself a distinct future authorization, anchored in PR #78 §8's binding rule.

## 7. Vulnerability-scan / supply-chain posture

- **GHCR / Dependabot / image-scan tooling output is INFORMATIONAL.** It does not gate this ruling, does not gate the future Dockerfile-creation packet, and does not gate the future build-execution packet. It MAY inform a future re-rule trigger if a critical-severity vulnerability is observed in the pinned Alpine base or in the embedded `mc` binary release.
- **SLSA-style provenance attestation is DESIRABLE, NOT REQUIRED.** Adoption is deferred to a future re-rule. If adopted, the workflow would gain `id-token: write` permission and a provenance-emit step; until then, neither is authorized.
- **No image signing requirement at this time.** Adoption of `cosign` / `notation` signing is deferred to a future re-rule.
- **Per-pull policy at runtime**: Render Cron Job's GHCR pull behavior on the Hobby (legacy) workspace is verified read-only at the future Module F-0 execution time, not assumed here.

## 8. Retention / rollback rules

- **Drill image versions are RETAINED in GHCR by label**: `rp-drill-client-<rp-drill-commit-SHA>` (e.g., `rp-drill-client-bb350f79512b629945f6bb831f86e794340b90a0`).
- **Retention horizon**: until this Module-G build/image ruling is itself superseded by a future ruling.
- **Deletion of any drill image version in GHCR is NOT authorized by this ruling.** Deletion requires a separate ruling packet that names: which image versions, on what cadence, by whom, with what audit record. Until that packet exists, no deletion in GHCR is permitted, even for "obviously stale" versions.
- **Rollback procedure**: a regression detected in a future image build is rolled back by:
  1. Reverting the digest pin in `renovapro-app` Module-G §6.2 under a separately-authorized `renovapro-app` docs-only PR back to the prior known-good digest.
  2. The rp-drill source-repo content stays unchanged (commit pin and `v.sh` are not implicated by image rollback).
  3. Render-side cleanup of any in-flight drill resources follows `renovapro-app` Module-G §11 + Strategy 1 closeout §7 + §8.

## 9. Token / credential discipline

- **GHCR write authority for the future build workflow**:
  - **Preferred**: workflow-scoped `GITHUB_TOKEN` with `permissions: { packages: write, contents: read }` only.
  - **Fallback**: a dedicated PAT with `packages:write` scope ONLY. **Never** `repo:write`, `workflow:write`, `admin:org`, or any broader scope.
- **PAT (if used) discipline**:
  - Minimum-necessary scope.
  - Expiration ≤ 7 days.
  - Revoked at the close of the future build-execution packet's run.
  - Never echoed in workflow logs, PR bodies, transcripts, runbooks, or shell history.
  - Never persisted to disk beyond the GitHub repository secret store, and the secret-store entry is deleted at packet close.
- **Render API token**: NOT used by this build path. GHCR push is a GitHub-side action; the future Module-G execution packet handles Render-side mutation under its own token-scope rule (inherited from Module E.4 / Module-G).
- **No credential value enters this ruling, this rp-drill repo, this commit, the PR body, the runbook record, or any transcript.** This rp-drill ruling captures structural facts only: scopes, expirations, discipline rules. Never values.

## 10. Forbidden actions in THIS rp-drill PR

- **Authoring a `Dockerfile`** — not even an "example" or "draft" or "for-reference-only" Dockerfile.
- **Authoring a `.github/workflows/*.yml`** file — not even one marked "manual-trigger only", "do-not-run", or "future use".
- **Authoring any executable script** beyond what already exists. (`v.sh` is preserved unchanged.)
- **Editing `v.sh`**, `v.sh.sha256`, or `LICENSE`.
- **Building, tagging, pushing, pulling, or deleting any image** (locally, in CI, in GHCR, in any other registry).
- **Logging in to GHCR**; **creating any PAT** with any scope; **storing any GHCR credential**.
- **Triggering any GitHub Action** (`workflow_dispatch`, push-trigger, manual-run, CLI-driven dispatch).
- **Editing any file in `renovapro-app/`**.
- **Running any local Docker command** (`docker pull`, `docker build`, `docker run`, `docker login`).
- **Running `v.sh`** locally or in any environment.
- **Running `mc`** locally or in any environment.
- **Fetching the MinIO `mc` binary** locally; **fetching the Alpine image** locally.
- **Any natural-language extension** that implies the build, the workflow creation, or the digest capture is now authorized.

## 11. Future steps (each is its own separately-authorized packet)

The Module-G validation image cannot exist as a runtime artifact until each of the following future packets is authored, ruled, and merged in order. Naming them here is **not** authorizing them.

1. **rp-drill Dockerfile-creation packet** — authors `Dockerfile` and `.github/workflows/build-image.yml` as **executable** artifacts in rp-drill. That packet captures: the Alpine pin, the precise Dockerfile shape (FROM, COPY, RUN, USER, WORKDIR, ENTRYPOINT lines), the precise workflow steps (`actions/checkout@<sha>`, `docker/setup-buildx-action@<sha>`, `docker/login-action@<sha>`, `docker/build-push-action@<sha>` or equivalent, with all action versions pinned by SHA), the workflow trigger (`workflow_dispatch` only), the workflow permissions (`packages: write`, `contents: read` only), and the workflow secrets posture (zero secrets if `GITHUB_TOKEN` suffices; minimum-scope PAT in a named secret if not). That packet does NOT run the workflow.
2. **rp-drill build-execution packet** — operator runs the workflow under separate authorization. The packet captures the workflow run id, the build timestamp, the resulting image digest, and the institutional-runbook record. That packet does NOT capture the digest into `renovapro-app` canon.
3. **renovapro-app digest-pin-capture packet** — a docs-only PR in `renovapro-app` updates Module-G §6.2 to replace the `TO BE CAPTURED` row for the image digest with the observed digest. That packet is its own authorization, anchored in this rp-drill ruling, in the build-execution packet's institutional-runbook record, and in PR #78 §8's binding rule.
4. **Module F-0 execution packet** — under `renovapro-app` authorization, runs the Module F-0 preflight (`renovapro-app/docs/deploy/phase-9b-module-f0-preflight-protocol.md`) against the live main HEAD and emits one of the eight named verdicts. With the digest captured (per packet #3), `MODULE_F0_PREFLIGHT_READY_FOR_MODULE_G_EXECUTION_PACKET` becomes possible.
5. **Module-G execution packet** — under `renovapro-app` authorization, runs the actual Render-side drill against `rp-minio-drill` + `rp-minio-drill-client` with the digest-pinned image. This is the packet that actually touches Render and produces the six required success sentinels. It is its own future authorization, distinct from every prior packet.

Each of the five packets above is a **distinct authorization**. None is implied by this ruling. None is implied by any prior packet. None is implied by any natural-language follow-up.

## 12. Re-rule triggers

This Module-G build/image ruling (rp-drill side) is **automatically reopened** (and any in-progress future packet must halt) if any of the following occurs:

- The rp-drill commit pin at `bb350f79512b629945f6bb831f86e794340b90a0` ceases to be valid (e.g., the commit is reverted, the branch is rewritten under a separately-authorized future ruling).
- The `v.sh` SHA256 at `daa6f65a6894d5cdb43df26277aed050be7a462a4d42c1ce90f12e97a241596d` ceases to match the git-blob SHA256 of `v.sh` at the captured commit pin.
- MinIO upstream changes the `mc` binary distribution layout, URL pattern, `MC_RELEASE` value, or `MC_SHA256` value.
- Alpine retires the proposed base-image pin, or a critical-severity vulnerability requires a base-pin change.
- GHCR retires its public-registry surface, changes per-pull policy, changes per-image rate limits, or changes its image-by-digest URI form.
- GitHub Actions changes the `GITHUB_TOKEN` `packages:write` semantics or removes the `permissions:` mechanism.
- Render's Cron Job product changes its image-runtime semantics (e.g., empty / inert `dockerCommand` acceptance, or image-by-digest reference handling).
- A critical-severity vulnerability is disclosed in the pinned Alpine base or in the pinned `mc` binary release.
- Any of `renovapro-app` Module E.4 / Module-G / Module F-0 / Strategy 1 closeout / off-canon smoke incident re-rule triggers fires.
- Any subsequent rp-drill PR proposes to change `v.sh`, `v.sh.sha256`, `LICENSE`, or the commit pin.

## 13. STOP conditions

A future reader, author, or operator must STOP and re-anchor in docs (not act) if any of the following holds:

- A natural-language follow-up appears to authorize a Dockerfile creation, a workflow file creation, an image build, a GHCR push / pull / tag / delete, a digest capture, a workflow run, a Render mutation, or any executable-artifact authoring within this PR — without a corresponding docs-anchored Authorization packet for that specific shape (PR #78 §8 binding rule).
- A reviewer or tool suggests "let's just author the Dockerfile now and see if it builds" or any equivalent natural-language shortcut. STOP — point at §10 + §11; decline.
- A reviewer or tool suggests editing `v.sh` / `v.sh.sha256` / commit pin / `LICENSE`. STOP — those are pinned in `renovapro-app` canon; any change requires reopening Module E.4 + Module-G + Module F-0.
- A reviewer or tool proposes an empty-`dockerCommand` smoke against Render to "see what happens." STOP — that is a Module-G execution packet's responsibility, not this ruling's.
- A reviewer or tool proposes building the image locally for "testing." STOP — local build is itself a build event; this ruling does not authorize any build.
- The `v.sh` git-blob SHA256 changes between the time this ruling is drafted and the time it is merged. STOP — re-anchor against the source of truth (`renovapro-app` Module E.4 + Module-G inherited pin).
- Any leftover Render resource matching `rp-minio-drill*`, `rp-minio-drill-client*`, `rp-ps-probe*`, `rp-pg-drill*`, or `rp-minio-drill-client-cmd*` is observed in the Render workspace. STOP — route through Module F-0 cleanup before any rp-drill action.
- Any production resource (`rp-pg-prod`, `rp-redis-prod`, `rp-minio-prod`, `rp-api-prod`, `rp-web-prod`, `rp-worker-prod`, `renovapro-prod` Blueprint, `rp-shared-prod` / `rp-api-prod` envVarGroups, `rp-minio-data-prod` disk) is observed mutated since the last reconciliation point.
- Any `*-prod` snapshot / recovery / export / PITR action is observed initiated outside a docs-anchored packet.

## 14. Non-authorization

This rp-drill ruling is documentation only. It does **NOT** authorize:

- Any image build of any kind (local, CI-side, or in any other environment).
- Any GHCR push, pull, tag, digest move, or deletion in this PR or under any natural-language follow-up.
- Any `Dockerfile` creation in this PR.
- Any `.github/workflows/*.yml` file creation in this PR.
- Any executable-artifact creation (script, binary, action, Make target) in this PR.
- Any `v.sh` / `v.sh.sha256` / `LICENSE` edit; any rp-drill commit-pin move.
- Any GitHub Actions workflow run; any `workflow_dispatch`; any push-trigger; any manual run.
- Any GHCR PAT creation, storage, use, or rotation; any registry login.
- Any Render REST API call; any Render Dashboard click; any Render API token creation, storage, or use.
- Any Manual Sync of `renovapro-prod`; any Manual Deploy on any Render service; any env-var read or write on any Render envVarGroup; any cron trigger.
- Any `rp-minio-prod` Restore button click (FORBIDDEN for drills, unchanged).
- Any Docker pull / Docker run / Docker build (local, CI-side, or Render-side).
- Any `mc` / S3 SDK / MinIO server interaction in any environment.
- Any local fetch of the MinIO archive or Alpine image; any local install of `mc` / `render` CLI / Alpine.
- Any local execution of `v.sh`.
- Any modification to `renovapro-app/**`.
- Any modification to `render.yaml`, `render.prod.yaml`, `prisma/**`, `apps/**`, `packages/**` in `renovapro-app`.
- Any execution of tests, builds, lint, smokes, Playwright, or `pnpm` scripts in any repo.
- Any Module F retry execution under any strategy; any Module-G execution; any Module F-0 execution; any Module F+1 / Stage 2 execution.
- Any digest capture into `renovapro-app` canon (that is the `renovapro-app` digest-pin-capture packet, distinct from this rp-drill ruling).
- Any Pro plan-change click of any label ("Update Plan", "Subscribe", "Confirm", "Pay", "Activate", "Upgrade", "Switch", "Move", "Migrate"); any payment-method change; any 7-day PITR observation.
- Any production password rotation; any second admin / break-glass account creation; any bootstrap CLI re-run.
- Any insertion of any row into any of the 11 real-data tables enumerated in `renovapro-app/docs/deploy/runbook.md` §11.2.
- Any flip of any `runbook.md` §11.2 checkbox; any opening of the real-data gate; any marking of the snapshots/backups posture clear; any marking of MinIO Stage 1 satisfied.

This ruling reaffirms — and does not change — every prior verdict, every prior gate, and every prior non-authorization across the `renovapro-app` Phase 9b lineage. Execution of the future rp-drill build / image / digest-capture path requires the five distinct future packets enumerated in §11, each authored as its own docs-anchored Authorization packet, anchored in PR #78 §8's binding rule.

## 15. Cross-link with PR #78 binding rule

The binding rule introduced by `renovapro-app/docs/deploy/phase-9b-module-f-strategy-2-off-canon-smoke-incident.md` §8 — **"natural-language follow-ups never carry execution authorization across turns; every Module-F-shaped Render mutation requires its own docs-anchored Authorization packet; exploratory parser/runtime smokes must be ruled in docs before execution"** — applies in full to this rp-drill ruling.

Operational consequences specific to rp-drill:

1. Ruling this build/image mechanism (this document, in this PR) is **not** authorizing the build, the workflow creation, the Dockerfile creation, the GHCR push, the digest capture, the Module F-0 execution, the Module-G execution, or any subsequent step. Each is its own future authorization.
2. A conversational suggestion — even one that names a specific tweak ("just add the Dockerfile", "let's see if the workflow runs", "build it once locally to validate", "push it to GHCR and we'll check the digest", "swap the Alpine pin", "try a different `mc` release") — does **not** authorize any image build, any GHCR operation, any rp-drill executable-artifact authoring, or any Render mutation.
3. A future build-related event in rp-drill must additionally satisfy every prerequisite enumerated in §10 + §11 of this document, plus the Module E.4 / Module-G / Module F-0 prerequisites in `renovapro-app` canon, plus a separately-authorized future packet that names the specific event being authorized.
4. Exploratory variants of the build mechanism (alternate registries, alternate base images, alternate `dockerCommand` shapes other than empty / inert, alternate fetch endpoints, alternate `mc` releases, alternate `v.sh` versions) are themselves a mutation surface and must be ruled in their own docs-anchored packets before execution.

PR #78's binding rule is additive to — not a replacement for — the Strategy 1 closeout's forward gate, the Module E.4 non-authorization block, Module-G's non-authorization block, Module F-0's non-authorization block, and this rp-drill ruling's §10 + §14 non-authorization.
