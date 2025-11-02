local mason_dap = require("mason-nvim-dap")

mason_dap.setup({
	-- Automatically install debug adapters
	ensure_installed = {
		"python", -- debugpy
		"codelldb", -- C, C++, Rust
		"delve", -- Go
		"js", -- JavaScript/TypeScript (js-debug-adapter)
		"bash", -- Bash
	},

	-- Auto-install configured adapters when entering supported filetype
	automatic_installation = true,

	-- Additional handlers for specific adapters
	handlers = {
		function(config)
			-- Default handler - applies to all adapters
			mason_dap.default_setup(config)
		end,
	},
})
