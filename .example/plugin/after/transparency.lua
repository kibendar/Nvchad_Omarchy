-- Defer transparency highlights to ColorScheme event for faster startup
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    -- Batch set highlights for better performance
    local transparent_groups = {
      "Normal",
      "NormalFloat",
      "FloatBorder",
      "Pmenu",
      "Terminal",
      "EndOfBuffer",
      "FoldColumn",
      "Folded",
      "SignColumn",
      "NormalNC",
      "WhichKeyFloat",
      "TelescopeBorder",
      "TelescopeNormal",
      "TelescopePromptBorder",
      "TelescopePromptTitle",
      "NeoTreeNormal",
      "NeoTreeNormalNC",
      "NeoTreeVertSplit",
      "NeoTreeWinSeparator",
      "NeoTreeEndOfBuffer",
      "NvimTreeNormal",
      "NvimTreeVertSplit",
      "NvimTreeEndOfBuffer",
      "NotifyINFOBody",
      "NotifyERRORBody",
      "NotifyWARNBody",
      "NotifyTRACEBody",
      "NotifyDEBUGBody",
      "NotifyINFOTitle",
      "NotifyERRORTitle",
      "NotifyWARNTitle",
      "NotifyTRACETitle",
      "NotifyDEBUGTitle",
      "NotifyINFOBorder",
      "NotifyERRORBorder",
      "NotifyWARNBorder",
      "NotifyTRACEBorder",
      "NotifyDEBUGBorder",
    }

    for _, group in ipairs(transparent_groups) do
      vim.api.nvim_set_hl(0, group, { bg = "none" })
    end
  end,
})

-- Apply once at startup
vim.schedule(function()
  vim.cmd("doautocmd ColorScheme")
end)
