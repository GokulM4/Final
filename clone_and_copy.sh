#!/bin/bash

REPO_URL="https://github.com/GokulM4/Final.git"
BASE_DIR="/d/Repo"

FOLDER1="$BASE_DIR/Gokul"
FOLDER2="$BASE_DIR/Murugan"
BACKUP_DIR="$BASE_DIR/Backup"

mkdir -p "$BASE_DIR" "$BACKUP_DIR" "$FOLDER2"

# Function to check if folder is empty
is_empty() {
    [ -z "$(ls -A "$1")" ]
}

# === Check if FOLDER1 exists ===
if [ -d "$FOLDER1" ]; then
    echo "✅ $FOLDER1 exists."

    if is_empty "$FOLDER1"; then
        echo "📂 $FOLDER1 is empty. Cloning repository..."
        cd "$FOLDER1" || { echo "❌ Failed to enter $FOLDER1"; exit 1; }
        git clone "$REPO_URL" .
    else
        echo "⚠️ $FOLDER1 is not empty."

        TIMESTAMP=$(date +"%b-%d-%Y_%H-%M-%S")
        BACKUP_FOLDER="$BACKUP_DIR/New_folder1_backup_$TIMESTAMP"

        echo "🗂️ Creating backup at: $BACKUP_FOLDER"
        mkdir -p "$BACKUP_FOLDER"
        cp -r "$FOLDER1"/* "$BACKUP_FOLDER"/ 2>/dev/null

        echo "🧹 Clearing $FOLDER1 (including hidden files)..."
        rm -rf "$FOLDER1"/* "$FOLDER1"/.[!.]* "$FOLDER1"/..?* 2>/dev/null

        echo "⬇️ Cloning repository again into $FOLDER1..."
        cd "$FOLDER1" || { echo "❌ Failed to enter $FOLDER1"; exit 1; }
        git clone "$REPO_URL" .
    fi
else
    echo "❌ $FOLDER1 does not exist. Creating now..."
    mkdir -p "$FOLDER1"
    cd "$FOLDER1" || { echo "❌ Failed to enter $FOLDER1"; exit 1; }
    echo "📥 Cloning repository into newly created folder..."
    git clone "$REPO_URL" .
fi

# === Clean FOLDER2 before copying ===
echo "🧹 Clearing $FOLDER2 before copying..."
rm -rf "$FOLDER2"/* "$FOLDER2"/.[!.]* "$FOLDER2"/..?* 2>/dev/null

# === Copy files from Folder1 to Folder2 ===
echo "📁 Copying files from $FOLDER1 to $FOLDER2..."
cp -r "$FOLDER1/." "$FOLDER2/"

echo
echo "✅ All operations completed successfully!"
