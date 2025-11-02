require("nvchad.mappings")

local map = vim.keymap.set

-- Diagnostics Toggle Function
local M = {}
local errors_only_mode = false

M.toggle_diagnostics = function()
	if errors_only_mode then
		-- Currently showing errors only, show all
		vim.diagnostic.config({
			virtual_text = true,
			signs = true,
			underline = true,
		})
		errors_only_mode = false
		print("Showing all diagnostics")
	else
		-- Show errors only
		vim.diagnostic.config({
			virtual_text = { severity = { min = vim.diagnostic.severity.ERROR } },
			signs = { severity = { min = vim.diagnostic.severity.ERROR } },
			underline = { severity = { min = vim.diagnostic.severity.ERROR } },
		})
		errors_only_mode = true
		print("Showing errors only")
	end
end

function AddAllMisspelledWords()
	local count = 0
	while true do
		-- Move to next misspelled word
		vim.cmd("normal! ]s")

		-- Check if we're still on a misspelled word
		local ok, result = pcall(vim.fn.spellbadword)
		if not ok or #result == 0 or result[1] == "" then
			break -- No more misspelled words
		end

		-- Add the word to dictionary
		vim.cmd("normal! zg")
		count = count + 1
	end

	if count > 0 then
		print("Added " .. count .. " words to dictionary")
	else
		print("No misspelled words found")
	end
end

-- map("n", ";", ":", { desc = "CMD enter command mode" })

-- Diagnostics Toggle
map("n", "<leader>td", M.toggle_diagnostics, { desc = "Toggle diagnostics level" })

-- Spell checking keymaps
map("n", "<leader>s", function()
	vim.opt.spell = not vim.opt.spell:get()
end, { desc = "Toggle spell check" })

map("n", "]s", "]s", { desc = "Next misspelled word" })

map("n", "[s", "[s", { desc = "Previous misspelled word" })

map("n", "z=", "z=", { desc = "Suggest corrections" })

map("n", "zg", "zg", { desc = "Add word to dictionary" })

map("n", "zw", "zw", { desc = "Mark word as incorrect" })

map("n", "<leader>az", AddAllMisspelledWords, { desc = "Add all misspelled words to dictionary" })

-- Navigation & Definition Functions
map("n", "<leader>lgd", function()
	vim.lsp.buf.definition()
end, { desc = "LSP Go to Definition" })

map("n", "<leader>lgD", function()
	vim.lsp.buf.declaration()
end, { desc = "LSP Go to Declaration" })

map("n", "<leader>lgi", function()
	vim.lsp.buf.implementation()
end, { desc = "LSP Go to Implementation" })

map("n", "<leader>lgr", function()
	vim.lsp.buf.references()
end, { desc = "LSP Find References" })

map("n", "<leader>lD", function()
	vim.lsp.buf.type_definition()
end, { desc = "LSP Type Definition" })

-- Code Actions & Refactoring
map("n", "<leader>lca", function()
	vim.lsp.buf.code_action()
end, { desc = "LSP Code Actions (Generate Missing Methods)" })

map("n", "<leader>lrn", function()
	vim.lsp.buf.rename()
end, { desc = "LSP Rename Symbol" })

map("n", "<leader>lfm", function()
	vim.lsp.buf.format()
end, { desc = "LSP Format Buffer" })

map("v", "<leader>lfs", function()
	vim.lsp.buf.format()
end, { desc = "LSP Format Selection" })

-- Documentation & Hover
map("n", "lh", function()
	vim.lsp.buf.hover()
end, { desc = "LSP Hover Documentation" })

map("n", "<leader>lk", function()
	vim.lsp.buf.signature_help()
end, { desc = "LSP Signature Help" })

-- Symbol & Document Functions
map("n", "<leader>lds", function()
	vim.lsp.buf.document_symbol()
end, { desc = "LSP Document Symbols" })

map("n", "<leader>lws", function()
	vim.lsp.buf.workspace_symbol()
end, { desc = "LSP Workspace Symbols" })

-- Document Highlighting
map("n", "<leader>ldh", function()
	vim.lsp.buf.document_highlight()
end, { desc = "LSP Document Highlight" })

map("n", "<leader>lcr", function()
	vim.lsp.buf.clear_references()
end, { desc = "LSP Clear References" })

