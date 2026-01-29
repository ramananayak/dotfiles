vim.g.mapleader = " " -- space leader key

vim.o.termguicolors = true -- enable 24-bit colors
vim.o.winborder = "rounded"  -- Use rounded borders for windows
vim.o.number = true --enable line numbers
vim.o.relativenumber = true -- enable relative line numbers
vim.o.wrap = false -- disable wrapping
vim.o.smartindent = true -- indenting correctly after {
vim.o.ignorecase = true  -- Ignore case in search
vim.o.swapfile = false -- Disable swap files

vim.o.tabstop = 4 -- Number of spaces for a tab
vim.o.shiftwidth = 4  -- Number of spaces for autoindent
vim.o.signcolumn = "yes" -- Always show sign column

vim.o.undofile = true  -- Enable persistent undo

vim.cmd.colorscheme("catppuccin")
