return {
	{
		"stevearc/conform.nvim",
		event = "BufWritePre", -- uncomment for format on save
		opts = require("configs.conform"),
	},
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
	},
	{
		"chomosuke/typst-preview.nvim",
		lazy = false, -- or ft = 'typst'
		version = "1.*",
		opts = {}, -- lazy.nvim will implicitly calls `setup {}`
	},
	{
		"lervag/vimtex",
		lazy = false,
		config = function()
			require("configs.vimtex")
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
		config = function()
			require("configs.harpoon")
		end,
	},
	{
		"HakonHarnes/img-clip.nvim",
		events = "VeryLazy",
		config = function()
			require("configs.img-clip")
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.nvim-colorizer")
		end,
	},
	{
		"epwalsh/obsidian.nvim",
		version = "*", -- recommended, use latest release instead of latest commit
		lazy = true,
		ft = "markdown",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("configs.obsidian")
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-nvim-lsp",
		},
	},
	{
		"hrsh7th/cmp-buffer",
	},
	{
		"hrsh7th/cmp-path",
	},
	{
		"hrsh7th/cmp-cmdline",
	},
	{
		"hrsh7th/cmp-nvim-lsp",
	},
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("configs.nvim-tree")
		end,
	},
	{
		"sontungexpt/url-open",
		branch = "mini",
		event = "VeryLazy",
		cmd = "URLOpenUnderCursor",
		config = function()
			require("configs.url-open")
		end,
	},
	{
		"3rd/image.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "markdown", "norg", "html" }, -- Load on specific filetypes
		config = function()
			require("configs.image")
		end,
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		ft = "markdown",
		config = function()
			require("configs.render-markdown")
		end,
	},
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
		},
	},
	{
		"stevearc/dressing.nvim",
		lazy = false,
		opts = {},
	},
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("configs.lint")
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		event = "VeryLazy",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
		-- use opts = {} for passing setup options
		-- this is equivalent to setup({}) function
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup()
		end,
	},

	-- These are some examples, uncomment them if you want to see them work!
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("nvchad.configs.lspconfig").defaults()
			require("configs.lspconfig")
		end,
	},

	-- test new blink
	{ import = "nvchad.blink.lazyspec" },

	-- Alternative: If you want more granular control, you can also add wildmenu enhancement
	{
		"gelguy/wilder.nvim",
		lazy = false,
		config = function()
			require("configs.wilder")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"python",
				"java",
				"cpp",
				"c",
				"markdown",
			},
		},
	},
	{
		"mfussenegger/nvim-jdtls", -- Java LSP support
		lazy = true,
		ft = { "java" },
	},
	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("configs.dap_vt")
		end,
	},
	{
		"rcarriga/cmp-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			require("configs.dap")
		end,
	},
	-- Maven.nvim plugin configuration
	{
		"eatgrass/maven.nvim",
		cmd = { "Maven", "MavenExec" },
		dependencies = "nvim-lua/plenary.nvim",
		ft = "java", -- Only load for Java files
		config = function()
			require("configs.maven")
		end,
	},

	{
		"folke/neodev.nvim",
		config = function()
			require("neodev").setup({
				library = { plugins = { "nvim-dap-ui", "nvchad" }, types = true },
			})
		end,
	},
	{
		"nvim-neotest/nvim-nio",
	},
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/neotest-java",
			"rcasia/neotest-java",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-java")({
						ignore_wrapper = false,
					}),
				},
			})
		end,
	},

	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({})
		end,
	},
	{
		"Wansmer/langmapper.nvim",
		lazy = false,
		priority = 1, -- High priority is needed if you will use `autoremap()`
		config = function()
			require("langmapper").setup({--[[ your config ]]
			})
		end,
	},
	{
		"tpope/vim-fugitive",
	},
	{
		"rbong/vim-flog",
		dependencies = {
			"tpope/vim-fugitive",
		},
		lazy = false,
	},
	{
		"sindrets/diffview.nvim",
		lazy = false,
	},
	{
		"ggandor/leap.nvim",
		lazy = false,
		config = function()
			require("leap").add_default_mappings(true)
		end,
	},
	{
		"kevinhwang91/nvim-bqf",
		lazy = false,
	},
	{
		"folke/trouble.nvim",
		lazy = false,
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		lazy = false,
		config = function()
			require("todo-comments").setup()
		end,
	}, -- To make a plugin not be loaded
	{
		"Exafunction/codeium.vim",
		lazy = false,
	},
	{
		"elmcgill/springboot-nvim",
		lazy = true,
		ft = { "java" },
		dependencies = {
			"neovim/nvim-lspconfig",
			"mfussenegger/nvim-jdtls",
		},
		config = function()
			require("springboot-nvim").setup({
				-- Optional configuration
				jdtls_name = "nvim-jdtls",
				log_level = vim.log.levels.INFO,
			})
		end,
	},
}
