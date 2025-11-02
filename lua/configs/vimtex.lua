local handle = io.popen("wmctrl -m | grep 'Name:' | awk '{print $2}'")
handle:close()

vim.g.vimtex_quickfix_ignore_filters = {
	"Overfull \\hbox",
	"Overfull \\vbox",
	"Underfull \\hbox",
	"Underfull \\vbox",
}

vim.g.vimtex_quickfix_open_on_warning = 0
