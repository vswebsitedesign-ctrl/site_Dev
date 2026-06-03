#!/bin/bash
# session_end.sh — merges session branch to main, pushes, cleans snapshots
# Usage: bash session_end.sh "commit message"
MSG=${1:-"Session complete"}
BRANCH=$(git -C /home/chubert/omni-builder/sites/site_Dev rev-parse --abbrev-ref HEAD)
if [ "$BRANCH" = "main" ]; then
  echo "❌ Already on main — run session_start.sh first"
  exit 1
fi
git -C /home/chubert/omni-builder/sites/site_Dev add -A
git -C /home/chubert/omni-builder/sites/site_Dev commit -m "$MSG"
git -C /home/chubert/omni-builder/sites/site_Dev checkout main
git -C /home/chubert/omni-builder/sites/site_Dev merge "$BRANCH"
git -C /home/chubert/omni-builder/sites/site_Dev push origin main
git -C /home/chubert/omni-builder/sites/site_Dev branch -d "$BRANCH"
rm -rf /home/chubert/omni-builder/sites/site_Dev/snapshots/
echo "✅ Merged $BRANCH to main, pushed, snapshots cleaned"
