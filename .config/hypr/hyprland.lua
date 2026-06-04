require("hyprland.lib")

require("hyprland.keybinds")

-- nwg-displays support --
if is_file_exists(HOME .. "/.config/hypr/workspaces.lua") then
	require("workspaces")
end
if is_file_exists(HOME .. "/.config/hypr/monitors.lua") then
	require("monitors")
end

hl.on("hyprland.start", function()
	hl.exec_cmd("vicinae server")
	hl.exec_cmd("qs -c noctalia-shell")
	hl.exec_cmd("vesktop")
	hl.exec_cmd("vicinae server")
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct0")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1")

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 2,
		resize_on_border = false,
		col = {
			active_border = { colors = { "rgba(ff966c99)", "rgba(ffc777ff)" }, angle = 45 },
			inactive_border = "rgb(3b4261)",
		},
	},
	decoration = {
		rounding = 20,
		rounding_power = 2,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,

		touchpad = {
			natural_scroll = false,
		},

		sensitivity = 0,
		force_no_accel = 1,
		numlock_by_default = true,
	},

	cursor = {
		no_hardware_cursors = true,
	},
	dwindle = {
		preserve_split = true,
	},
})

hl.window_rule({ match = { title = "^(hyprmon)$" }, float = true })
hl.window_rule({ match = { title = "^(hyprmon)$" }, center = true })
hl.window_rule({ match = { title = "^(hyprmon)$" }, size = { "1000", "700" } })

hl.layer_rule({
	name = "noctalia",
	match = { namespace = "noctalia-background-.*$" },
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
