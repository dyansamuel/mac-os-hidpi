#!/bin/bash
set -euo pipefail

RESOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
TOOL="$RESOURCE_DIR/cforce-hidpi"

clear
echo "CFORCE HiDPI installer"
echo
echo "This will add HiDPI scaled modes for the CFORCE 2560x1600 display:"
echo "  2048x1280, 1920x1200, 1800x1125, 1680x1050, 1600x1000, 1440x900, 1280x800"
echo
"$TOOL" install
echo
echo "Done. Restart macOS, then open System Settings > Displays."
echo
read -r -n 1 -s -p "Press any key to close this window..."
echo
