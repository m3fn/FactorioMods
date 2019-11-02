
if settings.startup['composite-combinators-dev-mode'].value then

local minWidth = 380
local minHeight = 400
data.raw["gui-style"]["default"]["composite_combinators_settings_textfield"] = {
    minimal_width = 50,
	type = "textbox_style"
}
data.raw["gui-style"]["default"]["composite_combinators_settings_textbox"] = {
    minimal_width = 280,
	minimal_height = 280,
	type = "textbox_style"
}
data.raw["gui-style"]["default"]["composite_combinators_settings_label"] = {
    minimal_width = 140,
    maximal_width = 140,
    parent = "label",
	type = "label_style"
}
data.raw["gui-style"]["default"]["composite_combinators_settings_container"] = {
    minimal_width = minWidth,
    maximal_width = minWidth,
	minimal_height = minHeight,
	maximal_height = minHeight,
    parent = "frame",
	type = "frame_style"
}
data.raw["gui-style"]["default"]["composite_combinators_settings_container_small"] = {
    minimal_width = minWidth,
    maximal_width = minWidth,
	minimal_height = 120,
	maximal_height = 120,
    parent = "frame",
	type = "frame_style"
}
data.raw["gui-style"]["default"]["composite_combinators_settings_button"] = {
    parent = "button",
	type = "button_style"
}

end


