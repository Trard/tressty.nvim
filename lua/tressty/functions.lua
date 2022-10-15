local config = require('tressty.config').options

-- Define style_switch
if vim.g.tressty_style_switch == nil then
    vim.g.tressty_style_switch = 0
end

local set_lualine = function ()
	local has_lualine, lualine = pcall(require, "lualine")
	if has_lualine then
		lualine.setup {
			options = {
				theme = "auto"
			}
		}
	end
end

-- Change_style takes a style name as a parameter and switches to that style
local change_style = function (style)
	set_lualine()
	vim.g.tressty_style = style
	print("tressty style: ", style)
	vim.cmd "colorscheme tressty"
 end

-- Toggle_style takes no parameters toggles the style on every function call
local toggle_style = function ()
	local switch = { "darker", "lighter", "palenight", "oceanic", "deep ocean" }
	vim.g.tressty_style_switch = (vim.g.tressty_style_switch % table.getn(switch)) + 1
	change_style(switch[vim.g.tressty_style_switch])
end

local toggle_eob = function ()
	if config.disable.eob_lines == true then
		config.disable.eob_lines = false
	else
		config.disable.eob_lines = true
	end

	local editor = require("tressty.theme").loadEditor()
	require("tressty.util").highlight( "EndOfBuffer", editor.EndOfBuffer)
end

local find_style = function ()
	require "tressty.telescope_switcher".find()
end

return {
	set_lualine = set_lualine,
	change_style = change_style,
	toggle_style = toggle_style,
	toggle_eob = toggle_eob,
	find_style = find_style
}

