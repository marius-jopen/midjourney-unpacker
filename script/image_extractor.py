#!/usr/bin/env python3
"""
Image Extractor Script
Extracts all images from subdirectories in the input folder to the output folder.
Supports common image formats: jpg, jpeg, png, gif, bmp, tiff, webp
"""

import os
import shutil
import sys
from pathlib import Path

def get_image_extensions():
    """Return a set of supported image file extensions."""
    return {'.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.tif', '.webp'}

def is_image_file(file_path):
    """Check if a file is an image based on its extension."""
    return file_path.suffix.lower() in get_image_extensions()

def extract_images():
    """Extract all images from input subdirectories to output directory."""
    # Get the script directory and project root
    script_dir = Path(__file__).parent
    project_root = script_dir.parent
    
    input_dir = project_root / 'input'
    output_dir = project_root / 'output'
    
    # Create output directory if it doesn't exist
    output_dir.mkdir(exist_ok=True)
    
    # Check if input directory exists
    if not input_dir.exists():
        print(f"❌ Input directory not found: {input_dir}")
        return False
    
    print(f"🔍 Scanning input directory: {input_dir}")
    print(f"📁 Output directory: {output_dir}")
    print("-" * 50)
    
    total_extracted = 0
    
    # Walk through all subdirectories in input folder
    for root, dirs, files in os.walk(input_dir):
        root_path = Path(root)
        
        # Skip the input directory itself, only process subdirectories
        if root_path == input_dir:
            continue
            
        folder_name = root_path.name
        print(f"📂 Processing folder: {folder_name}")
        
        extracted_from_folder = 0
        
        for file in files:
            file_path = root_path / file
            
            if is_image_file(file_path):
                # Create unique filename to avoid conflicts
                # Format: foldername_originalfilename.ext
                new_filename = f"{folder_name}_{file}"
                output_path = output_dir / new_filename
                
                # Handle filename conflicts by adding a number
                counter = 1
                while output_path.exists():
                    name_part = file_path.stem
                    ext_part = file_path.suffix
                    new_filename = f"{folder_name}_{name_part}_{counter}{ext_part}"
                    output_path = output_dir / new_filename
                    counter += 1
                
                try:
                    shutil.copy2(file_path, output_path)
                    print(f"  ✅ {file} → {new_filename}")
                    extracted_from_folder += 1
                    total_extracted += 1
                except Exception as e:
                    print(f"  ❌ Failed to copy {file}: {e}")
        
        if extracted_from_folder == 0:
            print(f"  ℹ️  No images found in {folder_name}")
        else:
            print(f"  📊 Extracted {extracted_from_folder} images from {folder_name}")
        
        print()
    
    print("-" * 50)
    print(f"🎉 Extraction complete! Total images extracted: {total_extracted}")
    
    if total_extracted == 0:
        print("ℹ️  No images were found in any subdirectories.")
        print("   Make sure you have:")
        print("   - Folders inside the 'input' directory")
        print("   - Image files (.jpg, .png, .gif, etc.) inside those folders")
    
    return True

def main():
    """Main function."""
    print("🖼️  Midjourney Image Extractor")
    print("=" * 50)
    
    try:
        success = extract_images()
        if success:
            print("\n✨ Process completed successfully!")
        else:
            print("\n❌ Process failed!")
            sys.exit(1)
    except KeyboardInterrupt:
        print("\n⏹️  Process interrupted by user.")
        sys.exit(1)
    except Exception as e:
        print(f"\n💥 Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
