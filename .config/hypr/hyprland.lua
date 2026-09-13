hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct0")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("GDK_SCALE", "1")
hl.env("GBM_BACKEND", "nvidia_drm")
hl.env("_GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("WLR_NO_HARDWARE_CURSORS", "1")

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
	hl.exec_cmd("noctalia")
	hl.exec_cmd("vicinae server")
	hl.exec_cmd("qs")
end)

hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		layout = "scrolling",
	},

	decoration = {
		rounding = 20,
		rounding_power = 2,
		blur = {
			enabled = true,
			size = 3,
			passes = 2,
			vibrancy = 0.1696,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
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
	scrolling = {
		direction = "right",
		column_width = 0.5,
		fullscreen_on_one_column = true,
	},

	misc = {
		disable_hyprland_logo = true,
		font_family = "SF Mono Powerline",
		focus_on_activate = true,
		background_color = "rgb(212830)",
	},
})

hl.window_rule({ match = { title = "^(hyprmon)$" }, float = true })
hl.window_rule({ match = { title = "^(hyprmon)$" }, center = true })
hl.window_rule({ match = { title = "^(hyprmon)$" }, size = { "1000", "700" } })

hl.workspace_rule({ workspace = "w[1-10]", layout_opts = { direction = "right" }, layout = "scrolling" })

-- For Noctalia Color templates
require("noctalia").apply_theme()

-- Noctalia Settings
hl.window_rule({
	match = { class = "dev.noctalia.Noctalia" },
	float = true,
	size = { 1080, 920 },
})

hl.layer_rule({
	name = "noctalia",
	match = {
		namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
	},
	no_anim = true,
	ignore_alpha = 0.5,
	blur = true,
	blur_popups = true,
})
