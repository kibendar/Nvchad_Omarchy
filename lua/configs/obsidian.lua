local present, obsidian = pcall(require, "obsidian")

if not present then
	return
end

obsidian.setup({
	workspaces = {
		{
			name = "daily",
			path = "~/Obsidian/DailyNotes",
		},
		{
			name = "home",
			path = "~/Obsidian/Hometask/",
		},
		{
			name = "kafka",
			path = "~/Obsidian/Kafka/",
		},
		{
			name = "js",
			path = "~/Obsidian/JSKnowledge/",
		},
		{
			name = "ts",
			path = "~/Obsidian/TSKnowledge/",
		},
		{
			name = "barodia",
			path = "~/Obsidian/barodia/",
		},
		{
			name = "docker",
			path = "~/Obsidian/Docker/",
		},
		{
			name = "algo",
			path = "~/Obsidian/Алгоритмы и структуры данных/",
		},
		{
			name = "test",
			path = "~/Obsidian/Теория тестирования/",
		},
	},

	daily_notes = {
		date_format = "%Y-%m-%d",
		-- Optional, if you want to change the date format of the default alias of daily notes.
		alias_format = "%B %-d, %Y",
		-- Optional, default tags to add to each new daily note created.
		default_tags = { "daily-notes" },
	},

	attachments = {
		-- The default folder to place images in via `:ObsidianPasteImg`.
		-- If this is a relative path it will be interpreted as relative to the vault root.
		-- You can always override this per attachment by passing a full path to the command instead of just a filename.
		img_folder = "Screenshots", -- This is the default
		-- A function that determines the text to insert in the note when pasting an image.
		-- It takes two arguments, the `obsidian.Client` and an `obsidian.Path` to the image file.
		-- This is the default implementation.
		---@param client obsidian.Client
		---@param path obsidian.Path the absolute path to the image file
		---@return string
		img_text_func = function(client, path)
			path = client:vault_relative_path(path) or path
			return string.format("![%s](%s)", path.name, path)
		end,
	},

	ui = {
		enable = false,
	},
})
