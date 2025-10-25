return {
  "mfussenegger/nvim-lint",

  opts = {
    linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      java = { "checkstyle" },
      python = { "flake8" },
      c = { "cpplint" },
      cpp = { "cpplint" },
      lua = { "luacheck" },
      rust = { "ast-grep" },
      bash = { "shellcheck" },
      kotlin = { "ktlint" },
    },
  },
}
