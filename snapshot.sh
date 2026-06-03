#!/bin/bash
# snapshot.sh — snapshots current state before risky changes
# Usage: bash snapshot.sh "label"
LABEL=${1:-"snapshot"}
TIMESTAMP=$(date +%Y%m%d-%H%M%S)
SNAPSHOT_DIR="/home/chubert/omni-builder/sites/site_Dev/snapshots/${TIMESTAMP}-${LABEL}"
mkdir -p "$SNAPSHOT_DIR"
cp /home/chubert/omni-builder/sites/site_Dev/theme/base.html "$SNAPSHOT_DIR/"
cp /home/chubert/omni-builder/sites/site_Dev/data/pages.json "$SNAPSHOT_DIR/"
cp /home/chubert/omni-builder/sites/site_Dev/build.py "$SNAPSHOT_DIR/"
echo "✅ Snapshot saved to: $SNAPSHOT_DIR"
