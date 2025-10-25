require("nvchad.options")

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- add yours here!

vim.opt.number = true

vim.opt.relativenumber = true

vim.opt.signcolumn = "yes"

-- Enable spell checking
vim.opt.spell = true

vim.opt.spelllang = "en_us"

vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/custom.utf-8.add"

-- Use both tree-sitter and spell for better detection
vim.opt.spelloptions = "camel"

-- Set tab size to 4 spaces (change 4 to your preferred size)
-- vim.opt.tabstop = 4 -- Number of spaces a tab counts for
-- vim.opt.shiftwidth = 4 -- Number of spaces for each step of autoindent
-- vim.opt.expandtab = true -- Use spaces instead of tabs
-- vim.opt.softtabstop = 4 -- Number of spaces a tab counts for in insert mode
--
-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
