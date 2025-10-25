local home = os.getenv("HOME")
local jdtls_path = home .. "/.local/share/nvim/mason/packages/jdtls"
local lombok_path = jdtls_path .. "/lombok.jar"
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = home .. "/jdtls-workspace/" .. project_name
-- Ensure workspace directory exists
vim.fn.mkdir(workspace_dir, "p")
-- Paths to java-debug and vscode-java-test plugins
local java_debug_path = home .. "/.local/share/java/java-debug"
local java_test_path = home .. "/.local/share/java/vscode-java-test"
-- Prepare bundles for extensions
local bundles = {}
if vim.fn.isdirectory(java_debug_path) == 1 then
  vim.list_extend(
    bundles,
    vim.split(
      vim.fn.glob(java_debug_path .. "/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
      "\n"
    )
  )
end
if vim.fn.isdirectory(java_test_path) == 1 then
  vim.list_extend(bundles, vim.split(vim.fn.glob(java_test_path .. "/server/*.jar", 1), "\n"))
end

local config = {
  cmd = {
    "java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. lombok_path,
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    "-jar",
    vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration",
    jdtls_path .. "/config_mac",
    "-data",
    workspace_dir, -- Use consistent workspace_dir variable
  },

  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  settings = {
    java = {
      signatureHelp = { enabled = true },
      completion = {
        favoriteStaticMembers = {
          "org.junit.jupiter.api.Assertions.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.*",
        },
      },
      configuration = {
        runtimes = {
          {
            name = "JavaSE-25",
            path = "/usr/lib/jvm/java-25-openjdk/",
          },
        },
      },
      -- Disable code style/formatting diagnostics
      format = {
        enabled = false,
      },
      -- Disable specific diagnostic categories
      compile = {
        nullAnalysis = {
          mode = "disabled",
        },
      },
      -- Eclipse JDT settings to disable style warnings
      eclipse = {
        downloadSources = true,
      },
      -- Disable cleanup and code style validation
      cleanup = {
        actionsOnSave = {},
      },
      -- Disable specific validation rules
      validation = {
        enabled = false,
      },
    },
  },
  init_options = {
    bundles = bundles,
    -- Disable specific diagnostic providers
    settings = {
      ["java.format.enabled"] = false,
      ["java.format.onType.enabled"] = false,
      ["java.format.insertSpaces"] = false,
      ["java.cleanup.actionsOnSave"] = {},
    },
  },
}
-- Setup keymaps and dap on_attach
local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)

  -- Disable specific diagnostic types for this buffer
  if client.name == "jdtls" then
    -- Filter out formatting/style diagnostics
    local original_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
    vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
      if result and result.diagnostics then
        -- Filter out style-related diagnostics
        result.diagnostics = vim.tbl_filter(function(diagnostic)
          local message = diagnostic.message:lower()
          -- Filter out common style warnings
          return not (
            message:find("indentation")
            or message:find("whitespace")
            or message:find("abbreviation")
            or message:find("consecutive capital letters")
            or message:find("incorrect indentation")
            or message:find("empty blocks")
            or message:find("method def")
          )
        end, result.diagnostics)
      end
      return original_handler(err, result, ctx, config)
    end

    require("jdtls.dap").setup_dap({ hotcodereplace = "auto" })
    -- Delay main class config to avoid triggering nil errors
    vim.defer_fn(function()
      require("jdtls.dap").fetch_main_configs({}, function(mainclasses)
        if not mainclasses or vim.tbl_isempty(mainclasses) then
          vim.notify("[jdtls] No main classes found", vim.log.levels.WARN)
        else
          require("jdtls.dap").setup_dap_main_class_configs({
            verbose = true,
            on_ready = function()
              print("[jdtls] Main class configurations updated")
            end,
          })
        end
      end)
    end, 7000) -- Wait 7 seconds to ensure project is loaded
  end
end
config.on_attach = on_attach
-- Only start jdtls if we're in a Java project
if require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }) then
  require("jdtls").start_or_attach(config)
end
