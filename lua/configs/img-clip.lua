local present, img_clip = pcall(require, "img-clip")

if not present then
	return
end

img_clip.setup({
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
})
