local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	-- window:gui_window():set_position(200, 100)
	window:gui_window():set_position(55, 70)
end)
config.keys = {
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
}
config.enable_tab_bar = false
config.font_size = 12
config.font = wezterm.font_with_fallback {
    { family = "JetBrains Mono", weight = "Regular" },
    { family = "Symbols Nerd Font Mono", scale = 0.83 },
    { family = "LXGW WenKai", scale = 1.17 }
    -- 中文字体测试
}

-- close title bar
config.window_decorations = "RESIZE"
config.color_scheme = "Catppuccin Mocha"
config.animation_fps = 60
config.default_domain = "WSL:Arch"
config.max_fps = 165
config.window_close_confirmation = "NeverPrompt"
config.initial_rows = 47
config.initial_cols = 200
config.window_background_opacity = 0.96

return config
