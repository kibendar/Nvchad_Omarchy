-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

local dapui = require("dapui")
dapui.setup() -- Make sure DAP UI is properly set up

local M = {}
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

--UrlOpen
map("n", "<leader>gx", "<cmd>URLOpenUnderCursor<cr>")

map("n", "<leader>sen", function()
  vim.opt.spelllang = "en"
end, { desc = "English spell check" })

map("n", "<leader>suk", function()
  vim.opt.spelllang = "uk"
end, { desc = "Ukrainian spell check" })

map("n", "<leader>sru", function()
  vim.opt.spelllang = "ru"
end, { desc = "Russian spell check" })

map("n", "<leader>sall", function()
  vim.opt.spelllang = { "en", "uk", "ru" }
end, { desc = "All languages spell check" })

--Basic
map("i", "jj", "<ESC>")

map("n", "<leader><leader>", "<CMD>w<CR>")
map("n", "<leader>q", "<CMD>qa<CR>")
map("n", "<leader>q1", "<CMD>qa!<CR>")

map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("n", "<A-.>", "<C-w>>")
map("n", "<A-,>", "<C-w><")

-- Ints mappings
map("x", "<leader>p", [["_dP]])

-- Obsidian keymaps
-- Note: These will only work when obsidian.nvim is loaded (in markdown files)
map("n", "gf", function()
  if require("obsidian").util.cursor_on_markdown_link() then
    return require("obsidian").util.gf_passthrough()
  else
    return "gf"
  end
end, { desc = "Obsidian follow link", expr = true })

-- Toggle check-boxes
map("n", "<leader>ch", "<cmd>ObsidianToggleCheckbox<cr>", { desc = "Obsidian Check Checkbox" })
-- Smart action depending on context, either follow link or toggle checkbox
map("n", "<cr>", function()
  return require("obsidian").util.smart_action()
end, { desc = "Obsidian Smart Action", buffer = true })
-- Create a new note after prompting for its title
map("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Obsidian New Note" })
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
map("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Obsidian Template" })
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
map("n", "<leader>oTd", "<cmd>ObsidianDailies<cr>", { desc = "Obsidian Daily Notes" })
-- Show all tags
map("n", "<leader>ogt", "<cmd>ObsidianTags<cr>", { desc = "Obsidian Tags" })
-- Workspace switcher (if you have multiple workspaces)
map("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Obsidian Switch Workspace" })

-- Debugger
map("n", "<leader>dc", function()
  require("dap").continue()
end, { desc = "Debug Continue" })
map("n", "<leader>do", function()
  require("dap").step_over()
end, { desc = "Debug Step Over" })
map("n", "<leader>di", function()
  require("dap").step_into()
end, { desc = "Debug Step Into" })
map("n", "<leader>du", function()
  require("dap").step_out()
end, { desc = "Debug Step Out" })
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "Debug Toggle Breakpoint" })
map("n", "<leader>dB", function()
  require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
end, { desc = "Debug Conditional Breakpoint" })
map("n", "<leader>dt", function()
  require("dapui").toggle()
end, { desc = "Debug UI Toggle" })

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

-- Paste image
map("n", "<leader>pi", function()
  require("img-clip").paste_image()
end, { desc = "Paste image from the clipboard" })

-- The power of digits 1-9
map("i", "<C-1>", "¹", { desc = "Insert superscript 1" })
map("i", "<C-2>", "²", { desc = "Insert superscript 2" })
map("i", "<C-3>", "³", { desc = "Insert superscript 3" })
map("i", "<C-4>", "⁴", { desc = "Insert superscript 4" })
map("i", "<C-5>", "⁵", { desc = "Insert superscript 5" })
map("i", "<C-6>", "⁶", { desc = "Insert superscript 6" })
map("i", "<C-7>", "⁷", { desc = "Insert superscript 7" })
map("i", "<C-8>", "⁸", { desc = "Insert superscript 8" })

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

-- Typst preview
map("n", "<leader>tu", "<CMD>TypstPreviewUpdate<CR>", { desc = "Typst Preview Update Binaries" })
map("n", "<leader>tp", "<CMD>TypstPreview document<CR>", { desc = "Start Typst Preview (Document Mode)" })
map("n", "<leader>ts", "<CMD>TypstPreview slide<CR>", { desc = "Start Typst Preview (Slide Mode)" })
map("n", "<leader>tq", "<CMD>TypstPreviewStop<CR>", { desc = "Stop Typst Preview" })
map("n", "<leader>tt", "<CMD>TypstPreviewToggle<CR>", { desc = "Toggle Typst Preview" })
map(
  "n",
  "<leader>tf",
  "<CMD>lua require('typst-preview').set_follow_cursor(true)<CR>",
  { desc = "Typst Preview Follow Cursor" }
)
map(
  "n",
  "<leader>tnf",
  "<CMD>lua require('typst-preview').set_follow_cursor(false)<CR>",
  { desc = "Typst Preview No Follow Cursor" }
)
map(
  "n",
  "<leader>tft",
  "<CMD>lua require('typst-preview').set_follow_cursor(not require('typst-preview').get_follow_cursor())<CR>",
  { desc = "Typst Preview Toggle Follow Cursor" }
)
map(
  "n",
  "<leader>tsc",
  "<CMD>lua require('typst-preview').sync_with_cursor()<CR>",
  { desc = "Typst Preview Sync Cursor" }
)

-- Tmux navigation

map("n", "<M-h", "<CMD> TmuxNavigateLeft<CR>")
map("n", "<M-j", "<CMD> TmuxNavigateDown<CR>")
map("n", "<M-k", "<CMD> TmuxNavigateUp<CR>")
map("n", "<M-l", "<CMD> TmuxNavigateRight<CR>")
