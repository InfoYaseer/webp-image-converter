<div align="center">

# 🖼️ WebP Image Converter

### Drop. Convert. Ready for the web.

A simple Windows drag-and-drop tool for turning product photos and other square images into neatly organized WebP files.

![Windows](https://img.shields.io/badge/platform-Windows-0078D4?logo=windows&logoColor=white)
![Input](https://img.shields.io/badge/input-PNG%20%7C%20JPG-blue)
![Output](https://img.shields.io/badge/output-WebP-00A67E)
![License](https://img.shields.io/badge/license-MIT-purple)

</div>

## Why WebP?

WebP is an image format developed by Google that supports lossy and lossless compression, transparency and animation. Its efficient compression can make images smaller than comparable JPEGs or PNGs, helping websites load faster and use less bandwidth. Actual savings depend on the image and settings; WebP is not always smaller, and you should check quality and compatibility for your audience. [Learn more about WebP](https://developers.google.com/speed/webp).

This converter creates **lossy, still WebP images**, with transparency supported for PNGs. It is designed for a consistent square product-image workflow, not animated images or lossless conversion.

## ✨ Features

- **Drag and drop** one or more PNG, JPG or JPEG files onto the script.
- **Automatic organization:** a `WebP Images` folder is created beside the script when a valid input is first processed. Each run gets its own timestamped subfolder.
- **Consistent sizing:** images are resized to **720 × 720 pixels**. Use square sources to avoid distortion.
- **Safe originals:** source images are not overwritten. Duplicate output names within a batch get numbered suffixes.
- **Size reminder:** outputs over 500 KB are flagged for review; this is not a size limit.

## 🚀 Setup

1. Download this repository (GitHub → **Code → Download ZIP**) and extract it to a writable folder.
2. Download the Windows package for your system from [Google's official WebP downloads](https://developers.google.com/speed/webp/download) and extract it.
3. Create a folder named `bin` next to `Convert images to WebP.cmd`. Copy `cwebp.exe` from the extracted WebP package's `bin` folder into your new `bin` folder, along with any DLLs it needs. Alternatively, place `cwebp.exe` beside the script or add its folder to your Windows `PATH`.
4. Select one or more square PNG or JPEG files and drag them onto `Convert images to WebP.cmd`. Review the results and press any key to close the window.

The script uses Windows PowerShell to name batch folders. The encoder is a separate download and is not included in this repository. Keep the script and its `bin` folder together if you move them.

```text
webp-image-converter/
├── Convert images to WebP.cmd
├── bin/
│   └── cwebp.exe                 ← install separately
└── WebP Images/                  ← created automatically
    ├── 2026-11-03_14-30-00-123/
    │   ├── product.webp
    │   └── product_2.webp
    └── ...
```

Files may be dropped from other folders; output always goes beside the script. A new timestamped folder is created for each run that reaches a supported input, even if conversion later fails. Unsupported or missing files are skipped.

## ⚙️ Conversion settings

The script calls `cwebp` with the photo preset, quality **85**, method **6**, sharp YUV conversion and a **720 × 720** resize. Compression is lossy, so fine detail can change. Review outputs before publishing; 500 KB is a warning threshold, not a guaranteed maximum. The script does not preserve metadata by default. Edit the command in the script if you need different settings; see the [cwebp documentation](https://developers.google.com/speed/webp/docs/cwebp).

## 🛠️ Troubleshooting

- **`cwebp.exe was not found`:** check its location and filename, or install it on `PATH`. Extract the download before copying files.
- **Cannot create output folder:** move the project to a writable location and try again.
- **Image looks stretched:** start with a square image. The tool forces both dimensions to 720 pixels.
- **A conversion fails:** check that the input is a valid PNG or JPEG and that the encoder runs on your version of Windows. The window reports failed files.
- **File is over 500 KB:** review the image or adjust the encoder quality; the tool does not automatically recompress to meet a target size.

## 👨‍💻 Developer

**Mohamed Yaseer**  
🌐 [yaseerm.me](https://yaseerm.me)  
✉️ [yaseer.inbox@hotmail.com](mailto:yaseer.inbox@hotmail.com)

## License

Copyright © 2026 Mohamed Yaseer. Released under the [MIT License](LICENSE). The separately downloaded WebP utilities have their own licensing terms; consult the license included with that download.
