---@diagnostic disable: unused-local, redefined-local
local wezterm = require("wezterm")
local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- set startup window position
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
	window:gui_window():set_position(55, 45)
end)

-- set tab title
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local pane_title = tab.active_pane.title
	local user_title = tab.active_pane.user_vars.panetitle
	local foreground = "#808080"
	if user_title ~= nil and #user_title > 0 then
		pane_title = user_title
	end
	if tab.is_active then
		foreground = "white"
	end

	return {
		{ Background = { Color = "#2d2d3f" } },
		{ Foreground = { Color = foreground } },
		{ Text = " " .. pane_title .. " " },
	}
end)

config.enable_kitty_graphics = true

-- set initial size for screens
local screen_laptop = true
-- screen_laptop = false
if screen_laptop then
	config.initial_rows = 39
	config.initial_cols = 150
else
	config.initial_rows = 47
	config.initial_cols = 180
end

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
})

-- set front_end
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

-- config of tab bar
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
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
config.window_background_opacity = 0.9935
config.win32_system_backdrop = "Auto" -- "Auto" or "Acrylic"

-- set domains
config.unix_domains = {}
-- config.ssh_backend = "Ssh2"
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
	{
		name = "Arch",
		remote_address = "127.0.0.1:11451",
		multiplexing = "None",
		username = "parsifa1",
		default_prog = { "fish" },
		assume_shell = "Posix",
		no_agent_auth = true,
	},
}

-- config wsl_domains
config.wsl_domains = {}

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
		action = wezterm.action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS | DOMAINS" }),
	},
	{
		key = '"',
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = ':',
		mods = "CTRL|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
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
-- config.ssh_domains = wezterm.default_ssh_domains()
config.color_scheme = "Catppuccin Mocha (Gogh)"
config.term = "wezterm"
config.animation_fps = 165
config.default_domain = "Arch"
config.font_size = 12.4
config.max_fps = 165
config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = "0.4cell",
	right = "0.25cell",
	top = "0.25cell",
	bottom = "0cell",
}

return config
