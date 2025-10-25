local handle = io.popen("wmctrl -m | grep 'Name:' | awk '{print $2}'")
local win_man = handle:read("*a"):gsub("%s+", "")
handle:close()

if win_man == "i3" then
	vim.g.vimtex_view_method = "zathura"
elseif win_man == "GNOME" then
	vim.g.vimtex_view_method = "evince"
end

vim.g.vimtex_quickfix_ignore_filters = {
	"Overfull \\hbox",
	"Overfull \\vbox",
	"Underfull \\hbox",
	"Underfull \\vbox",
}

vim.g.vimtex_quickfix_open_on_warning = 0
