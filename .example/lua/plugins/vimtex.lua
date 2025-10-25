return {
  "lervag/vimtex",
  ft = { "tex", "latex", "plaintex" },
  config = function()
    vim.g.vimtex_quickfix_ignore_filters = {
      "Overfull \\hbox",
      "Overfull \\vbox",
      "Underfull \\hbox",
      "Underfull \\vbox",
    }

    vim.g.vimtex_quickfix_open_on_warning = 0
  end,
}
