-- lua/config/lspconfig.lua
local lspconfig = require("lspconfig")

-- Updated ltex configuration with reduced verbosity
lspconfig.ltex.setup({
  capabilities = capabilities,
  -- Disable progress messages
  handlers = {
    ["$/progress"] = function() end, -- Completely disable progress messages for ltex
  },
  settings = {
    ltex = {
      language = "auto",
      -- Reduce verbosity
      trace = {
        server = "off", -- Turn off server tracing
      },
      -- Add checkFrequency to reduce how often it checks
      checkFrequency = "save", -- Only check on save, not on every change
      additionalRules = {
        enablePickyRules = true,
        motherTongue = "en-US",
      },
      dictionary = {
        ["en-US"] = {},
        ["uk"] = {},
        ["ru"] = {},
      },
      disabledRules = {
        ["en-US"] = {},
        ["uk"] = {},
        ["ru"] = {},
      },
    },
  },
})

-- Python Language Server
lspconfig.pyright.setup({
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = {
    "pyproject.toml",
    "setup.py",
    "setup.cfg",
    "requirements.txt",
    "Pipfile",
    "pyrightconfig.json",
    ".git",
  },
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace", -- or "openFilesOnly" for better performance
        typeCheckingMode = "basic", -- "off", "basic", or "strict"
      },
    },
  },
  single_file_support = true,
})

-- TypeScript/JavaScript Language Server
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
})

-- HTML Language Server
lspconfig.html.setup({
  capabilities = capabilities,
  settings = {
    html = {
      format = {
        templating = true,
        wrapLineLength = 120,
        wrapAttributes = "auto",
      },
      hover = {
        documentation = true,
        references = true,
      },
    },
  },
})

-- CSS Language Server
lspconfig.cssls.setup({
  capabilities = capabilities,
  settings = {
    css = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    scss = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
    less = {
      validate = true,
      lint = {
        unknownAtRules = "ignore",
      },
    },
  },
})

-- C/C++ Language Server (clangd is recommended over ast-grep for LSP)
lspconfig.clangd.setup({
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
    "--fallback-style=llvm",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

-- Rust Language Server
lspconfig.rust_analyzer.setup({
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true,
        runBuildScripts = true,
      },
      checkOnSave = {
        allFeatures = true,
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
      procMacro = {
        enable = true,
        ignored = {
          ["async-trait"] = { "async_trait" },
          ["napi-derive"] = { "napi" },
          ["async-recursion"] = { "async_recursion" },
        },
      },
    },
  },
})

-- Lua Language Server
lspconfig.lua_ls.setup({
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

-- Bash Language Server
lspconfig.bashls.setup({
  capabilities = capabilities,
  filetypes = { "sh", "bash" },
})

-- Kotlin Language Server
lspconfig.kotlin_language_server.setup({
  capabilities = capabilities,
})

lspconfig.tinymist.setup({
  cmd = { "tinymist" }, -- make sure 'tinymist' is in your PATH
  filetypes = { "typst", "typ" },
  root_markers = { ".git", "typst.toml" },
  settings = {
    tinymist = {
      -- optional settings if tinymist supports them
      lint = true, -- enable diagnostics/linting
      completion = true, -- enable completion
      hover = true, -- hover info
      outline = true, -- symbols/document outline
    },
  },
  single_file_support = true,
})
