# Fonts Folder

This folder should contain the Inter font family files.

## Required Font Files

Download the Inter font family and place these files here:
- `Inter-Regular.ttf`
- `Inter-Medium.ttf`
- `Inter-SemiBold.ttf`
- `Inter-Bold.ttf`
- `Inter-ExtraBold.ttf`

## How to Download Inter Fonts

### Option 1: Using the download script
Run the provided script:
```bash
./download_inter_fonts.sh
```

### Option 2: Manual Download
1. Visit: https://fonts.google.com/specimen/Inter
2. Click "Download family"
3. Extract the ZIP file
4. Copy the following files to this folder:
   - `Inter-Regular.ttf`
   - `Inter-Medium.ttf`
   - `Inter-SemiBold.ttf`
   - `Inter-Bold.ttf`
   - `Inter-ExtraBold.ttf`

### Option 3: Using npm/google-fonts
```bash
npm install -g google-fonts-downloader
google-fonts-downloader -f Inter -w 400,500,600,700,800
```

After adding the fonts, update `pubspec.yaml` to include the fonts section again.

