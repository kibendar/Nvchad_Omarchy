local present, dap = pcall(require, "dap")
if not present then
  return
end

-- Define highlight groups
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapStopped", { fg = "#e51400" })
vim.api.nvim_set_hl(0, "DapStoppedLine", { bg = "#2d1414" })
vim.api.nvim_set_hl(0, "DapLogPoint", { fg = "#61afef" })

-- Define signs (modern Lua approach)
vim.fn.sign_define("DapBreakpoint", {
  text = "●", -- Red circle
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapStopped", {
  text = "→", -- Red arrow
  texthl = "DapStopped",
  linehl = "DapStoppedLine",
  numhl = "DapStopped",
})

vim.fn.sign_define("DapBreakpointCondition", {
  text = "◐",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapBreakpointRejected", {
  text = "◯",
  texthl = "DapBreakpoint",
  linehl = "",
  numhl = "",
})

vim.fn.sign_define("DapLogPoint", {
  text = "◆",
  texthl = "DapLogPoint",
  linehl = "",
  numhl = "",
})
