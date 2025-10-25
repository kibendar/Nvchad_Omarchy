return {
  {
    "norcalli/nvim-colorizer.lua",
    event = "VeryLazy",
    config = function()
      require("colorizer").setup({
        -- Filetypes to enable colorizer for
        "css",
        "javascript",
        "typescript",
        "html",
        "lua",
        "vim",

        -- You can also specify specific filetypes:
        -- css = { rgb_fn = true, hsl_fn = true },
        -- html = { names = false },
        -- javascript = { RGB = true, RRGGBB = true },
      }, {
        -- Default options for all filetypes
        RGB = true, -- #RGB hex codes
        RRGGBB = true, -- #RRGGBB hex codes
        names = true, -- "Name" codes like Blue or red
        RRGGBBAA = true, -- #RRGGBBAA hex codes
        AARRGGBB = true, -- 0xAARRGGBB hex codes
        rgb_fn = true, -- CSS rgb() and rgba() functions
        hsl_fn = true, -- CSS hsl() and hsla() functions
        css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
        css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
        -- Available modes: foreground, background, virtualtext
        mode = "background", -- Set the display mode
        -- Available methods: lsp, treesitter, both
        tailwind = false, -- Enable tailwind colors
        sass = { enable = true, parsers = { "css" } }, -- Enable sass colors
        virtualtext = "■",
        always_update = false,
      })
    end,
  },
}