-- Call Hierarchy
map("n", "<leader>lic", function()
	vim.lsp.buf.incoming_calls()
end, { desc = "LSP Incoming Calls" })

map("n", "<leader>loc", function()
	vim.lsp.buf.outgoing_calls()
end, { desc = "LSP Outgoing Calls" })

-- Type Hierarchy
map("n", "<leader>lts", function()
	vim.lsp.buf.typehierarchy("subtypes")
end, { desc = "LSP Type Subtypes" })

map("n", "<leader>ltS", function()
	vim.lsp.buf.typehierarchy("supertypes")
end, { desc = "LSP Type Supertypes" })

-- Selection Range
map("n", "<leader>les", function()
	vim.lsp.buf.selection_range(1)
end, { desc = "LSP Expand Selection" })

map("n", "<leader>lss", function()
	vim.lsp.buf.selection_range(-1)
end, { desc = "LSP Shrink Selection" })

-- Workspace Folder Management
map("n", "<leader>law", function()
	vim.lsp.buf.add_workspace_folder()
end, { desc = "LSP Add Workspace Folder" })

map("n", "<leader>lrw", function()
	vim.lsp.buf.remove_workspace_folder()
end, { desc = "LSP Remove Workspace Folder" })

map("n", "<leader>llw", function()
	print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, { desc = "LSP List Workspace Folders" })

-- Workspace Diagnostics
map("n", "<leader>lwd", function()
	vim.lsp.buf.workspace_diagnostics()
end, { desc = "LSP Workspace Diagnostics" })

-- Alternative: If you want to keep LSP formatting as backup, use different keybinding
map("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "LSP Format Document" })

-- Conform.nvim Formatting (replaces LSP formatting)
map("n", "<leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = true,
		timeout_ms = 1000,
	})
end, { desc = "Format Document with Conform" })
map("v", "<leader>f", function()
	require("conform").format({
		lsp_fallback = true,
		async = true,
		timeout_ms = 200,
	})
end, { desc = "Format Selection with Conform" })

-- Trouble
map("n", "<leader>qx", "<cmd>TroubleToggle<CR>", { desc = "Open Trouble" })
map("n", "<leader>qw", "<cmd>TroubleToggle workspace_diagnostics<CR>", { desc = "Open Workspace Trouble" })
map("n", "<leader>qd", "<cmd>TroubleToggle document_diagnostics<CR>", { desc = "Open Document Trouble" })
map("n", "<leader>qq", "<cmd>TroubleToggle quickfix<CR>", { desc = "Open Quickfix" })
map("n", "<leader>ql", "<cmd>TroubleToggle loclist<CR>", { desc = "Open Location List" })
map("n", "<leader>qt", "<cmd>TodoTrouble<CR>", { desc = "Open Todo Trouble" })

-- Java Development
map("n", "<leader>jo", function()
	require("jdtls").organize_imports()
end, { desc = "Organize Imports" })
map("n", "<leader>jv", function()
	require("jdtls").extract_variable()
end, { desc = "Extract Variable" })
map("n", "<leader>jc", function()
	require("jdtls").extract_constant()
end, { desc = "Extract Constant" })
map("n", "<leader>jm", function()
	require("jdtls").extract_method()
end, { desc = "Extract Method" })

-- Java Debugging & Testing (JDTLS)
map("n", "<leader>jd", function()
	require("jdtls.dap").setup_dap_main_class_configs()
end, { desc = "JDTLS: Setup Main Class DAP Configs" })
map("n", "<leader>jt", function()
	require("jdtls.dap").test_class()
end, { desc = "JDTLS: Debug Test Class" })
map("n", "<leader>jn", function()
	require("jdtls.dap").test_nearest_method()
end, { desc = "JDTLS: Debug Nearest Test Method" })
map("n", "<leader>jg", function()
	require("jdtls.tests").generate()
end, { desc = "JDTLS: Generate Test Class" })
map("n", "<leader>js", function()
	require("jdtls.tests").goto_subjects()
end, { desc = "JDTLS: Go To Related Subjects" })

-- Tests
map("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Test Nearest" })
map("n", "<leader>tf", function()
	require("neotest").run.run(vim.fn.expand("%"))
end, { desc = "Test File" })
map("n", "<leader>ts", function()
	require("neotest").summary.toggle()
end, { desc = "Test Summary" })
map("n", "<leader>to", function()
	require("neotest").output.open({ enter = true })
end, { desc = "Test Output" })

