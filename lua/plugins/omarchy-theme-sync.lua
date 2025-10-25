-- Omarchy theme synchronization plugin for NvChad
-- This plugin watches for Omarchy theme changes and automatically updates NvChad's theme

return {
	{
		name = "omarchy-theme-sync",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 999, -- Load before theme application but after base46
		config = function()
			local theme_map = require("configs.omarchy-theme-map")
			local omarchy_symlink = vim.fn.stdpath("config") .. "/.omarchy-theme-link.lua"

			-- Function to apply the current Omarchy theme to NvChad
			local function apply_omarchy_theme()
				local nvchad_theme = theme_map.get_nvchad_theme_from_omarchy()

				-- Update the chadrc cache/config
				local chadrc = require("chadrc")
				if chadrc.base46 then
					chadrc.base46.theme = nvchad_theme
				end

				-- Reload base46 theme
				vim.schedule(function()
					-- Clear highlights
					vim.cmd("highlight clear")

					-- Reload base46 with new theme
					require("base46").load_all_highlights()

					-- Trigger ColorScheme autocommand for transparency and other customizations
					vim.api.nvim_exec_autocmds("ColorScheme", { modeline = false })

					-- Force redraw
					vim.cmd("redraw!")
				end)
			end

			-- Watch for changes to the Omarchy theme symlink
			local function setup_theme_watcher()
				-- Create the symlink if it doesn't exist
				local omarchy_current = "/home/" .. vim.fn.expand("$USER") .. "/.config/omarchy/current/theme/neovim.lua"

				-- Try to create symlink if it doesn't exist
				if vim.fn.filereadable(omarchy_current) == 1 and vim.fn.filereadable(omarchy_symlink) == 0 then
					vim.fn.system({ "ln", "-sf", omarchy_current, omarchy_symlink })
				end

				-- Set up file watcher using vim.loop (libuv)
				local uv = vim.loop or vim.uv

				-- Watch the parent directory since symlinks can't be watched directly
				local watch_dir = vim.fn.stdpath("config")

				-- Use a timer to periodically check the symlink target
				-- This is more reliable than trying to watch a symlink directly
				local last_target = vim.fn.resolve(omarchy_symlink)

				local timer = uv.new_timer()
				if timer then
					timer:start(
						1000, -- Start after 1 second
						2000, -- Check every 2 seconds
						vim.schedule_wrap(function()
							if vim.fn.filereadable(omarchy_symlink) == 1 then
								local current_target = vim.fn.resolve(omarchy_symlink)
								if current_target ~= last_target then
									last_target = current_target
									-- Theme changed, reload
									apply_omarchy_theme()
								end
							end
						end)
					)
				end
			end

			-- Apply theme on startup
			apply_omarchy_theme()

			-- Setup the watcher
			setup_theme_watcher()

			-- Also provide a manual command to sync theme
			vim.api.nvim_create_user_command("OmarchySyncTheme", function()
				apply_omarchy_theme()
				vim.notify("Omarchy theme synchronized", vim.log.levels.INFO)
			end, { desc = "Manually sync Omarchy theme to NvChad" })
		end,
	},
}
