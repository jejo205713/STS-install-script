#!/bin/bash

# Check if the STS directory exists
STS_DIR="/opt"
STS_BINARY_PATTERN="sts-*.RELEASE/SpringToolSuite4"
STS_ICON_PATTERN="sts-*.RELEASE/icon.xpm"

# Find the latest version of STS
LATEST_STS_DIR=$(ls -d ${STS_DIR}/${STS_BINARY_PATTERN} | sort -V | tail -n 1)
LATEST_ICON_PATH=$(ls ${LATEST_STS_DIR}/icon.xpm 2>/dev/null)

if [[ ! -d "$LATEST_STS_DIR" || -z "$LATEST_ICON_PATH" ]]; then
  echo "SpringSource Tool Suite is not installed or the icon file is missing."
  exit 1
fi

# Extract version info (assuming the directory name follows sts-*.RELEASE format)
VERSION=$(basename "$LATEST_STS_DIR" | sed -E 's/^sts-([0-9]+\.[0-9]+\.[0-9]+)\.RELEASE$/\1/')

# Desktop Entry File
DESKTOP_ENTRY_PATH="$HOME/.local/share/applications/spring-tool-suite-${VERSION}.desktop"

# Create the desktop entry content
cat <<EOF > "$DESKTOP_ENTRY_PATH"
[Desktop Entry]
Name=SpringSource Tool Suite $VERSION
Comment=Spring Tool Suite - Version $VERSION
Exec=$LATEST_STS_DIR/SpringToolSuite4
Icon=$LATEST_ICON_PATH
StartupNotify=true
Terminal=false
Type=Application
Categories=Development;IDE;Java;
EOF

# Set correct permissions for the desktop entry file
chmod +x "$DESKTOP_ENTRY_PATH"

# Provide feedback
echo "Desktop entry created at $DESKTOP_ENTRY_PATH"
echo "You can now search for 'SpringSource Tool Suite $VERSION' in your application menu."
echo "ORIGINALLY MADE FOR MY BUBUCHI ! "

#CREDITS:
JEJO.J
