-- ~/.config/hypr/hyprland.lua
-- Konversi dari hyprland.conf (butuh Hyprland >= 0.55)
-- Baris bertanda "CEK" = sintaks yang perlu dipastikan saat reload.

------------------
--- VARIABLES ---
------------------
local terminal = "kitty"
local fileManager = "dolphin"
local menu = "hyprlauncher"
local browser = "firefox"
local mainMod = "SUPER"

local ok, theme = pcall(dofile, os.getenv("HOME") .. "/.config/hypr/theme/colors.lua")
if not ok or type(theme) ~= "table" then
	theme = {
		active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
		inactive_border = "rgba(595959aa)",
	}
end

-----------------
--- MONITORS ---
-----------------
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" }) -- CEK

-----------------
--- AUTOSTART ---
-----------------
hl.on("hyprland.start", function()
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("ags run")
end)

---------------------------
--- ENVIRONMENT VARIABLES ---
---------------------------
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-----------------------
--- LOOK AND FEEL ---
-----------------------
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		col = { -- CEK
			active_border = theme.active_border,
			inactive_border = theme.inactive_border,
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 10,
		rounding_power = 2,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 8,
			passes = 2,
			vibrancy = 0.1696,
			ignore_opacity = true,
		},
	},

	animations = { enabled = true },

	dwindle = { preserve_split = true },
	master = { new_status = "master" },

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
	},

	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = { natural_scroll = false },
	},
})

-------------------
--- ANIMATIONS ---
-------------------
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 4, bezier = "easeOutQuint", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Tambahan
hl.animation({ leaf = "borderangle", enabled = false })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "easeInOutCubic" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 1.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 3, bezier = "easeOutQuint", style = "slidevert" })
hl.animation({ leaf = "monitorAdded", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadePopups", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadePopupsIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadePopupsOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fadeDpms", enabled = true, speed = 2, bezier = "almostLinear" })

-------------------
--- GESTURES / DEVICE ---
-------------------
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" }) -- CEK

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-------------------
--- KEYBINDINGS ---
-------------------
-- Screenshot area -> clipboard
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd([[bash -c 'grim -g "$(slurp)" - | wl-copy']]))

-- Custom
hl.bind("ALT + Tab", hl.dsp.exec_cmd("ags request switcher next"))
hl.bind("ALT + SHIFT + Tab", hl.dsp.exec_cmd("ags request switcher prev"))
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd("ags toggle applauncher"))
hl.bind("SUPER + F", hl.dsp.exec_cmd(browser))
hl.bind("SUPER + SHIFT + Delete", hl.dsp.exec_cmd("poweroff"))
hl.bind("SUPER + SHIFT + O", hl.dsp.exec_cmd("obs"))

-- Aplikasi & jendela
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("sh -c 'command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit'")
)
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd("rofi -modi emoji -show emoji"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + V", function() -- CEK
	hl.dispatch(hl.dsp.window.float({ action = "set" }))
	hl.dispatch(hl.dsp.window.resize({ x = 800, y = 600, relative = false }))
	hl.dispatch(hl.dsp.window.center())
end)
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo()) -- CEK

-- Pindah fokus (panah)
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Pindah fokus (vim)
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Workspace 1-10
for i = 1, 10 do
	local key = i % 10 -- tombol 0 = workspace 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll antar workspace
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Geser / resize jendela dengan mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- CEK
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- CEK

-- Pindahkan jendela dengan keyboard
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Submap resize
-- (catatan: SUPER+R juga terikat ke launcher di atas, sama seperti config asli;
--  bind terakhir yang menang. Ganti tombol salah satunya jika bentrok.)
hl.bind("SUPER + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0 }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0 }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = -10 }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = 10 }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Volume & brightness (locked + repeating)
local lr = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), lr)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), lr)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), lr)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), lr)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), lr)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), lr)

-- Media (butuh playerctl)
local l = { locked = true }
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), l)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), l)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), l)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), l)

--------------------------------
--- WINDOWS AND WORKSPACES ---
--------------------------------
hl.workspace_rule({ workspace = "1", monitor = "eDP-1", default = true })
for i = 2, 9 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "eDP-1" })
end
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1", default = true })

hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})
