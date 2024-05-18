-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.front_end = 'WebGpu'
config.color_scheme = 'Everforest Dark (Gogh)'

config.enable_tab_bar = false
config.initial_rows = 60
config.initial_cols = 140

config.dpi = 144
config.anti_alias_custom_block_glyphs = true
config.max_fps = 120
config.native_macos_fullscreen_mode = true

config.font = wezterm.font_with_fallback { 'Hack Nerd Font', 'Cascadia Code Web' }
config.font_size = 15
config.line_height = 1.1

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.window_background_opacity = 0.9
config.macos_window_background_blur = 40

-- and finally, return the configuration to wezterm
return config
