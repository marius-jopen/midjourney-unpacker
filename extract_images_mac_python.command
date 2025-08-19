#!/bin/bash

# Midjourney Image Extractor
# Double-click this file to extract images from input folders to output folder

# Get the directory where this script is located
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Change to the script directory
cd "$DIR"

echo "🖼️  Midjourney Image Extractor"
echo "Starting extraction process..."
echo ""

# Run the Python script
python3 script/image_extractor.py

# Keep the terminal window open so user can see the results
echo ""
echo "Press any key to close this window..."
read -n 1 -s
