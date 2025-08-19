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

### Quick Start

**Choose the right executable for your system:**

#### 🍎 Mac (Python required)
1. **Add your image folders** to the `input/` directory
2. **Double-click** `extract_images_mac_python.command`
3. **Check the results** in the `output/` directory

#### 🪟 Windows (Python required)
1. **Add your image folders** to the `input/` directory
2. **Double-click** `extract_images_windows_python.bat`
3. **Check the results** in the `output/` directory

#### 🪟 Windows (No Python needed)
1. **Add your image folders** to the `input/` directory
2. **Right-click** `extract_images_windows_no_python.ps1` and select **"Run with PowerShell"**
   - Or double-click if PowerShell is your default for .ps1 files
3. **Check the results** in the `output/` directory

### Manual Execution
Alternatively, you can run the Python script directly on any platform:
```bash
# On Mac/Linux
python3 script/image_extractor.py

# On Windows
python script\image_extractor.py
```

## 📁 Project Structure

```
midjourney-unpacker/
├── extract_images_mac_python.command        # Mac executable (Python required)
├── extract_images_windows_python.bat        # Windows executable (Python required)
├── extract_images_windows_no_python.ps1     # Windows executable (No Python needed)
├── script/
│   └── image_extractor.py                   # Python script that does the work
├── input/                                   # Put your image folders here
├── output/                                  # Extracted images appear here
└── README.md                                # This file
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
- **Cross-platform**: Works on Mac, Windows, and Linux with multiple executable options
- **No dependencies**: PowerShell version requires no additional software on Windows

## 🔧 Requirements

### For Python versions (.command, .bat, manual execution):
- **Python 3.6+** (comes pre-installed on modern Macs)
- No additional dependencies required (uses only Python standard library)

### For PowerShell version (.ps1):
- **Windows with PowerShell** (included in all modern Windows versions)
- **No Python required!**

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
