#!/bin/sh
#
# v.sh -- RenovaPro Module F Strategy 2 MinIO drill validation script.
#
# Intended ONLY for Render Cron Job pickup under a separately authorized
# Module F Strategy 2 execution packet. NOT for local execution.
#
# Governance: renovapro-app docs/deploy/phase-9b-snapshots-backups-posture.md
# Module E lineage. If this script disagrees with that document, that document
# wins.
#
# Non-secret. Non-production. Targets only the temporary internal drill server
# rp-minio-drill:9000 inside Render's private network. Does NOT touch any
# production resource. Does NOT touch staging.

set -eu

# --- Pinned constants ---------------------------------------------------------
# MC release pinned at script-publication time. Bumping these requires a new
# PR-X commit + a new v.sh.sha256 + a new renovapro-app Module E.4 amendment.
MC_RELEASE="mc.RELEASE.2025-08-13T08-35-41Z"
MC_SHA256="01f866e9c5f9b87c2b09116fa5d7c06695b106242d829a8bb32990c00312e891"
MC_BASE_URL="https://dl.min.io/client/mc/release/linux-amd64/archive"

# Drill-only endpoint. Render private DNS; non-secret. Hardcoded to remove an
# environment-variable surface.
DRILL_ENDPOINT="http://rp-minio-drill:9000"

# Drill bucket names. Match the production names by intent (same shape) but
# live on a SEPARATE server under a SEPARATE alias, so there is no risk of
# touching the production buckets.
BUCKET_MEDIA="renovapro-media"
BUCKET_DOCS="renovapro-documents"

ALIAS_NAME="rp-drill"

echo "MODULE_F_STRATEGY2_CLIENT_STARTED"

# --- Step 1: fetch mc binary --------------------------------------------------
wget -qO /tmp/mc "${MC_BASE_URL}/${MC_RELEASE}" || {
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 11
}

# --- Step 2: verify mc sha256 -------------------------------------------------
COMPUTED_MC_SHA256="$(sha256sum /tmp/mc | awk '{print $1}')"
if [ "${COMPUTED_MC_SHA256}" != "${MC_SHA256}" ]; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 12
fi
echo "MODULE_F_STRATEGY2_MC_SHA256_OK"

chmod +x /tmp/mc

# --- Step 3: configure mc alias ----------------------------------------------
# Access key + secret key are passed as positional args. Their values are
# never echoed. Stdout/stderr of mc alias set is suppressed because mc may
# print configuration banners that could include host/key shape on some
# versions.
if ! /tmp/mc alias set "${ALIAS_NAME}" "${DRILL_ENDPOINT}" \
        "${MINIO_DRILL_ACCESS_KEY}" "${MINIO_DRILL_SECRET_KEY}" \
        >/dev/null 2>&1; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 13
fi
echo "MODULE_F_STRATEGY2_ALIAS_OK"

# --- Step 4: create / ensure buckets -----------------------------------------
# -p makes mc mb idempotent: if the bucket already exists it succeeds quietly.
if ! /tmp/mc mb -p "${ALIAS_NAME}/${BUCKET_MEDIA}" >/dev/null 2>&1; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 14
fi
if ! /tmp/mc mb -p "${ALIAS_NAME}/${BUCKET_DOCS}" >/dev/null 2>&1; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 15
fi
echo "MODULE_F_STRATEGY2_BUCKETS_OK"

# --- Step 5: list buckets and verify both names appear -----------------------
# Capture mc ls output to a tempfile so we can grep without echoing raw mc
# output (which can include sizes, dates, or other shape that we want to
# avoid surfacing).
LS_OUT="$(mktemp)"
trap 'rm -f "${LS_OUT}"' EXIT INT TERM

if ! /tmp/mc ls "${ALIAS_NAME}" >"${LS_OUT}" 2>/dev/null; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 16
fi

if ! grep -q "${BUCKET_MEDIA}" "${LS_OUT}"; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 17
fi
if ! grep -q "${BUCKET_DOCS}" "${LS_OUT}"; then
    echo "MODULE_F_STRATEGY2_FAILED"
    exit 18
fi
echo "MODULE_F_STRATEGY2_LS_OK"

# --- Step 6: full success ----------------------------------------------------
echo "MODULE_F_STRATEGY2_VALIDATION_OK"
exit 0
