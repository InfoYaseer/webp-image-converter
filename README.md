<div align="center">

# 🖼️ WebP Image Converter

### Better-prepared images, one simple drop at a time.

Turn PNG and JPEG images into consistently sized WebP files on Windows, macOS, and Linux. Ideal for product listings, catalogs, and other square-image collections.

**Developed by [Mohamed Yaseer](https://yaseerm.me)** · Powered by [Google’s cwebp encoder](https://developers.google.com/speed/webp/docs/cwebp)

![Platforms](https://img.shields.io/badge/Platforms-Windows%20%7C%20macOS%20%7C%20Linux-0078D4?style=for-the-badge)
![Input](https://img.shields.io/badge/Input-PNG%20%7C%20JPG-5B5FC7?style=for-the-badge)
![Output](https://img.shields.io/badge/Output-WebP-00A67E?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-8A4FFF?style=for-the-badge)

[Get started](#-get-started) · [How it works](#-how-it-works) · [Conversion settings](#%EF%B8%8F-conversion-settings) · [Troubleshooting](#%EF%B8%8F-troubleshooting) · [Developer](#%E2%80%8D-developer)

</div>

---

## ✨ A simpler image workflow

**Choose your images → convert them → find the results in a neatly named batch folder.**

| | What you get |
| :--- | :--- |
| 🖱️ **Easy to use** | Convert PNG, JPG, or JPEG files using the cross-platform command line; Windows also supports drag and drop. |
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

- **Windows, macOS, or Linux**, with a writable folder for the project and its output.
- Google's **`cwebp`** encoder, installed separately. This cross-platform upgrade uses Google's converter for the actual encoding; the project wrapper is developed by Mohamed Yaseer.
- **Python 3.6 or newer** for `convert.py`. The Windows `.cmd` drag-and-drop option uses PowerShell instead and does not require Python.
- One or more square PNG or JPEG images.

### 1. Download the converter

Select **Code → Download ZIP** on GitHub, extract the ZIP, and place the project in a writable folder. Open a terminal in that folder for the commands below.

### 2. Install Google's WebP encoder

**Windows:** Download the appropriate Windows package from [Google's WebP downloads](https://developers.google.com/speed/webp/download) and extract it. Create a `bin` folder beside the scripts and copy `cwebp.exe` into it, along with any DLLs it needs. Alternatively, place `cwebp.exe` beside the scripts or add its folder to `PATH`.

**macOS:** With [Homebrew](https://brew.sh/) installed, run `brew install webp`. Alternatively, use Google's download for your Mac's architecture.

**Linux:** Install the package providing `cwebp` using your distribution's package manager (often named `webp`), or download the appropriate Linux archive from Google. For Debian or Ubuntu, for example:

```sh
sudo apt update
sudo apt install webp python3
```

For macOS and Linux, `cwebp` can also be placed in `bin` beside `convert.py` or beside the script itself; make sure it is executable. The encoder is not included in this repository. Confirm installation with `cwebp -version` when using `PATH`. Google's downloads and the Python runtime have their own licensing terms.

### 3. Convert your images

**Windows drag and drop:** Select one or more square PNG or JPEG files in File Explorer and drag them onto `Convert images to WebP.cmd`. Press any key after checking the summary. Windows Smart App Control may block downloaded scripts; see [Troubleshooting](#%EF%B8%8F-troubleshooting).

**Windows terminal:**

```powershell
py -3 convert.py "C:\Images\product.jpg" "C:\Images\second.png"
```

**macOS / Linux terminal:**

```sh
python3 convert.py "/path/to/product.jpg" "/path/to/second.png"
```

You can pass multiple files; on macOS and Linux, shell patterns such as `python3 convert.py /path/to/images/*.jpg` can select matching files. Quote paths containing spaces. These terminal commands do not provide drag-and-drop integration on macOS or Linux. The Python script may also work on other systems with Python and a compatible `cwebp` executable, but those systems have not been tested.

Open **`WebP Images`** beside the scripts and look inside the newest timestamped folder. Input files can come from other folders. Python exits with a nonzero status when nothing converts or a conversion fails; skipped files are reported separately.

## 📂 How it works

```text
webp-image-converter/
├── Convert images to WebP.cmd   ← Windows drag and drop
├── convert.py                   ← cross-platform command line
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

Both scripts run Google’s locally installed `cwebp` encoder on your computer; they do not upload images to an online conversion service.

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

Metadata is not preserved by default. You can change the `cwebp` command in the relevant script to suit your workflow; see the [official cwebp reference](https://developers.google.com/speed/webp/docs/cwebp) for available options.

## 🛡️ Windows Smart App Control

Windows Smart App Control can block the downloaded `.cmd` file because it treats some internet-origin scripts as potentially unsafe. **A block does not, by itself, mean that this project is malicious.** This project is intended to convert your selected images locally using Google's `cwebp`; its source code is available here for review, and the scripts do not upload your images to a conversion service.

The current Windows script is not a signed application, so we cannot guarantee that Smart App Control will allow it. Please download only from the [official project repository](https://github.com/InfoYaseer/webp-image-converter) and obtain the encoder from [Google's official download page](https://developers.google.com/speed/webp/download). You can use the documented Python command-line option if your device permits it; security policies can also affect that option. For more information, see [Microsoft's Smart App Control guidance](https://learn.microsoft.com/en-us/windows/apps/develop/smart-app-control/overview).

## 🛠️ Troubleshooting

| Problem | What to check |
| :--- | :--- |
| **Windows Smart App Control blocks the `.cmd` file** | Windows may block downloaded scripts. Leave the protection enabled. You can try the documented Python command-line option if Python and the project files are permitted on your device; it is not guaranteed to work under every security policy. See [Microsoft’s Smart App Control guidance](https://learn.microsoft.com/en-us/windows/apps/develop/smart-app-control/overview). |
| **`cwebp.exe was not found`** | Extract the encoder download and check its filename and location. Place it in `bin` beside the scripts, beside the scripts themselves, or on `PATH`. On macOS and Linux, ensure it is executable. |
| **Cannot create an output folder** | Move the project to a writable folder and try again. |
| **Image looks stretched** | Start with a square source image. The script resizes both dimensions to 720 pixels. |
| **Conversion fails** | Check that the file is a valid PNG or JPEG and that the encoder runs on your Windows system. Review the message in the conversion window. |
| **Output exceeds 500 KB** | Review the result or adjust the encoder quality. The warning is not a maximum size. |
| **A folder is empty** | A batch folder can be created before a conversion fails. Check the conversion window for errors. |

## ❓ Frequently asked questions

**Can I convert several images at once?**  
Yes. Pass multiple supported files to the Python command, or on Windows drag them onto the `.cmd` file together if Windows permits it to run.

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

[![Visit Mohamed Yaseer on GitHub](https://img.shields.io/badge/Visit%20my%20GitHub-InfoYaseer-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/InfoYaseer/infoyaseer)

## 📄 License

Copyright © 2026 Mohamed Yaseer. This project is released under the [MIT License](LICENSE). You may use, modify, and distribute it under the license terms, including preservation of the copyright and permission notice.

Google's separately downloaded WebP utilities have their own licensing terms; consult the license included with that download.
