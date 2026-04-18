local keymap = vim.keymap.set

-- Disable Space bar since it will be used as the leader key
keymap("n", "<leader>", "<Nop>")

-- Redo remap
keymap("n", "U", "<C-r>")

-- after a search, press escape to clear highlights
keymap("n", "<Esc>", ":nohl<CR>")

keymap({ "n", "v", "x" }, "<leader>lf", function()
    local ft = vim.bo.filetype
    if vim.tbl_contains({ "markdown", "json", "yaml" }, ft) then
        local file = vim.fn.expand("%")
        vim.system({ "prettier", "--write", file }, {}, function(result)
            vim.schedule(function()
                if result.code == 0 then
                    vim.cmd("edit!")
                else
                    vim.notify("prettier failed: " .. (result.stderr or ""), vim.log.levels.ERROR)
                end
            end)
        end)
    else
        vim.lsp.buf.format()
    end
end, { desc = "Format current buffer" })

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
keymap("n", "<leader>fn", ":enew<CR>", { desc = "New File" })

-- Navigate through buffers
keymap("n", "[b", ":bprevious<CR>", { silent = false })
keymap("n", "]b", ":bnext<CR>", { silent = false })

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

-- Put/Paste
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

-- LSP keybindings
keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
keymap("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
keymap("n", "gr", vim.lsp.buf.references, { desc = "Find references" })
keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })

-- codecompanion (sage AI)
keymap({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "CodeCompanion: open chat" })
keymap({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanionChat Add<CR>", { desc = "CodeCompanion: add selection to chat" })
keymap("n", "<leader>at", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion: toggle chat" })
