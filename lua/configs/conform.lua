local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettier" },
		yml = { "prettier" },
		tex = { "latexindent" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		markdown = { "markdownlint" },
		java = { "clang-format" },
		python = { "black" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		xml = { "xmlformatter" },
		bash = { "beautysh" },
		sh = { "beautysh" },
		rs = { "ast-grep" },
		kt = { "ast-grep" },
		typ = { "prettypst" },
	},

	format_on_save = {
		--   -- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

return options
