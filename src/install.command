#!/bin/bash
set -euo pipefail

RESOURCE_DIR="$(cd "$(dirname "$0")" && pwd)"
TOOL="$RESOURCE_DIR/macos-hidpi"

clear
echo "macOS HiDPI installer"
echo
echo "This will add HiDPI scaled modes for a display you choose."
echo "The default modes are inferred from the selected display's native aspect ratio."
echo
echo "Connected displays:"
"$TOOL" list
echo
"$TOOL" install
echo
echo "Done. Restart macOS, then open System Settings > Displays."
echo
read -r -n 1 -s -p "Press any key to close this window..."
echo
