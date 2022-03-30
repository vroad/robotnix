#!/usr/bin/env bash
# SPDX-FileCopyrightText: 2021 Daniel Fullmer and robotnix contributors
# SPDX-License-Identifier: MIT

set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"

# https://docs.waydro.id/development/compile-waydroid-lineage-os-based-images
repo init -u https://github.com/LineageOS/android.git -b lineage-17.1
wget -O - https://raw.githubusercontent.com/waydroid/android_vendor_waydroid/lineage-17.1/manifest_scripts/generate-manifest.sh | bash
cp .repo/local_manifests/*.xml ./local_manifests/

args=(
    "https://github.com/LineageOS/android.git"
    "lineage-17.1" # static branch name
    --ref-type branch
    --local-manifest local_manifests/00-remotes.xml
    --local-manifest local_manifests/01-removes.xml
    --local-manifest local_manifests/02-waydroid.xml
)

export TMPDIR=/tmp

../../scripts/mk_repo_file.py "${args[@]}"
