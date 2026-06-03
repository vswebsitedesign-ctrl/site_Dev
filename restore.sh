#!/bin/bash
# restore.sh — instant restore from snapshot
# Usage: bash restore.sh snapshots/TIMESTAMP-label
SNAPSHOT_DIR=$1
if [ -z "$SNAPSHOT_DIR" ]; then
  echo "❌ Usage: bash restore.sh snapshots/TIMESTAMP-label"
  echo "Available snapshots:"
  ls /home/chubert/omni-builder/sites/site_Dev/snapshots/
  exit 1
fi
cp "$SNAPSHOT_DIR/base.html" /home/chubert/omni-builder/sites/site_Dev/theme/base.html
cp "$SNAPSHOT_DIR/pages.json" /home/chubert/omni-builder/sites/site_Dev/data/pages.json
cp "$SNAPSHOT_DIR/build.py" /home/chubert/omni-builder/sites/site_Dev/build.py
echo "✅ Restored from: $SNAPSHOT_DIR"
