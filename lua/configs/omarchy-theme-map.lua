-- Mapping from Omarchy themes to NvChad base46 themes
-- This file maps each Omarchy system theme to its corresponding NvChad theme

local M = {}

-- Map Omarchy theme names to NvChad base46 theme names
-- Based on NvChad available themes and best visual matches
M.theme_map = {
	gruvbox = "gruvchad", -- Gruvbox theme
	catppuccin = "catppuccin", -- Catppuccin Mocha (dark)
	["catppuccin-latte"] = "catppuccin", -- Catppuccin Latte (light) - needs background override
	everforest = "everforest", -- Everforest theme
	["flexoki-light"] = "flex-light", -- Flexoki light variant
	kanagawa = "kanagawa", -- Kanagawa theme
	["matte-black"] = "onedark", -- Matte black -> OneDark as closest match
	nord = "nord", -- Nord theme
	["osaka-jade"] = "tokyonight", -- Bamboo/Osaka -> Tokyo Night as green alternative
	ristretto = "monekai", -- Ristretto (warm monokai) -> Monokai Pro
	["rose-pine"] = "rosepine", -- Rose Pine theme
	["tokyo-night"] = "tokyonight", -- Tokyo Night theme
}

-- Special theme configurations for variants that need additional setup
M.theme_configs = {
	["catppuccin-latte"] = {
		setup = function()
			-- Catppuccin Latte is a light variant
			vim.o.background = "light"
		end,
	},
	ristretto = {
		setup = function()
			-- Ristretto is a Catppuccin mocha variant
			vim.o.background = "dark"
		end,
	},
	["flexoki-light"] = {
		setup = function()
			vim.o.background = "light"
		end,
	},
}

-- Get NvChad theme name from Omarchy theme file path
function M.get_nvchad_theme_from_omarchy()
	local omarchy_theme_file = vim.fn.stdpath("config") .. "/.omarchy-theme-link.lua"

	-- Check if symlink exists
	if vim.fn.filereadable(omarchy_theme_file) == 0 then
		-- Return default theme if file doesn't exist
		return "gruvchad"
	end

	-- Try to determine theme from symlink target
	local link_target = vim.fn.resolve(omarchy_theme_file)

	-- Extract theme name from path like: /home/user/.local/share/omarchy/themes/gruvbox/neovim.lua
	local theme_name = link_target:match("/omarchy/themes/([^/]+)/")

	if theme_name and M.theme_map[theme_name] then
		-- Run any special setup for this theme
		if M.theme_configs[theme_name] and M.theme_configs[theme_name].setup then
			M.theme_configs[theme_name].setup()
		end

		return M.theme_map[theme_name]
	end

	-- Return default if theme not found
	return "gruvchad"
end

return M
