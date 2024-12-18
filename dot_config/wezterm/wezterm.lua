local wezterm = require("wezterm")
local config = {}

config.font = wezterm.font("CommitMono Nerd Font")
config.font_size = 16.0

config.window_frame = {
	-- The font used in the tab bar.
	-- Roboto Bold is the default; this font is bundled
	-- with wezterm.
	-- Whatever font is selected here, it will have the
	-- main font setting appended to it to pick up any
	-- fallback fonts you may have used there.
	font = wezterm.font({ family = "CommitMono Nerd Font" }),

	-- The size of the font in the tab bar.
	-- Default to 10.0 on Windows but 12.0 on other systems
	font_size = 12.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#333333",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#333333",
}

config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#575757",
	},
}

return config
