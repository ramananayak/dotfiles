local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight yanked text
autocmd('TextYankPost', {
	pattern = '*',
	group = augroup('YankHighlight', { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 170 })
	end,
})

-- open help in vertical split
autocmd("FileType", {
	pattern = "help",
	command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
autocmd("VimResized", {
	command = "wincmd =",
})

-- no auto continue comments on new line
autocmd("FileType", {
	group = augroup("no_auto_comment", {}),
	callback = function()
		vim.opt_local.formatoptions:remove({ "c", "r", "o" })
	end,
})

-- show cursorline only in active window
autocmd({ "WinEnter", "BufEnter" }, {
	group = augroup("active_cursorline", { clear = true }),
	callback = function()
		vim.opt_local.cursorline = true
	end,
})

autocmd({ "WinLeave" }, {
	group = augroup("active_cursorline", { clear = false }),
	callback = function()
		vim.opt_local.cursorline = false
	end,
})
