#!/usr/bin/env python3
"""Convert PNG and JPEG images using Google's cwebp encoder."""
import argparse
from datetime import datetime
from pathlib import Path
import shutil
import subprocess
import sys

ROOT = Path(__file__).resolve().parent
EXTENSIONS = {".png", ".jpg", ".jpeg"}


def find_encoder():
    name = "cwebp.exe" if sys.platform == "win32" else "cwebp"
    for candidate in (ROOT / "bin" / name, ROOT / name):
        if candidate.is_file():
            return str(candidate)
    return shutil.which(name)


def new_batch():
    root = ROOT / "WebP Images"
    root.mkdir(parents=True, exist_ok=True)
    stamp = datetime.now().strftime("%Y-%m-%d_%H-%M-%S-%f")[:-3]
    for number in range(1, 10000):
        folder = root / (stamp if number == 1 else f"{stamp}_{number}")
        try:
            folder.mkdir()
            return folder
        except FileExistsError:
            continue
    raise OSError("Could not find an available batch folder name")


def main():
    parser = argparse.ArgumentParser(description="Convert square PNG/JPEG images to 720 x 720 WebP using cwebp.")
    parser.add_argument("images", nargs="+", type=Path, help="PNG or JPEG image paths")
    args = parser.parse_args()
    encoder = find_encoder()
    if not encoder:
        print("cwebp was not found. Install Google's WebP tools or place cwebp in the bin folder beside this script.", file=sys.stderr)
        return 1
    batch = None
    converted = failed = skipped = 0
    for source in args.images:
        if not source.is_file() or source.suffix.lower() not in EXTENSIONS:
            print(f"Skipped missing or unsupported file: {source}")
            skipped += 1
            continue
        try:
            if batch is None:
                batch = new_batch()
            target = batch / (source.stem + ".webp")
            number = 2
            while target.exists():
                target = batch / f"{source.stem}_{number}.webp"
                number += 1
            print(f"Converting {source.name} ...", flush=True)
            result = subprocess.run([encoder, "-preset", "photo", "-q", "85", "-m", "6", "-sharp_yuv", "-resize", "720", "720", str(source.resolve()), "-o", str(target), "-quiet"], check=False)
            if result.returncode != 0 or not target.is_file():
                print(f"Failed to convert: {source}", file=sys.stderr)
                failed += 1
                continue
            size = target.stat().st_size
            print(f"Created {target} - {(size + 1023) // 1024} KB")
            if size > 512000:
                print("Note: This image exceeds 500 KB. Review its quality and size.")
            converted += 1
        except OSError as exc:
            print(f"Could not convert {source}: {exc}", file=sys.stderr)
            failed += 1
    print(f"\nFinished: {converted} converted, {failed} failed, {skipped} skipped.")
    if batch is not None:
        print(f"Output folder: {batch}")
    return 1 if failed or not converted else 0


if __name__ == "__main__":
    raise SystemExit(main())
