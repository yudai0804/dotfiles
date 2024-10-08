local wezterm = require("wezterm")

return {
	font = wezterm.font("Noto Sans Mono CJK JP", { weight = "Medium", stretch = "Normal", style = "Normal" }),
	use_ime = true,
	animation_fps = 60,
	prefer_egl = true,
	font_size = 12.0,
	use_fancy_tab_bar = false
}
