return {
  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    lazy = true,
    ft = "markdown",
    -- Alternative: load only for files in your vault
    -- event = {
    --   "BufReadPre " .. vim.fn.expand "~" .. "/Notes/*.md",
    --   "BufNewFile " .. vim.fn.expand "~" .. "/Notes/*.md",
    -- },
    dependencies = {
      -- Required.
      "nvim-lua/plenary.nvim",
    },
    config = function(_, opts)
      -- Set conceallevel for obsidian compatibility
      vim.opt_local.conceallevel = 2

      require("obsidian").setup(opts)
    end,
    opts = {
      workspaces = {
        {
          name = "studing",
          path = "~/Notes/Ajax Studying/",
        },
        {
          name = "home",
          path = "~/Notes/Homework/",
        },
        {
          name = "theory",
          path = "~/Notes/Theory_of_testing/",
        },
        {
          name = "daily",
          path = "~/Notes/DailyTasks/",
        },
        {
          name = "templates",
          path = "~/Notes/Templates/",
        },
        {
          name = "summary",
          path = "~/Notes/Summary/",
        },
      },

      templates = {
        folder = "~/Notes/Templates/",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M",
      },

      daily_notes = {
        date_format = "%Y-%m-%d",
        -- Optional, if you want to change the date format of the default alias of daily notes.
        alias_format = "%B %-d, %Y",
        -- Optional, default tags to add to each new daily note created.
        default_tags = { "daily-notes" },
      },

      attachments = {
        -- The default folder to place images in via `:NotesPasteImg`.
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
    },
  },
}
