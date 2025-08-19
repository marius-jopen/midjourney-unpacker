@echo off
REM Midjourney Image Extractor for Windows
REM Double-click this file to extract images from input folders to output folder

title Midjourney Image Extractor

echo.
echo 🖼️  Midjourney Image Extractor
echo Starting extraction process...
echo.

REM Get the directory where this batch file is located
cd /d "%~dp0"

REM Run the Python script
python script\image_extractor.py

REM If python command fails, try python3
if %ERRORLEVEL% neq 0 (
    echo.
    echo Trying python3 command...
    python3 script\image_extractor.py
)

REM If both fail, show error message
if %ERRORLEVEL% neq 0 (
    echo.
    echo ❌ Error: Python not found or failed to run.
    echo Please make sure Python is installed and accessible from the command line.
    echo You can download Python from: https://www.python.org/downloads/
    echo.
    echo Alternatively, use the PowerShell version: extract_images.ps1
)

echo.
echo Press any key to close this window...
pause >nul
