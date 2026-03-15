#!/bin/zsh
set -e

REPO_DIR="${0:A:h}"
INSTALL_DIR="$HOME/.local/share/organize-folder"
BIN_DIR="$HOME/.local/bin"
APP_NAME="Organize Folder"
APP_DEST="$HOME/Applications/$APP_NAME.app"

echo "Installing organize-folder..."
echo ""

# 1. Create install directories
mkdir -p "$INSTALL_DIR/bin"
mkdir -p "$BIN_DIR"

# 2. Copy scripts
cp "$REPO_DIR/bin/organize-folder" "$INSTALL_DIR/bin/organize-folder"
cp "$REPO_DIR/bin/organize-preview" "$INSTALL_DIR/bin/organize-preview"
chmod +x "$INSTALL_DIR/bin/organize-folder"
chmod +x "$INSTALL_DIR/bin/organize-preview"

# 3. Create symlink for CLI usage
ln -sf "$INSTALL_DIR/bin/organize-folder" "$BIN_DIR/organize-folder"

# 4. Build the macOS app
echo "Building $APP_NAME.app..."
TEMP_SCRIPT="/tmp/organize-folder-build.applescript"
sed "s|__INSTALL_DIR__|$INSTALL_DIR|g" "$REPO_DIR/app/organize-folder.applescript" > "$TEMP_SCRIPT"

mkdir -p "$HOME/Applications"
osacompile -o "$APP_DEST" "$TEMP_SCRIPT"
rm -f "$TEMP_SCRIPT"

# 5. Copy custom icon if available
if [[ -f "$REPO_DIR/app/icon.icns" ]]; then
  cp "$REPO_DIR/app/icon.icns" "$APP_DEST/Contents/Resources/applet.icns"
fi

echo ""
echo "Installed successfully!"
echo ""
echo "  App:  $APP_DEST"
echo "  CLI:  $BIN_DIR/organize-folder"
echo ""
echo "Usage:"
echo "  - Double-click '$APP_NAME' in ~/Applications"
echo "  - Or from terminal: organize-folder ~/Downloads"
echo ""

# Check if ~/.local/bin is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo "Note: Add this to your ~/.zshrc for CLI access:"
  echo "  export PATH=\"\$HOME/.local/bin:\$PATH\""
  echo ""
fi

echo "Done."
