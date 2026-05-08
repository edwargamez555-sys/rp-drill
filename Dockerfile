# syntax=docker/dockerfile:1.7
#
# Module-G validation image for the future Render Cron Job rp-minio-drill-client.
#
# Mechanism canon: rp-drill/docs/module-g-prebaked-image-ruling.md
# Renovapro-app canon: docs/deploy/phase-9b-module-g-strategy-2-redesign-ruling.md
# (including §22 runtime mc fetch posture clarification)
# PR #78 §8 binding rule applies in full.
#
# Posture (Path B per the Module-G runtime mc fetch clarification):
#   - This image bakes ONLY v.sh and its runtime dependencies (wget,
#     ca-certificates).
#   - mc is NOT baked into the image. v.sh fetches mc from dl.min.io at
#     runtime and SHA256-verifies it against MC_SHA256 (01f866e9...2e891)
#     baked as a constant inside v.sh itself.
#   - The structural fix vs Strategy 1 is the empty/inert Render Cron Job
#     dockerCommand field; Render's shell parser is bypassed because this
#     image's ENTRYPOINT runs v.sh directly.
#
# This Dockerfile is NOT executed by the Dockerfile-creation packet. The
# build is a separate, future, separately-authorized rp-drill build-execution
# packet.

# Alpine pinned by tag + content digest (OCI image index).
# Tag chosen at Dockerfile-creation packet authorship time: 3.22.4 (latest
# patch in the maintained 3.22 stream as of authorship).
# Digest captured read-only via Docker Hub registry HTTP API (no docker pull).
FROM docker.io/library/alpine:3.22.4@sha256:310c62b5e7ca5b08167e4384c68db0fd2905dd9c7493756d356e893909057601

# Minimal runtime dependencies for v.sh.
# - ca-certificates: HTTPS to dl.min.io for the runtime mc fetch.
# - wget: v.sh uses wget to fetch mc at runtime.
# Package versions are not pinned here. The Alpine base image digest pin above
# is the primary base-image pin; APK package versions are tied to the Alpine
# release in the chosen base. Pinning APK package versions explicitly would
# make future builds brittle as Alpine's APK repo retention is short.
RUN apk add --no-cache \
        ca-certificates \
        wget \
    && update-ca-certificates

# Bake v.sh and its sha256 sidecar from the rp-drill commit pin
# bb350f79512b629945f6bb831f86e794340b90a0.
COPY v.sh /v.sh
COPY v.sh.sha256 /v.sh.sha256

# Verify v.sh SHA256 at BUILD time (defense-in-depth: build fails if v.sh
# bytes drift from the inherited canon pin daa6f65a...1596d).
RUN cd / \
    && sha256sum -c /v.sh.sha256 \
    && chmod +x /v.sh

# Non-root user. Drill containers do not need privileged operations.
# 65534:65534 is the conventional 'nobody:nogroup' uid:gid in Alpine.
USER 65534:65534

# Ephemeral working directory; v.sh writes mc to /tmp at runtime.
WORKDIR /tmp

# v.sh runs directly. The Render Cron Job's dockerCommand under Module-G is
# empty/inert; this ENTRYPOINT delivers the validation logic, bypassing
# Render's shell parser entirely.
ENTRYPOINT ["/bin/sh", "/v.sh"]
