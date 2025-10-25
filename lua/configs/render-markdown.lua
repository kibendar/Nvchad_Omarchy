local present, render_markdown = pcall(require, "render-markdown")

if not present then
	return
end

-- Define custom highlight groups for checkbox states
vim.api.nvim_set_hl(0, "RenderMarkdownTodo", { fg = "#FFA500", bold = true }) -- Orange
vim.api.nvim_set_hl(0, "RenderMarkdownRightArrow", { fg = "#00BFFF", bold = true }) -- Deep Sky Blue
vim.api.nvim_set_hl(0, "RenderMarkdownTilde", { fg = "#FFD700", bold = true }) -- Gold
vim.api.nvim_set_hl(0, "RenderMarkdownImportant", { fg = "#FF6B6B", bold = true }) -- Red

render_markdown.setup({
	-- Whether Markdown should be rendered by default or not
	enabled = true,
	-- Maximum file size (in MB) that this plugin will attempt to render
	max_file_size = 10.0,
	-- Capture groups that get pulled from markdown
	markdown_query = [[
        (atx_heading [
          (atx_h1_marker)
          (atx_h2_marker)
          (atx_h3_marker)
          (atx_h4_marker)
          (atx_h5_marker)
          (atx_h6_marker)
        ] @heading)

        (thematic_break) @dash

        (fenced_code_block) @code

        [
          (list_marker_plus)
          (list_marker_minus)
          (list_marker_star)
        ] @list_marker

        (task_list_marker_unchecked) @checkbox_unchecked
        (task_list_marker_checked) @checkbox_checked

        (block_quote (block_quote_marker) @quote_marker)
        (block_quote (paragraph (inline (block_continuation) @quote_marker)))

        (pipe_table) @table
        (pipe_table_header) @table_head
        (pipe_table_delimiter_row) @table_delim
        (pipe_table_row) @table_row
      ]],
	-- Heading configurations
	heading = {
		-- Turn on / off heading icon & background rendering
		enabled = true,
		-- Replaces '#+' of atx_h[1-6] headings
		icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
		-- Added to the sign column if enabled
		signs = { "󰫎 " },
		-- Width of the heading background:
		--  block: width of the heading text
		--  full: full width of the window
		width = "full",
		-- The minimum width to use for headings, can be:
		--  integer: a static value
		--  function: dynamically computes based on the buffer
		min_width = 0,
		-- Determines if a border is added above and below headings
		border = false,
		-- Highlight the start of the border using the foreground highlight
		border_virtual = false,
		-- Used above heading for border
		above = "▄",
		-- Used below heading for border
		below = "▀",
		-- The 'level' is used to index into the array using a cycle
		backgrounds = {
			"RenderMarkdownH1Bg",
			"RenderMarkdownH2Bg",
			"RenderMarkdownH3Bg",
			"RenderMarkdownH4Bg",
			"RenderMarkdownH5Bg",
			"RenderMarkdownH6Bg",
		},
		-- The 'level' is used to index into the array using a cycle
		foregrounds = {
			"RenderMarkdownH1",
			"RenderMarkdownH2",
			"RenderMarkdownH3",
			"RenderMarkdownH4",
			"RenderMarkdownH5",
			"RenderMarkdownH6",
		},
	},
	-- Code block configurations
	code = {
		-- Turn on / off code block & inline code rendering
		enabled = true,
		-- Determines how code blocks & inline code are rendered:
		--  none: disables all rendering
		--  normal: adds highlight group to code blocks & inline code
		--  language: adds language icon to sign column if enabled and icon + name above code blocks
		--  full: normal + language
		style = "full",
		-- Determines where language icon is rendered:
		--  right: right side of code block
		--  left: left side of code block
		position = "left",
		-- Amount of padding to add around the language
		language_pad = 0,
		-- A list of language names for which background highlighting will be disabled
		-- Likely because that language is not supported by the colorscheme
		disable_background = {},
		-- Width of the code block background:
		--  block: width of the code block
		--  full: full width of the window
		width = "full",
		-- The minimum width to use for code blocks, can be:
		--  integer: a static value
		--  function: dynamically computes based on the buffer
		min_width = 0,
		-- Determines if a border is added above and below code blocks
		border = false,
		-- Used above code blocks for border
		above = "▄",
		-- Used below code blocks for border
		below = "▀",
		-- Highlight for code blocks
		highlight = "RenderMarkdownCode",
		-- Highlight for inline code
		highlight_inline = "RenderMarkdownCodeInline",
	},
	-- Checkbox configurations
	checkbox = {
		-- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'.
		-- There are two special states for unchecked & checked defined in the markdown grammar.
		-- Turn on / off checkbox state rendering.
		enabled = true,
		-- Additional modes to render checkboxes.
		render_modes = false,
		-- Render the bullet point before the checkbox.
		bullet = false,
		-- Padding to add to the right of checkboxes.
		right_pad = 5,
		unchecked = {
			-- Replaces '[ ]' of 'task_list_marker_unchecked'.
			icon = "󰄱 ",
			-- Highlight for the unchecked icon.
			highlight = "RenderMarkdownUnchecked",
			-- Highlight for item associated with unchecked checkbox.
			scope_highlight = nil,
		},
		checked = {
			-- Replaces '[x]' of 'task_list_marker_checked'.
			icon = "󰱒 ",
			-- Highlight for the checked icon.
			highlight = "RenderMarkdownChecked",
			-- Highlight for item associated with checked checkbox.
			scope_highlight = nil,
		},
	-- Define custom checkbox states, more involved, not part of the markdown grammar.
	-- As a result this requires neovim >= 0.10.0 since it relies on 'inline' extmarks.
	-- The key is for healthcheck and to allow users to change its values, value type below.
	-- | raw             | matched against the raw text of a 'shortcut_link'           |
	-- | rendered        | replaces the 'raw' value when rendering                     |
	-- | highlight       | highlight for the 'rendered' icon                           |
	-- | scope_highlight | optional highlight for item associated with custom checkbox |
	-- stylua: ignore
   custom = {
      todo = { raw = '[-]', rendered = '󰥔', highlight = 'RenderMarkdownTodo', scope_highlight = nil },
      right_arrow = { raw = '[>]', rendered = '', highlight = 'RenderMarkdownRightArrow', scope_highlight = nil },
      tilde = { raw = '[~]', rendered = '', highlight = 'RenderMarkdownTilde', scope_highlight = nil },
      important = { raw = '[!]', rendered = '', highlight = 'RenderMarkdownImportant', scope_highlight = nil },
    },
	},
})
