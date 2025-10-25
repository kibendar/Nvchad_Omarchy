local lint = require("lint")

lint.linters_by_ft = {
	javascript = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	java = { "checkstyle" },
	python = { "flake8" },
	c = { "cpplint" },
	cpp = { "cpplint" },
	lua = { "luacheck" },
	rust = { "bacon" }, -- Changed from ast-grep
	bash = { "shellcheck" },
	kotlin = { "ktlint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
	callback = function()
		lint.try_lint() -- Can use the local variable
	end,
})
