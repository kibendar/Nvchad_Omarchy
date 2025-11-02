local present, ufo = pcall(require, "ufo")

if not present then
	return
end

ufo.setup({
	vim.o.foldcolumn == "1",
	vim.o.foldlevel == 99,
	vim.o.foldlevelstart == 99,
	vim.o.foldenable == true,
})
