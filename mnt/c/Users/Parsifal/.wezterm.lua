local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- set startup window position
wezterm.on("gui-startup", function(cmd)
	---@diagnostic disable-next-line: unused-local
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():set_position(55, 45)
end)

-- custom title name
---@diagnostic disable-next-line: redefined-local, unused-local
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	-- return " ᕕ( ᐛ )ᕗ "
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	return zoomed .. index .. tab.active_pane.title
end)

-- font
config.font = wezterm.font_with_fallback({
	{ family = "JetBrains Mono" },
	{ family = "Symbols Nerd Font Mono", scale = 0.83 },
	{ family = "LXGW WenKai", scale = 1.17 },
	-- 中文字体测试
})

-- set front_end
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- config of tab bar
config.use_fancy_tab_bar = true
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_tab_bar = true
config.window_frame = {
	font = wezterm.font({ family = "JetBrains Mono", weight = "Bold" }),
	active_titlebar_bg = "#31313f",
}
config.colors = {
	tab_bar = {
		-- The color of the inactive tab bar edge/divider
		inactive_tab_edge = "#2b2b3a",
	},
}

-- set transparent
config.window_background_opacity = 0.8
config.win32_system_backdrop = "Acrylic" -- "Auto" or "Acrylic"

-- set initial size for screens
local screen_laptop = true
-- screen_laptop = false
if screen_laptop then
	config.initial_rows = 39
	config.initial_cols = 155
else
	config.initial_rows = 47
	config.initial_cols = 180
end

-- set ssh
config.ssh_backend = "Ssh2"
config.ssh_domains = {
	{
		name = "myserver",
		remote_address = "192.131.142.134",
		multiplexing = "WezTerm",
		username = "parsifa1",
		default_prog = { "fish" },
		assume_shell = "Posix",
		local_echo_threshold_ms = 50000,
	},
}

-- launch_menu
local launch_menu = {}
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		domain = { DomainName = "local" },
		args = { "pwsh", "-NoLogo" },
	})
end
config.launch_menu = launch_menu

-- key config
config.keys = {
	-- set <C-v> for paste
	{ key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	-- set launch_menu
	{
		key = "Tab",
		mods = "CTRL",
		action = wezterm.action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS | DOMAINS | TABS" }),
	},
}

for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = wezterm.action.ActivateTab(i - 1),
	})
end -- others

config.color_scheme = "Catppuccin Mocha"
config.animation_fps = 60
config.default_domain = "WSL:Arch"
config.font_size = 12.3
config.max_fps = 165
config.window_close_confirmation = "NeverPrompt"

return config
