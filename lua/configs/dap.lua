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

-- ============================================================================
-- DAP Adapter Configurations
-- ============================================================================

-- Python debugger (debugpy)
dap.adapters.python = {
	type = "executable",
	command = "python",
	args = { "-m", "debugpy.adapter" },
}

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = function()
			-- Try to detect virtual environment
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			end
			-- Check for common venv locations
			if vim.fn.executable(".venv/bin/python") == 1 then
				return ".venv/bin/python"
			elseif vim.fn.executable("venv/bin/python") == 1 then
				return "venv/bin/python"
			end
			-- Fallback to system python
			return "python"
		end,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch file with arguments",
		program = "${file}",
		args = function()
			local args_string = vim.fn.input("Arguments: ")
			return vim.split(args_string, " +")
		end,
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			end
			if vim.fn.executable(".venv/bin/python") == 1 then
				return ".venv/bin/python"
			elseif vim.fn.executable("venv/bin/python") == 1 then
				return "venv/bin/python"
			end
			return "python"
		end,
	},
	{
		type = "python",
		request = "launch",
		name = "Django",
		program = "${workspaceFolder}/manage.py",
		args = { "runserver" },
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			end
			if vim.fn.executable(".venv/bin/python") == 1 then
				return ".venv/bin/python"
			elseif vim.fn.executable("venv/bin/python") == 1 then
				return "venv/bin/python"
			end
			return "python"
		end,
	},
	{
		type = "python",
		request = "launch",
		name = "Flask",
		module = "flask",
		env = {
			FLASK_APP = "app.py",
		},
		args = { "run", "--no-debugger", "--no-reload" },
		pythonPath = function()
			local venv = os.getenv("VIRTUAL_ENV")
			if venv then
				return venv .. "/bin/python"
			end
			if vim.fn.executable(".venv/bin/python") == 1 then
				return ".venv/bin/python"
			elseif vim.fn.executable("venv/bin/python") == 1 then
				return "venv/bin/python"
			end
			return "python"
		end,
	},
}

-- C/C++/Rust debugger (codelldb)
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = vim.fn.exepath("codelldb"),
		args = { "--port", "${port}" },
	},
}

dap.configurations.cpp = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

dap.configurations.c = dap.configurations.cpp

dap.configurations.rust = {
	{
		name = "Launch file",
		type = "codelldb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
	{
		name = "Launch tests",
		type = "codelldb",
		request = "launch",
		program = function()
			-- Find the test executable in target/debug/deps/
			local handle = io.popen("ls -t " .. vim.fn.getcwd() .. "/target/debug/deps/*-* 2>/dev/null | head -1")
			if handle then
				local result = handle:read("*a")
				handle:close()
				return vim.fn.trim(result)
			end
			return vim.fn.input("Path to test executable: ", vim.fn.getcwd() .. "/target/debug/deps/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
	},
}

-- JavaScript/TypeScript debugger (node-debug2 / pwa-node)
dap.adapters["pwa-node"] = {
	type = "server",
	host = "localhost",
	port = "${port}",
	executable = {
		command = "node",
		args = {
			vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
			"${port}",
		},
	},
}

dap.configurations.javascript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

dap.configurations.typescript = {
	{
		type = "pwa-node",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		cwd = "${workspaceFolder}",
		runtimeExecutable = "ts-node",
		runtimeArgs = { "--esm" },
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
		resolveSourceMapLocations = {
			"${workspaceFolder}/**",
			"!**/node_modules/**",
		},
	},
	{
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require("dap.utils").pick_process,
		cwd = "${workspaceFolder}",
	},
}

-- Go debugger (delve)
dap.adapters.delve = {
	type = "server",
	port = "${port}",
	executable = {
		command = "dlv",
		args = { "dap", "-l", "127.0.0.1:${port}" },
	},
}

dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

-- Bash debugger (bash-debug-adapter)
dap.adapters.bashdb = {
	type = "executable",
	command = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/bash-debug-adapter",
	name = "bashdb",
}

dap.configurations.sh = {
	{
		type = "bashdb",
		request = "launch",
		name = "Launch file",
		showDebugOutput = true,
		pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
		pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
		trace = true,
		file = "${file}",
		program = "${file}",
		cwd = "${workspaceFolder}",
		pathCat = "cat",
		pathBash = "/bin/bash",
		pathMkfifo = "mkfifo",
		pathPkill = "pkill",
		args = {},
		env = {},
		terminalKind = "integrated",
	},
}

-- Kotlin debugger (uses Java debugger via jdtls)
-- This is handled by nvim-jdtls plugin

-- Setup DAP UI
local dapui = require("dapui")
dapui.setup()

-- Auto open/close DAP UI
dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end
