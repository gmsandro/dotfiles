local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 16
config.font = wezterm.font_with_fallback({
	"Berkeley Mono",
	"JetBrainsMono Nerd Font",
	"JetBrains Mono",
})

-- config.color_scheme = "Aura (Gogh)"
-- config.color_scheme = 'tokyonight-day'

function get_appearance()
	if wezterm.gui then
		return wezterm.gui.get_appearance()
	end
	return "Dark"
end

function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		return "Aura (Gogh)"
	else
		return "tokyonight-day"
	end
end

config.color_scheme = scheme_for_appearance(get_appearance())

config.window_decorations = "RESIZE"

config.window_padding = {
	left = 8,
	right = 0,
	top = 8,
	bottom = 0,
}

config.window_frame = {
	font = wezterm.font_with_fallback({
		"Berkeley Mono",
		"JetBrainsMono Nerd Font",
		"JetBrains Mono",
	}),
}

return config
