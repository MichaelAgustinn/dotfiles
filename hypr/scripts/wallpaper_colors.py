#!/usr/bin/env python3
"""Pakai: wallpaper_colors.py /path/ke/wallpaper.jpg"""
import colorsys
import json
import os
import subprocess
import sys

from PIL import Image

HOME = os.path.expanduser("~")
COLOR_FILE = f"{HOME}/.config/hypr/theme/colors.json"
APPLY = f"{HOME}/.config/hypr/scripts/apply_theme.py"


def to_hex(h, s, v):
    s = max(0.0, min(1.0, s))
    v = max(0.0, min(1.0, v))
    r, g, b = colorsys.hsv_to_rgb(h % 1.0, s, v)
    return "{:02x}{:02x}{:02x}".format(round(r * 255), round(g * 255), round(b * 255))


def extract(path):
    img = Image.open(path).convert("RGB")
    img.thumbnail((160, 160))
    q = img.quantize(colors=16, method=Image.Quantize.MEDIANCUT)
    pal = q.getpalette()
    counts = q.getcolors()
    total = sum(c for c, _ in counts)
    out = []
    for count, idx in counts:
        r, g, b = pal[idx * 3: idx * 3 + 3]
        h, s, v = colorsys.rgb_to_hsv(r / 255, g / 255, b / 255)
        out.append((h, s, v, count / total))
    return out


def hue_dist(a, b):
    d = abs(a - b)
    return min(d, 1 - d)


def pick_three(cols):
    cands = [c for c in cols if c[1] > 0.3 and 0.3 < c[2] < 0.98]
    cands.sort(key=lambda c: c[1] * c[2] * (c[3] ** 0.3), reverse=True)
    chosen = []
    for c in cands:
        if all(hue_dist(c[0], o[0]) > 0.06 for o in chosen):
            chosen.append(c)
        if len(chosen) == 3:
            break
    if not chosen:  # wallpaper hampir abu-abu
        chosen = [(0.8, 0.5, 0.9, 0)]
    while len(chosen) < 3:
        h, s, v, _ = chosen[0]
        chosen.append(((h + 0.08 * len(chosen)) % 1.0, s, v, 0))
    return chosen


def main():
    if len(sys.argv) < 2:
        sys.exit("Pakai: wallpaper_colors.py /path/wallpaper.jpg")
    path = os.path.expanduser(sys.argv[1])

    try:
        with open(COLOR_FILE) as f:
            data = json.load(f)
    except Exception:
        data = {}

    c1, c2, c3 = pick_three(extract(path))
    h = c1[0]

    def vivid(c):
        return to_hex(c[0], max(c[1], 0.6), max(c[2], 0.85))

    dark_bg = to_hex(h, 0.55, 0.16)
    data["active_border_1"] = vivid(c1)
    data["active_border_2"] = vivid(c2)
    data["active_border_3"] = vivid(c3)
    data["inactive_border"] = dark_bg
    data.setdefault("angle", 45)

    red = data.get("light", {}).get("red", "#e11d48")
    red_dark = data.get("dark", {}).get("red", "#ff3366")
    data["light"] = {
        "bg": "#" + to_hex(h, 0.10, 0.98),
        "fg": "#" + to_hex(h, 0.60, 0.22),
        "accent": "#" + to_hex(h, 0.85, 0.85),
        "red": red,
    }
    data["dark"] = {
        "bg": "#" + dark_bg,
        "fg": "#" + to_hex(h, 0.06, 0.96),
        "accent": "#" + to_hex(h, 0.75, 0.95),
        "red": red_dark,
    }

    os.makedirs(os.path.dirname(COLOR_FILE), exist_ok=True)
    with open(COLOR_FILE, "w") as f:
        json.dump(data, f, indent=2)
    print(f"[✓] colors.json diperbarui dari {path}")

    subprocess.run(["python3", APPLY], check=False)


if __name__ == "__main__":
    main()
