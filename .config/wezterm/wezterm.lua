local wezterm = require('wezterm')

return {
	font = wezterm.font('Noto Sans Mono CJK JP', 
		{weight='Medium', stretch='Normal', style='Normal'}),
	use_ime = true,
	keys = require('keybinds').keys,
	key_tables = require('keybinds').key_tables,
	disable_default_key_bindings = true,
	animation_fps = 60,
	prefer_egl = true,
	font_size = 13.0,
	use_fancy_tab_bar = false,
	color_scheme = 'Catppuccin Mocha',
}
