local keymap = vim.keymap.set

-- Disable Space bar since it will be used as the leader key
keymap("n", "<leader>", "<Nop>")

-- Redo remap
keymap("n", "U", "<C-r>")

-- after a search, press escape to clear highlights
keymap("n", "<Esc>", ":nohl<CR>")

keymap({ "n", "v", "x" }, "<leader>lf", vim.lsp.buf.format, { desc = "Format current buffer" })

-- Swap between split buffers
keymap("n", "<C-h>", ":wincmd h<CR>")
keymap("n", "<C-j>", ":wincmd j<CR>")
keymap("n", "<C-k>", ":wincmd k<CR>")
keymap("n", "<C-l>", ":wincmd l<CR>")
keymap("n", "<leader>rr", ":wincmd r<CR>")

-- Save and quit current file quicker
keymap("n", "<leader>w", ":w<cr>", { silent = false, noremap = true })
keymap({ "n", "t" }, "<leader>q", ":q<cr>", { silent = false, noremap = true })

-- create a new buffer
keymap("n", "<leader>fn", ":enew<CR>", {desc = "New File"})

-- Navigate through buffers
keymap("n", "<S-l>", ":bnext<CR>", { silent = false })
keymap("n", "<S-h>", ":bprevious<CR>", { silent = false })

-- Close currently active buffer
keymap("n", "<C-c>", ":bwipeout<CR>", { silent = false })

-- Center buffer when navigating up and down
keymap("n", "<S-k>", "<C-u>zz")
keymap("n", "<S-j>", "<C-d>zz")

-- Center buffer when progressing through search results
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Yank to system clipboard
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')

-- Put/Paaste
keymap("n", "<leader>p", '"+p')

-- Move selection up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- update plugins easily
keymap("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')

-- fzf
keymap("n", "<leader>ff", '<cmd>FzfLua files<CR>')
keymap("n", "<leader>fb", '<cmd>FzfLua buffers<CR>')
keymap("n", "<leader>fg", '<cmd>FzfLua live_grep<CR>')

-- fugitive
keymap("n", "<leader>gs", '<cmd>Git<CR>', { silent = true, noremap = true })
keymap("n", "<leader>gp", '<cmd>Git push<CR>', { silent = false, noremap = true })

-- oil
keymap("n", "-", "<CMD>Oil --float <CR>", { desc = "Open parent directory" })

-- Exit terminal with Esc
keymap("t", "<Esc>", "<C-\\><C-N>")

