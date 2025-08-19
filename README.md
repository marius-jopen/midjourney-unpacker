# Midjourney Image Unpacker

A simple tool to extract images from multiple folders into a single output directory. Perfect for organizing images downloaded from Midjourney or any other source where images are grouped in separate folders.

## 🖼️ What it does

This tool takes multiple folders containing images from the `input/` directory and extracts all images into a single `output/` directory, automatically renaming files to prevent conflicts.

### Example:
**Before:**
```
input/
├── vacation_photos/
│   ├── beach.jpg
│   ├── sunset.png
│   └── mountains.gif
├── work_images/
│   ├── logo.png
│   └── banner.jpg
└── midjourney_batch_1/
    ├── fantasy_1.png
    ├── fantasy_2.png
    └── landscape.jpg
```

**After:**
```
output/
├── vacation_photos_beach.jpg
├── vacation_photos_sunset.png
├── vacation_photos_mountains.gif
├── work_images_logo.png
├── work_images_banner.jpg
├── midjourney_batch_1_fantasy_1.png
├── midjourney_batch_1_fantasy_2.png
└── midjourney_batch_1_landscape.jpg
```

## 🚀 How to use

### Quick Start (Mac)
1. **Add your image folders** to the `input/` directory
2. **Double-click** `extract_images.command`
3. **Check the results** in the `output/` directory

### Manual Execution
Alternatively, you can run the Python script directly:
```bash
python3 script/image_extractor.py
```

## 📁 Project Structure

```
midjourney-unpacker/
├── extract_images.command     # Mac executable (double-click to run)
├── script/
│   └── image_extractor.py     # Python script that does the work
├── input/                     # Put your image folders here
├── output/                    # Extracted images appear here
└── README.md                  # This file
```

## 🎯 Supported Image Formats

The tool supports all common image formats:
- **JPEG** (.jpg, .jpeg)
- **PNG** (.png)
- **GIF** (.gif)
- **BMP** (.bmp)
- **TIFF** (.tiff, .tif)
- **WebP** (.webp)

## ✨ Features

- **Automatic conflict resolution**: If files have the same name, they're automatically renamed with numbers
- **Folder-based naming**: Extracted files are prefixed with their original folder name
- **Progress feedback**: See exactly what's happening with emoji-rich console output
- **Error handling**: Graceful handling of permission issues and corrupted files
- **Cross-platform**: Works on Mac, Windows, and Linux (though the .command file is Mac-specific)

## 🔧 Requirements

- **Python 3.6+** (comes pre-installed on modern Macs)
- No additional dependencies required (uses only Python standard library)

## 📝 Notes

- The `input/` and `output/` directories are ignored by git (see `.gitignore`)
- Files are copied, not moved, so your original folders remain intact
- The tool creates the `output/` directory automatically if it doesn't exist
- If no images are found, the tool will provide helpful guidance

## 🐛 Troubleshooting

### "Permission denied" when double-clicking
Make sure the file is executable:
```bash
chmod +x extract_images.command
```

### "Python not found"
On some systems, you might need to use `python` instead of `python3`. Edit the `.command` file if needed.

### No images extracted
Make sure you have:
1. Folders (not individual files) in the `input/` directory
2. Image files inside those folders
3. Supported image formats

## 📄 License

This project is open source and available under the MIT License.
