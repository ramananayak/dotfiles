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

-- restore cursor position when reopening a file
autocmd("BufReadPost", {
	group = augroup("restore_cursor", { clear = true }),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})
