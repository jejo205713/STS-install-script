#!/bin/bash

# Exit if any command fails
set -e

# Step 1: Prompt user for the STS version or use the latest downloaded version
echo "Enter the path to the STS tar.gz package (or press Enter to use the most recent .tar.gz file in the current directory):"
read STS_PACKAGE_PATH

if [ -z "$STS_PACKAGE_PATH" ]; then
  # If no path was provided, find the most recent .tar.gz file in the current directory
  STS_PACKAGE_PATH=$(ls -t *.tar.gz | head -n 1)
fi

# Ensure the file exists
if [ ! -f "$STS_PACKAGE_PATH" ]; then
  echo "Error: STS package not found: $STS_PACKAGE_PATH"
  exit 1
fi

# Step 2: Move the file to the /opt directory
echo "Copying $STS_PACKAGE_PATH to /opt directory..."
sudo mv "$STS_PACKAGE_PATH" /opt/

# Step 3: Extract the package in /opt
cd /opt
PACKAGE_NAME=$(basename "$STS_PACKAGE_PATH")
echo "Unzipping the package: $PACKAGE_NAME"
sudo tar -xvf "$PACKAGE_NAME"

# Extract the folder name dynamically
STS_DIR=$(tar -tf "$PACKAGE_NAME" | head -n 1 | cut -d'/' -f1)
cd "$STS_DIR"

# Step 4: Create the .desktop entry for STS
DESKTOP_ENTRY_PATH="/usr/share/applications/STS.desktop"

echo "Creating desktop entry at $DESKTOP_ENTRY_PATH..."

sudo bash -c "cat <<EOF > $DESKTOP_ENTRY_PATH
[Desktop Entry]
Name=SpringSource Tool Suite
Comment=Spring Tool Suite
Exec=/opt/$STS_DIR/SpringToolSuite4
Icon=/opt/$STS_DIR/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Categories=Development;IDE;Java;
EOF"

# Step 5: Refresh the desktop database
echo "Refreshing desktop database..."
sudo update-desktop-database

# Step 6: Test the .desktop file
echo "Testing the .desktop file launch..."
if gtk-launch STS; then
  echo "Spring Tool Suite launched successfully!"
else
  echo "Failed to launch Spring Tool Suite. Please check the .desktop file."
fi

# Step 7: Provide feedback
echo "Installation and configuration complete!"
echo "You can now launch Spring Tool Suite from your application menu."
echo "originally made for ma bubuchi !"

#credits:JEJO.J
