local wezterm = require("wezterm")
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- set startup window position
wezterm.on("gui-startup", function(cmd)
    ---@diagnostic disable-next-line: unused-local
    local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
    window:gui_window():set_position(55, 70)
end)

-- custom title name
wezterm.on('format-window-title', function(tab, pane, tabs, panes, config)
  return "ᕕ( ᐛ )ᕗ"
end)

-- set <C-v> for paste
config.keys = {
    { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
}

-- font
config.font = wezterm.font_with_fallback {
    { family = "JetBrains Mono",         weight = "Regular" },
    { family = "Symbols Nerd Font Mono", scale = 0.83 },
    { family = "LXGW WenKai",            scale = 1.17 }
    -- 中文字体测试
}

-- set front_end    
local gpus = wezterm.gui.enumerate_gpus()
config.webgpu_preferred_adapter = gpus[2]
config.front_end = "WebGpu"

-- close title bar
-- config.window_decorations = "RESIZE"

-- set transparent
config.window_background_opacity = 0.96
config.win32_system_backdrop = "Auto"

-- set initial size for screens
local screen_laptop = true
-- screen_laptop = false
if screen_laptop then
    config.initial_rows = 39
    config.initial_cols = 170
else
    config.initial_rows = 47
    config.initial_cols = 200
end

-- others
config.color_scheme = "Catppuccin Mocha"
config.animation_fps = 60
config.default_domain = "WSL:Arch"
config.enable_tab_bar = false
config.font_size = 12
config.max_fps = 165
config.window_close_confirmation = "NeverPrompt"

return config
