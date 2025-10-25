local present, nvim_tree = pcall(require, "nvim-tree")
if not present then
	return
end

-- Custom function to handle directory navigation
local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- Default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- Custom mappings for l/h navigation
	vim.keymap.set("n", "l", function()
		local node = api.tree.get_node_under_cursor()
		if node then
			if node.type == "directory" then
				if node.open then
					-- If directory is already open, navigate into it
					api.node.open.edit()
				else
					-- If directory is closed, expand it
					api.node.open.edit()
				end
			else
				-- If it's a file, open it
				api.node.open.edit()
			end
		end
	end, opts("Expand Directory or Open File"))

	vim.keymap.set("n", "h", function()
		local node = api.tree.get_node_under_cursor()
		if node then
			if node.type == "directory" and node.open then
				-- If directory is open, close it
				api.node.open.edit()
			else
				-- Navigate to parent directory
				api.node.navigate.parent_close()
			end
		end
	end, opts("Collapse Directory or Go to Parent"))

	-- Additional useful mappings
	vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
	vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
	vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
	vim.keymap.set("n", "t", api.node.open.tab, opts("Open: New Tab"))
	vim.keymap.set("n", "<Tab>", api.node.open.preview, opts("Open Preview"))
	vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
	vim.keymap.set("n", "a", api.fs.create, opts("Create"))
	vim.keymap.set("n", "d", api.fs.remove, opts("Delete"))
	vim.keymap.set("n", "r", api.fs.rename, opts("Rename"))
	vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
	vim.keymap.set("n", "x", api.fs.cut, opts("Cut"))
	vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
	vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
	vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
	vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
	vim.keymap.set("n", "I", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
	vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
	vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
	vim.keymap.set("n", "q", api.tree.close, opts("Close"))
end

nvim_tree.setup({
	on_attach = my_on_attach,
	renderer = {
		icons = {
			git_placement = "before", -- or "after"
			show = {
				git = true,
			},
			glyphs = {
				git = {
					unstaged = "◈",
					staged = "◆",
					unmerged = "⊘",
					renamed = "⇄",
					untracked = "⊕",
					deleted = "⊖",
					ignored = "⌀",
				},
			},
		},
	},
	git = {
		enable = true,
		ignore = false,
	},
	view = {
		width = 30,
		side = "left",
	},
	filters = {
		dotfiles = false,
		custom = {},
		exclude = {},
	},
	actions = {
		open_file = {
			quit_on_open = false,
			resize_window = true,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
})
