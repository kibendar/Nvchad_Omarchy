return {
  {
    "HakonHarnes/img-clip.nvim",
    events = "VeryLazy",
    opts = {
      default = {
        dir_path = "images",
        file_name = "img-%Y-%m-%d-at-%H-%M-%S",
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = "![$CURSOR]($FILE_PATH)",
        },
      },
    },
  },
}