-- Debug - Session Control
map("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Debug Continue" })
map("n", "<leader>dC", function()
	require("dap").run_to_cursor()
end, { desc = "Debug Run to Cursor" })
map("n", "<leader>dp", function()
	require("dap").pause()
end, { desc = "Debug Pause" })
map("n", "<leader>dq", function()
	require("dap").terminate()
end, { desc = "Debug Terminate" })
map("n", "<leader>dQ", function()
	require("dap").close()
end, { desc = "Debug Close Session" })
map("n", "<leader>dr", function()
	require("dap").restart()
end, { desc = "Debug Restart" })
map("n", "<leader>dR", function()
	require("dap").restart_frame()
end, { desc = "Debug Restart Frame" })

-- Debug - Stepping
map("n", "<leader>do", function()
	require("dap").step_over()
end, { desc = "Debug Step Over" })
map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Debug Step Into" })
map("n", "<leader>du", function()
	require("dap").step_out()
end, { desc = "Debug Step Out" })
map("n", "<leader>dj", function()
	require("dap").down()
end, { desc = "Debug Down Stack" })
map("n", "<leader>dk", function()
	require("dap").up()
end, { desc = "Debug Up Stack" })

-- Debug - Breakpoints
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Debug Toggle Breakpoint" })
map("n", "<leader>dB", function()
	require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug Conditional Breakpoint" })
map("n", "<leader>dL", function()
	require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end, { desc = "Debug Log Point" })
map("n", "<leader>dx", function()
	require("dap").clear_breakpoints()
end, { desc = "Debug Clear All Breakpoints" })
map("n", "<leader>dl", function()
	require("dap").list_breakpoints()
end, { desc = "Debug List Breakpoints" })

-- Debug - UI & REPL
map("n", "<leader>dt", function()
	require("dapui").toggle()
end, { desc = "Debug UI Toggle" })
map("n", "<leader>de", function()
	require("dapui").eval()
end, { desc = "Debug Eval Expression" })
map("v", "<leader>de", function()
	require("dapui").eval()
end, { desc = "Debug Eval Selection" })
map("n", "<leader>dE", function()
	require("dapui").eval(vim.fn.input("Expression: "))
end, { desc = "Debug Eval Input" })
map("n", "<leader>dw", function()
	require("dapui").float_element("watches", { enter = true })
end, { desc = "Debug Show Watches" })
map("n", "<leader>ds", function()
	require("dapui").float_element("scopes", { enter = true })
end, { desc = "Debug Show Scopes" })
map("n", "<leader>df", function()
	require("dapui").float_element("stacks", { enter = true })
end, { desc = "Debug Show Stack Frames" })
map("n", "<leader>dh", function()
	require("dapui").float_element("breakpoints", { enter = true })
end, { desc = "Debug Show Breakpoints" })
map("n", "<leader>dR", function()
	require("dap").repl.toggle()
end, { desc = "Debug Toggle REPL" })

-- Debug - Sessions & Last Run
map("n", "<leader>dS", function()
	require("dap").session()
end, { desc = "Debug Show Session" })
map("n", "<leader>d.", function()
	require("dap").run_last()
end, { desc = "Debug Run Last" })

-- Debug - Hover
map("n", "<leader>dv", function()
	require("dap.ui.widgets").hover()
end, { desc = "Debug Hover Variables" })
map("v", "<leader>dv", function()
	require("dap.ui.widgets").hover()
end, { desc = "Debug Hover Variables" })

-- Debug - Scopes Sidebar
map("n", "<leader>da", function()
	local widgets = require("dap.ui.widgets")
	widgets.sidebar(widgets.scopes).open()
end, { desc = "Debug Open Scopes Sidebar" })

-- Debug - Frames Sidebar
map("n", "<leader>dF", function()
	local widgets = require("dap.ui.widgets")
	widgets.sidebar(widgets.frames).open()
end, { desc = "Debug Open Frames Sidebar" })

-- Git
map("n", "<leader>gl", ":Flog<CR>", { desc = "Git Log" })
map("n", "<leader>gf", ":DiffviewFileHistory<CR>", { desc = "Git File History" })
map("n", "<leader>gc", ":DiffviewOpen HEAD~1<CR>", { desc = "Git Last Commit" })
map("n", "<leader>gt", ":DiffviewToggleFile<CR>", { desc = "Git File History" })
map("n", "<leader>gp", ":Gitsigns preview_hunk<CR>", { desc = "Git Preview Hunk" })
map("n", "<leader>gt", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Git Toggle Current Line Blame" })

-- Terminal
map("n", "<C-/>", function()
	require("nvchad.term").toggle({ pos = "sp", size = 0.3 })
end, { desc = "Toggle Terminal Horizontal" })
map("t", "<C-/>", function()
	require("nvchad.term").toggle({ pos = "sp" })
end, { desc = "Toggle Terminal Horizontal" })

-- Spring Boot Plugin Keybindings
map("n", "<leader>sr", function()
	require("springboot-nvim").boot_run()
end, { desc = "Spring Boot Run" })
map("n", "<leader>sc", function()
	require("springboot-nvim").generate_class()
end, { desc = "Spring Create Class" })
map("n", "<leader>si", function()
	require("springboot-nvim").generate_interface()
end, { desc = "Spring Create Interface" })
map("n", "<leader>se", function()
	require("springboot-nvim").generate_enum()
end, { desc = "Spring Create Enum" })

-- URL
map("n", "gx", "<cmd>URLOpenUnderCursor<cr>")

-- Open a note in the Obsidian app
map("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian App" })
-- Search for or create notes
map("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Obsidian Quick Switch" })
-- Follow a link under your cursor
map("n", "<leader>of", "<cmd>ObsidianFollowLink<cr>", { desc = "Obsidian Follow Link" })
-- Go back to your last note
map("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Obsidian Back Links" })
-- Search for notes in a sub-folder
map("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Obsidian Search" })
-- Open today's daily note
map("n", "<leader>ot", "<cmd>ObsidianToday<cr>", { desc = "Obsidian Today" })
-- Open tomorrow's daily note
map("n", "<leader>om", "<cmd>ObsidianTomorrow<cr>", { desc = "Obsidian Tomorrow" })
-- Open yesterday's daily note
map("n", "<leader>oy", "<cmd>ObsidianYesterday<cr>", { desc = "Obsidian Yesterday" })
-- Create a new note from a template
map("n", "<leader>oT", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian Template" })
-- Paste an image from the clipboard
map("n", "<leader>op", "<cmd>ObsidianPasteImg<cr>", { desc = "Obsidian Paste Image" })
-- Rename the note of the current buffer or reference under the cursor
map("n", "<leader>or", "<cmd>ObsidianRename<cr>", { desc = "Obsidian Rename" })
-- Create a new note and link it under the cursor
map("n", "<leader>ol", "<cmd>ObsidianLink<cr>", { desc = "Obsidian Link" })
-- Create a new note in a specific location and link it under the cursor
map("n", "<leader>oL", "<cmd>ObsidianLinkNew<cr>", { desc = "Obsidian Link New" })
-- Extract the current selection into a new note and link to it
map("v", "<leader>oe", "<cmd>ObsidianExtractNote<cr>", { desc = "Obsidian Extract Note" })
-- Navigate to/from daily notes
map("n", "<leader>otd", "<cmd>ObsidianDailies<cr>", { desc = "Obsidian Daily Notes" })
-- Show all tags
map("n", "<leader>ogt", "<cmd>ObsidianTags<cr>", { desc = "Obsidian Tags" })
-- Workspace switcher (if you have multiple workspaces)
map("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Obsidian Switch Workspace" })

