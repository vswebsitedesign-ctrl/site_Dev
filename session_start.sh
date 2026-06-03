#!/bin/bash
# session_start.sh — creates timestamped session branch, protects main
BRANCH="session-$(date +%Y%m%d-%H%M%S)"
git -C /home/chubert/omni-builder/sites/site_Dev checkout -b "$BRANCH"
echo "✅ Session branch created: $BRANCH"
echo "✅ main is protected — commit to $BRANCH only"
