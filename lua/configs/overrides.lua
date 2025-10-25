local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "typescript",
    "jsx",
    "tsx",
    "c",
    "markdown",
    "markdown_inline",
    "prisma",
    "vue",
    "go",
    "java",
    "python",
    "c",
    "cpp",
    "bash",
    "json",
    "yaml",
    "toml",
    "sql",
    "rust",
    "shell",
  },
  indent = {
    enable = true,
  },
}

M.mason = {
  ensure_installed = {
    "lua-language-server",
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",
    "eslint_d",
    "clangd",
    "clang-format",
    "node-debug2-adapter",
    "gopls",
    "gradle_ls",
    "jdtls",
    "pyright",
  },
}

-- git support in nvimtree
M.nvimtree = {
  filters = {
    dotfiles = false, -- Show hidden files (files starting with .)
    git_clean = false, -- Show files ignored by git
    no_buffer = false,
    custom = {},
  },
  git = {
    enable = true,
    ignore = false, -- Show .gitignore'd files
    show_on_dirs = true,
    timeout = 400,
  },
  view = {
    show_hidden = true, -- Alternative way to show hidden files
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
