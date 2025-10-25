require "nvchad.autocmds"

-- Omarchy theme sync: Ensure transparency is reapplied when theme changes
-- This autocmd ensures that transparency settings from chadrc.lua are properly
-- applied even after hot-reloading themes
vim.api.nvim_create_autocmd("ColorScheme", {
	callback = function()
		-- NvChad's base46 handles transparency, but we ensure it's reapplied
		-- after theme changes from Omarchy
		local chadrc = require("chadrc")
		if chadrc.base46 and chadrc.base46.transparency then
			-- Transparency is handled by base46, but we can add additional
			-- transparency customizations here if needed
			vim.schedule(function()
				-- Force a redraw to ensure all highlights are updated
				vim.cmd("redraw!")
			end)
		end
	end,
})
