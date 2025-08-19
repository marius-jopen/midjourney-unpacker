# Midjourney Image Extractor - PowerShell Version
# No Python required! Right-click and "Run with PowerShell" or double-click to extract images

# Set execution policy for this session (in case it's restricted)
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Function to check if a file is an image
function Test-ImageFile {
    param([string]$FilePath)
    
    $imageExtensions = @('.jpg', '.jpeg', '.png', '.gif', '.bmp', '.tiff', '.tif', '.webp')
    $extension = [System.IO.Path]::GetExtension($FilePath).ToLower()
    return $imageExtensions -contains $extension
}

# Function to create a unique filename
function Get-UniqueFileName {
    param(
        [string]$Directory,
        [string]$FileName
    )
    
    $basePath = Join-Path $Directory $FileName
    
    if (-not (Test-Path $basePath)) {
        return $basePath
    }
    
    $nameWithoutExt = [System.IO.Path]::GetFileNameWithoutExtension($FileName)
    $extension = [System.IO.Path]::GetExtension($FileName)
    $counter = 1
    
    do {
        $newFileName = "${nameWithoutExt}_${counter}${extension}"
        $newPath = Join-Path $Directory $newFileName
        $counter++
    } while (Test-Path $newPath)
    
    return $newPath
}

# Main extraction function
function Start-ImageExtraction {
    # Get script directory
    $scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $inputDir = Join-Path $scriptDir "input"
    $outputDir = Join-Path $scriptDir "output"
    
    Write-Host "🖼️  Midjourney Image Extractor (PowerShell)" -ForegroundColor Cyan
    Write-Host "=" * 50 -ForegroundColor Cyan
    
    # Create output directory if it doesn't exist
    if (-not (Test-Path $outputDir)) {
        New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
    }
    
    # Check if input directory exists
    if (-not (Test-Path $inputDir)) {
        Write-Host "❌ Input directory not found: $inputDir" -ForegroundColor Red
        return $false
    }
    
    Write-Host "🔍 Scanning input directory: $inputDir" -ForegroundColor Green
    Write-Host "📁 Output directory: $outputDir" -ForegroundColor Green
    Write-Host "-" * 50
    
    $totalExtracted = 0
    
    # Get all subdirectories in input folder
    $subDirs = Get-ChildItem -Path $inputDir -Directory
    
    if ($subDirs.Count -eq 0) {
        Write-Host "ℹ️  No subdirectories found in input folder." -ForegroundColor Yellow
        Write-Host "   Please create folders inside the 'input' directory and put images in them." -ForegroundColor Yellow
        return $true
    }
    
    foreach ($dir in $subDirs) {
        $folderName = $dir.Name
        Write-Host "📂 Processing folder: $folderName" -ForegroundColor Cyan
        
        $extractedFromFolder = 0
        
        # Get all files in this directory (including subdirectories)
        $files = Get-ChildItem -Path $dir.FullName -File -Recurse
        
        foreach ($file in $files) {
            if (Test-ImageFile -FilePath $file.FullName) {
                # Create new filename with folder prefix
                $newFileName = "${folderName}_$($file.Name)"
                $outputPath = Get-UniqueFileName -Directory $outputDir -FileName $newFileName
                
                try {
                    Copy-Item -Path $file.FullName -Destination $outputPath -Force
                    $finalFileName = Split-Path -Leaf $outputPath
                    Write-Host "  ✅ $($file.Name) → $finalFileName" -ForegroundColor Green
                    $extractedFromFolder++
                    $totalExtracted++
                }
                catch {
                    Write-Host "  ❌ Failed to copy $($file.Name): $($_.Exception.Message)" -ForegroundColor Red
                }
            }
        }
        
        if ($extractedFromFolder -eq 0) {
            Write-Host "  ℹ️  No images found in $folderName" -ForegroundColor Yellow
        }
        else {
            Write-Host "  📊 Extracted $extractedFromFolder images from $folderName" -ForegroundColor Green
        }
        
        Write-Host ""
    }
    
    Write-Host "-" * 50
    Write-Host "🎉 Extraction complete! Total images extracted: $totalExtracted" -ForegroundColor Green
    
    if ($totalExtracted -eq 0) {
        Write-Host "ℹ️  No images were found in any subdirectories." -ForegroundColor Yellow
        Write-Host "   Make sure you have:" -ForegroundColor Yellow
        Write-Host "   - Folders inside the 'input' directory" -ForegroundColor Yellow
        Write-Host "   - Image files (.jpg, .png, .gif, etc.) inside those folders" -ForegroundColor Yellow
    }
    
    return $true
}

# Main execution
try {
    $success = Start-ImageExtraction
    if ($success) {
        Write-Host "`n✨ Process completed successfully!" -ForegroundColor Green
    }
    else {
        Write-Host "`n❌ Process failed!" -ForegroundColor Red
        exit 1
    }
}
catch {
    Write-Host "`n💥 Unexpected error: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}

Write-Host "`nPress any key to close this window..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
