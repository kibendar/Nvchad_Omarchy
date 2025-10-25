-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

-- Get theme from Omarchy if available, otherwise use default
local function get_theme()
	local ok, theme_map = pcall(require, "configs.omarchy-theme-map")
	if ok then
		return theme_map.get_nvchad_theme_from_omarchy()
	end
	return "gruvchad" -- fallback theme
end

M.base46 = {
	theme = get_theme(),
	transparency = true,
	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.nvdash = {
	load_on_startup = true,
	buttons = {
		{ txt = "  Find File", keys = "f", cmd = "Telescope find_files" },
		{ txt = "  Recent Files", keys = "r", cmd = "Telescope oldfiles" },
		{ txt = "󰈭  Find Word", keys = "w", cmd = "Telescope live_grep" },
		{ txt = "󱥚  Themes", keys = "th", cmd = ":lua require('nvchad.themes').open()" },
		{ txt = "  Mappings", keys = "ch", cmd = "NvCheatsheet" },
		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
		{
			txt = function()
				local stats = require("lazy").stats()
				local ms = math.floor(stats.startuptime) .. " ms"
				return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
			end,
			hl = "NvDashFooter",
			no_gap = true,
			content = "fit",
		},
		{ txt = "─", hl = "NvDashFooter", no_gap = true, rep = true },
	},
}

M.ui = {
	tabufline = {
		enabled = true,
		lazyload = true,
		order = { "treeOffset", "buffers", "tabs", "btns" },
		modules = nil,
		bufwidth = 21,
	},
	telescope = { style = "bordered" },
	statusline = {
		enabled = true,
		theme = "minimal",
		separator_style = "round",
		order = nil,
		modules = nil,
	},
}

M.term = {
	base46_colors = true,
	winopts = { number = true, relativenumber = true },
	sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
	float = {
		relative = "editor",
		row = 0.3,
		col = 0.25,
		width = 0.5,
		height = 0.4,
		border = "single",
	},
}

M.colorify = {
	enabled = true,
	mode = "virtual",
	virt_text = "󱓻 ",
	highlight = { hex = true, lspvars = true },
}

return M