-- NOTIFY
map("n", "<leader>cn", function()
	require("notify").clear_history()
end)

-- Paste image
map("n", "<leader>pi", function()
	require("img-clip").paste_image()
end, { desc = "Paste image from the clipboard" })

-- Typst preview
map("n", "<leader>tu", "<CMD>TypstPreviewUpdate<CR>", { desc = "Typst Preview Update Binaries" })
map("n", "<leader>tp", "<CMD>TypstPreview document<CR>", { desc = "Start Typst Preview (Document Mode)" })
map("n", "<leader>ts", "<CMD>TypstPreview slide<CR>", { desc = "Start Typst Preview (Slide Mode)" })
map("n", "<leader>tq", "<CMD>TypstPreviewStop<CR>", { desc = "Stop Typst Preview" })
map("n", "<leader>tt", "<CMD>TypstPreviewToggle<CR>", { desc = "Toggle Typst Preview" })
-- map(
-- 	"n",
-- 	"<leader>tf",
-- 	"<CMD>lua require('typst-preview').set_follow_cursor(true)<CR>",
-- 	{ desc = "Typst Preview Follow Cursor" }
-- )
-- map(
-- 	"n",
-- 	"<leader>tnf",
-- 	"<CMD>lua require('typst-preview').set_follow_cursor(false)<CR>",
-- 	{ desc = "Typst Preview No Follow Cursor" }
-- )
-- map(
-- 	"n",
-- 	"<leader>tft",
-- 	"<CMD>lua require('typst-preview').set_follow_cursor(not require('typst-preview').get_follow_cursor())<CR>",
-- 	{ desc = "Typst Preview Toggle Follow Cursor" }
-- )
-- map(
-- 	"n",
-- 	"<leader>tsc",
-- 	"<CMD>lua require('typst-preview').sync_with_cursor()<CR>",
-- 	{ desc = "Typst Preview Sync Cursor" }
-- )

