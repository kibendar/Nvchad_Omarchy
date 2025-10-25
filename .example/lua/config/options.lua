-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Enable spell checking
vim.opt.spell = true

-- Set spell languages (English, Ukrainian, Russian)
vim.opt.spelllang = { "en", "uk", "ru" }

-- Use both tree-sitter and spell for better detection
vim.opt.spelloptions = "camel"

-- Defer highlight groups and matches to VimEnter for faster startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    -- Define custom highlight groups
    vim.api.nvim_set_hl(0, "CheckMark", { fg = "#1DCF17" })
    vim.api.nvim_set_hl(0, "CrossMark", { fg = "#E61A24" })

    -- Add matches that work in all buffers
    vim.fn.matchadd("CheckMark", "✔")
    vim.fn.matchadd("CrossMark", "✗")

    -- Define custom highlight groups for checkbox states
    vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = "#FFA500", bold = true }) -- Orange
    vim.api.nvim_set_hl(0, "RenderMarkdownRightArrow", { fg = "#00BFFF", bold = true }) -- Deep Sky Blue
    vim.api.nvim_set_hl(0, "RenderMarkdownTilde", { fg = "#FFD700", bold = true }) -- Gold
    vim.api.nvim_set_hl(0, "RenderMarkdownImportant", { fg = "#FF6B6B", bold = true }) -- Red
  end,
})
