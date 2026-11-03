<div align="center">

# 🖼️ WebP Image Converter

### Better-prepared images, one simple drop at a time.

Turn PNG and JPEG images into consistently sized WebP files with a simple Windows drag-and-drop workflow. Ideal for product listings, catalogs, and other square-image collections.

![Windows](https://img.shields.io/badge/Platform-Windows-0078D4?logo=windows&logoColor=white&style=for-the-badge)
![Input](https://img.shields.io/badge/Input-PNG%20%7C%20JPG-5B5FC7?style=for-the-badge)
![Output](https://img.shields.io/badge/Output-WebP-00A67E?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-8A4FFF?style=for-the-badge)

[Get started](#-get-started) · [How it works](#-how-it-works) · [Conversion settings](#%EF%B8%8F-conversion-settings) · [Troubleshooting](#-troubleshooting) · [Developer](#-developer)

</div>

---

## ✨ A simpler image workflow

**Select your images → drop them on the converter → find the results in a neatly named batch folder.**

| | What you get |
| :--- | :--- |
| 🖱️ **Easy to use** | Drag one or more PNG, JPG, or JPEG files onto the script. |
| 📐 **Consistent output** | Every image is resized to **720 × 720 pixels** for a uniform square format. |
| 📁 **Organized batches** | Each conversion run gets a timestamped folder inside `WebP Images`. |
| 🛡️ **Originals stay intact** | Source files are left untouched; duplicate output names get numbered suffixes. |
| 🔍 **Helpful size reminder** | Files over **500 KB** are flagged so you can review them. |

> [!IMPORTANT]
> Use **square source images**. The converter forces every image to 720 × 720, so non-square images will be stretched. The conversion is lossy; keep your original files and review the results before publishing.

## 🌐 Why WebP?

WebP is an image format developed by Google for efficient image compression. It supports both lossy and lossless compression, as well as transparency and animation. Smaller image files can help reduce bandwidth use and improve page loading, especially when a page contains many product photos.

WebP is widely supported in modern browsers, making it a useful choice for websites and online stores. Actual file size and visual quality depend on the source image and encoding settings: WebP is not guaranteed to be smaller in every case, so compare the result when a particular size or quality target matters. [Explore Google's WebP documentation →](https://developers.google.com/speed/webp)

**This tool creates lossy, still WebP images.** It can retain transparency from PNG files, but it does not create animated or lossless WebP images with its current settings.

## 🚀 Get started

### What you need

- Windows and Windows PowerShell (used to name batch folders).
- Google's **`cwebp.exe`** encoder, downloaded separately.
- One or more square `.png`, `.jpg`, or `.jpeg` images.
- A writable folder for the script and its output.

### 1. Download the converter

On this GitHub page, select **Code → Download ZIP**, extract the ZIP, and place the extracted folder somewhere writable, such as your Documents folder.

### 2. Install the WebP encoder

1. Visit [Google's official WebP downloads](https://developers.google.com/speed/webp/download) and download the Windows package appropriate for your system.
2. Extract the downloaded archive and find `cwebp.exe` inside its `bin` folder.
3. Create a `bin` folder beside `Convert images to WebP.cmd`. Copy `cwebp.exe` into that folder, along with any DLLs it needs.

Alternatively, put `cwebp.exe` beside the script or add its folder to your Windows `PATH`. The encoder is **not included** in this repository. Keep the script and its `bin` folder together when moving them.

### 3. Convert your images

1. Select one or more square PNG or JPEG images in File Explorer.
2. Drag and drop them onto **`Convert images to WebP.cmd`**.
3. Check the conversion summary, then press any key to close the window.
4. Open **`WebP Images`** beside the script and look inside the newest timestamped folder.

You can drop files from another folder; output is always saved beside the script.

## 📂 How it works

```text
webp-image-converter/
├── Convert images to WebP.cmd
├── bin/
│   └── cwebp.exe                 ← install separately
└── WebP Images/                  ← created automatically
    ├── 2026-11-03_14-30-00-123/ ← first batch
    │   ├── product.webp
    │   └── product_2.webp
    └── 2026-11-03_14-35-00-456/ ← another batch
        └── product.webp
```

A timestamped batch folder is created when a run reaches a supported input, including if that conversion later fails. Unsupported and missing files are skipped. If two inputs in the same batch have the same base name, the second output is numbered instead of overwriting the first.

The script runs the locally installed encoder on your computer; it does not upload images to an online conversion service.

## ⚙️ Conversion settings

| Setting | Value | What it means |
| :--- | :--- | :--- |
| Format | WebP | Still images with lossy compression; transparency is supported. |
| Dimensions | 720 × 720 px | Both dimensions are forced to 720 pixels. |
| Preset | `photo` | Uses the encoder's photo preset. |
| Quality | `85` | Controls lossy compression quality; it is not a file-size guarantee. |
| Method | `6` | Uses the encoder's highest compression-effort setting. |
| Color conversion | `-sharp_yuv` | Uses sharper RGB-to-YUV conversion. |
| Size reminder | Over 500 KB | Reports a warning; it does not automatically reduce the file size. |

Metadata is not preserved by default. You can change the `cwebp` command in the script to suit your workflow; see the [official cwebp reference](https://developers.google.com/speed/webp/docs/cwebp) for available options.

## 🛠️ Troubleshooting

| Problem | What to check |
| :--- | :--- |
| **`cwebp.exe was not found`** | Extract the encoder download and check its filename and location. Place it in `bin` beside the script, beside the script itself, or on `PATH`. |
| **Cannot create an output folder** | Move the project to a writable folder and try again. |
| **Image looks stretched** | Start with a square source image. The script resizes both dimensions to 720 pixels. |
| **Conversion fails** | Check that the file is a valid PNG or JPEG and that the encoder runs on your Windows system. Review the message in the conversion window. |
| **Output exceeds 500 KB** | Review the result or adjust the encoder quality. The warning is not a maximum size. |
| **A folder is empty** | A batch folder can be created before a conversion fails. Check the conversion window for errors. |

## ❓ Frequently asked questions

**Can I convert several images at once?**  
Yes. Select multiple supported files and drop them onto the script together.

**Will my original files change?**  
No. The converter writes new `.webp` files in its output folder and leaves your source files in place.

**Can I use non-square images?**  
You can, but they will be stretched to 720 × 720. Crop them to a square first if you want to preserve their proportions.

**Does every image become smaller than 500 KB?**  
No. The tool warns when an output exceeds 500 KB; it does not enforce that limit. File sizes vary with image content and encoder settings.

**Does the tool need an internet connection?**  
You need a connection to download the project and encoder. Once installed, the conversion runs locally.

## 👨‍💻 Developer

**Mohamed Yaseer**  
🌐 [yaseerm.me](https://yaseerm.me)  
✉️ [yaseer.inbox@hotmail.com](mailto:yaseer.inbox@hotmail.com)

## 📄 License

Copyright © 2026 Mohamed Yaseer. This project is released under the [MIT License](LICENSE). You may use, modify, and distribute it under the license terms, including preservation of the copyright and permission notice.

Google's separately downloaded WebP utilities have their own licensing terms; consult the license included with that download.