-- Codeium
map("i", "<C-f>", function()
	return vim.fn["codeium#Accept"]()
end, { expr = true })

-- Basic
map("i", "jj", "<ESC>")

map("n", "<leader>tc", "<CMD>tabc<CR>", { desc = "Close Tab" })

map("n", "<leader>tn", "<CMD>tabnew<CR>", { desc = "New Tab" })

-- Telescope with horizontal split
map("n", "<leader>snh", function()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map_telescope)
			map_telescope("i", "<CR>", function(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local actions = require("telescope.actions")
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("split")
				if selection then
					vim.cmd("edit " .. selection.path)
				end
			end)
			map_telescope("n", "<CR>", function(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local actions = require("telescope.actions")
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("split")
				if selection then
					vim.cmd("edit " .. selection.path)
				end
			end)
			-- Handle Escape in insert mode
			map_telescope("i", "<Esc>", function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.close(prompt_bufnr)
				vim.cmd("split")
			end)
			-- Handle Ctrl+C in insert mode
			map_telescope("i", "<C-c>", function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.close(prompt_bufnr)
				vim.cmd("split")
			end)
			-- Handle q in normal mode
			map_telescope("n", "<Esc>", function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.close(prompt_bufnr)
				vim.cmd("split")
			end)
			return true
		end,
	})
end, { desc = "Split Horizontal with file picker" })

-- Telescope with vertical split
map("n", "<leader>snv", function()
	require("telescope.builtin").find_files({
		attach_mappings = function(_, map_telescope)
			map_telescope("i", "<CR>", function(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local actions = require("telescope.actions")
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("vsplit")
				if selection then
					vim.cmd("edit " .. selection.path)
				end
			end)
			map_telescope("n", "<CR>", function(prompt_bufnr)
				local action_state = require("telescope.actions.state")
				local actions = require("telescope.actions")
				local selection = action_state.get_selected_entry()
				actions.close(prompt_bufnr)
				vim.cmd("vsplit")
				if selection then
					vim.cmd("edit " .. selection.path)
				end
			end)
			-- Handle Escape in insert mode
			map_telescope("i", "<Esc>", function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.close(prompt_bufnr)
				vim.cmd("vsplit")
			end)
			-- Handle Ctrl+C in insert mode
			map_telescope("i", "<C-c>", function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.close(prompt_bufnr)
				vim.cmd("vsplit")
			end)
			-- Handle Escape in normal mode
			map_telescope("n", "<Esc>", function(prompt_bufnr)
				local actions = require("telescope.actions")
				actions.close(prompt_bufnr)
				vim.cmd("vsplit")
			end)
			return true
		end,
	})
end, { desc = "Split Vertical with file picker" })

map("n", "<leader>sc", "<CMD>close<CR>", { desc = "Close split" })

map("n", "<leader>e", "<CMD>NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })

map("n", "<leader>ct", "<CMD>CodeiumToggle<CR>", { desc = "Toggle Codeium" })
map("n", "<leader>cc", "<CMD>CodeiumChat<CR>", { desc = "Codeium Chat" })

map("n", "<leader><leader>", "<CMD>w<CR>")

map("n", "<leader>q", "<CMD>qa<CR>")

map("n", "<leader>1", "<CMD>qa!<CR>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<A-.>", "<C-w>>")
map("n", "<A-,>", "<C-w><")

-- Ints mappings
map("x", "<leader>p", [["_dP]])
