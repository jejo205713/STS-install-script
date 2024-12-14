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
# Extract the base name of the tar.gz file (without path)
PACKAGE_NAME=$(basename "$STS_PACKAGE_PATH")
echo "Unzipping the package: $PACKAGE_NAME"
sudo tar -xvf "$PACKAGE_NAME"

# Dynamically detect the extracted folder name (assuming one folder is created)
EXTRACTED_DIR=$(tar -tf "$PACKAGE_NAME" | head -n 1 | cut -d/ -f1)

# Ensure the directory exists
if [ ! -d "$EXTRACTED_DIR" ]; then
  echo "Error: Extracted directory not found: $EXTRACTED_DIR"
  exit 1
fi

cd "$EXTRACTED_DIR"

# Step 4: Create the .desktop entry for STS
DESKTOP_ENTRY_PATH="/usr/share/applications/STS.desktop"

echo "Creating desktop entry at $DESKTOP_ENTRY_PATH..."

sudo bash -c "cat <<EOF > $DESKTOP_ENTRY_PATH
[Desktop Entry]
Name=SpringSource Tool Suite
Comment=Spring Tool Suite
Exec=/opt/$EXTRACTED_DIR/SpringToolSuite4
Icon=/opt/$EXTRACTED_DIR/icon.xpm
StartupNotify=true
Terminal=false
Type=Application
Categories=Development;IDE;Java;
EOF"

# Step 5: Provide user feedback
echo "Desktop entry created successfully!"
echo "You can now launch Spring Tool Suite from your application menu."

# Optional: Provide a verification step
echo "Verifying the installation..."
cd /opt/$EXTRACTED_DIR
ls
