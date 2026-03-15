#!/bin/zsh
set -e

INSTALL_DIR="$HOME/.local/share/organize-folder"
BIN_DIR="$HOME/.local/bin"
APP_DEST="$HOME/Applications/Organize Folder.app"

echo "Uninstalling organize-folder..."
echo ""

# Remove app
if [[ -d "$APP_DEST" ]]; then
  rm -rf "$APP_DEST"
  echo "  Removed: $APP_DEST"
fi

# Remove CLI symlink
if [[ -L "$BIN_DIR/organize-folder" ]]; then
  rm -f "$BIN_DIR/organize-folder"
  echo "  Removed: $BIN_DIR/organize-folder"
fi

# Remove installed scripts
if [[ -d "$INSTALL_DIR" ]]; then
  rm -rf "$INSTALL_DIR"
  echo "  Removed: $INSTALL_DIR"
fi

# Clean temp files
rm -f /tmp/organize-preview.html /tmp/organize-raw.txt

echo ""
echo "Uninstalled."
