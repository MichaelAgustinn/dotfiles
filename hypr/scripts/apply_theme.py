#!/usr/bin/env python3
import json
import os
import subprocess

HOME = os.path.expanduser("~")
COLOR_FILE = os.path.join(HOME, ".config/hypr/theme/colors.json")
# Ditulis ke file terpisah, BUKAN ke hyprland.lua (config utama)
HYPR_LUA_FILE = os.path.join(HOME, ".config/hypr/theme/colors.lua")
AGS_COLORS_FILE = os.path.join(HOME, ".config/ags/options_colors.js")
AGS_SCSS_FILE = os.path.join(HOME, ".config/ags/style/_colors.scss")


def load_colors():
    with open(COLOR_FILE, "r") as f:
        return json.load(f)


def strip_hash(value):
    """Hilangkan '#' di depan agar 'rgba(...)' tetap valid."""
    return value.lstrip("#")


def generate_hyprland_lua(data):
    c1 = strip_hash(data["active_border_1"])
    c2 = strip_hash(data["active_border_2"])
    c3 = strip_hash(data["active_border_3"])
    inact = strip_hash(data["inactive_border"])
    angle = data["angle"]

    lua_content = f"""-- File ini dihasilkan otomatis oleh apply_theme.py
return {{
    active_border = {{ colors = {{ "rgba({c1}ff)", "rgba({c2}ff)", "rgba({c3}ff)" }}, angle = {angle} }},
    inactive_border = "rgba({inact}ff)",
}}
"""
    os.makedirs(os.path.dirname(HYPR_LUA_FILE), exist_ok=True)
    with open(HYPR_LUA_FILE, "w") as f:
        f.write(lua_content)
    print(f"[✓] Berhasil generate: {HYPR_LUA_FILE}")


def generate_ags_colors(data):
    light = data["light"]
    dark = data["dark"]

    # 1. Format JS/TS untuk epik-shell options
    js_content = f"""// File ini dihasilkan otomatis oleh apply_theme.py
import {{ opt }} from "./utils/option"

export const themeColors = {{
  light: {{
    bg: opt("{light['bg']}"),
    fg: opt("{light['fg']}"),
    accent: opt("{light['accent']}"),
    red: opt("{light['red']}"),
  }},
  dark: {{
    bg: opt("{dark['bg']}"),
    fg: opt("{dark['fg']}"),
    accent: opt("{dark['accent']}"),
    red: opt("{dark['red']}"),
  }},
}};
"""
    os.makedirs(os.path.dirname(AGS_COLORS_FILE), exist_ok=True)
    with open(AGS_COLORS_FILE, "w") as f:
        f.write(js_content)
    print(f"[✓] Berhasil generate: {AGS_COLORS_FILE}")

    # 2. Format SCSS jika epik-shell menggunakannya
    scss_content = f"""// File ini dihasilkan otomatis oleh apply_theme.py
$bg-dark: {dark['bg']};
$fg-dark: {dark['fg']};
$accent-dark: {dark['accent']};
$red-dark: {dark['red']};

$bg-light: {light['bg']};
$fg-light: {light['fg']};
$accent-light: {light['accent']};
$red-light: {light['red']};
"""
    os.makedirs(os.path.dirname(AGS_SCSS_FILE), exist_ok=True)
    with open(AGS_SCSS_FILE, "w") as f:
        f.write(scss_content)
    print(f"[✓] Berhasil generate: {AGS_SCSS_FILE}")


def reload_services():
    print("[*] Melakukan reload Hyprland & AGS...")
    subprocess.run(["hyprctl", "reload"], check=False)
    subprocess.run(["ags", "quit"], check=False)
    # tunggu sampai proses ags benar-benar hilang (maks ~5 detik)
    for _ in range(25):
        if subprocess.run(["pgrep", "-f", "ags.js"],
                          stdout=subprocess.DEVNULL).returncode != 0:
            break
        time.sleep(0.2)
    subprocess.Popen(
        ["ags", "run"],
        start_new_session=True,
        stdout=subprocess.DEVNULL,
        stderr=subprocess.DEVNULL,
    )

if __name__ == "__main__":
    colors = load_colors()
    generate_hyprland_lua(colors)
    generate_ags_colors(colors)
    reload_services()
    print("[✓] Sinkronisasi tema Hyprland dan epik-shell selesai!")
