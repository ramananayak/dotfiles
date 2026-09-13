local keymap = vim.keymap.set

-- Disable Space bar since it will be used as the leader key
keymap("n", "<leader>", "<Nop>")

-- Redo remap
keymap("n", "U", "<C-r>")

-- Toggle soft-wrap for reading (visual only, doesn't modify file)
keymap("n", "<leader>tw", function()
    local on = not vim.opt_local.wrap:get()
    vim.opt_local.wrap = on
    vim.opt_local.linebreak = on   -- break at word boundaries
    vim.opt_local.breakindent = on -- preserve indent on wrapped lines
    vim.notify("Wrap " .. (on and "ON" or "OFF"))
end, { desc = "Toggle soft-wrap" })

-- Navigate visual lines when wrap is on
keymap({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- after a search, press escape to clear highlights
keymap("n", "<Esc>", "<cmd>nohlsearch<CR>")

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
keymap("n", "<leader>q", ":q<cr>", { silent = false, noremap = true })

-- create a new buffer
keymap("n", "<leader>fn", ":enew<CR>", { desc = "New File" })

-- Navigate through buffers
keymap("n", "[b", ":bprevious<CR>", { silent = false })
keymap("n", "]b", ":bnext<CR>", { silent = false })

-- Close currently active buffer
keymap("n", "<leader>bd", ":bwipeout<CR>", { silent = false, desc = "Buffer: wipeout" })

-- Center buffer when navigating up and down (half-page scroll)
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")

-- Center buffer when progressing through search results
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Yank to system clipboard
keymap("n", "<leader>y", '"+y')
keymap("v", "<leader>y", '"+y')
keymap("n", "<leader>Y", '"+Y')

-- Put/Paste from system clipboard
keymap("n", "<leader>P", '"+p', { desc = "Paste from system clipboard" })

-- Move selection up and down
keymap("v", "<C-j>", ":m '>+1<CR>gv=gv")
keymap("v", "<C-k>", ":m '<-2<CR>gv=gv")

-- update plugins easily
keymap("n", "<leader>ps", '<cmd>lua vim.pack.update()<CR>')

-- fzf
keymap("n", "<leader>ff", '<cmd>FzfLua files<CR>')
keymap("n", "<leader>fb", '<cmd>FzfLua buffers<CR>')
keymap("n", "<leader>fg", '<cmd>FzfLua live_grep<CR>')
keymap("n", "<leader>fw", '<cmd>FzfLua grep_cword<CR>', { desc = "Grep: word under cursor" })
keymap("v", "<leader>fw", '<cmd>FzfLua grep_visual<CR>', { desc = "Grep: visual selection" })

-- scratchpad
local scratch_dir = vim.fn.expand("~/.cache/scratch")
keymap("n", "<leader>sn", function()
    if vim.fn.isdirectory(scratch_dir) == 0 then
        vim.fn.mkdir(scratch_dir, "p")
    end
    local filepath = scratch_dir .. "/" .. os.date("%Y-%m-%d_%H%M%S") .. ".md"
    vim.cmd("edit " .. filepath)
end, { desc = "Scratch: new file" })

keymap("n", "<leader>fs", function()
    if vim.fn.isdirectory(scratch_dir) == 0 then
        vim.fn.mkdir(scratch_dir, "p")
    end
    require("fzf-lua").files({
        cwd = scratch_dir,
        prompt = "Scratchpads❯ ",
    })
end, { desc = "Scratch: search files" })

-- fugitive
keymap("n", "<leader>gs", '<cmd>Git<CR>', { silent = true, noremap = true })
keymap("n", "<leader>gp", '<cmd>Git push<CR>', { silent = false, noremap = true })

-- worktree picker (fzf-lua, :tcd into selection)
keymap("n", "<leader>gw", function()
    require("fzf-lua").fzf_exec("git worktree list", {
        prompt = "Worktree❯ ",
        actions = {
            ["default"] = function(selected)
                local path = selected[1]:match("^(%S+)")
                if path then vim.cmd("tcd " .. vim.fn.fnameescape(path)) end
            end,
        },
    })
end, { desc = "Git: switch worktree" })

-- oil
keymap("n", "-", "<CMD>Oil --float <CR>", { desc = "Open parent directory" })

-- Helper to open existing terminal buffer or create a new one
local function open_terminal(split_cmd, force_new)
    local term_buf = nil
    if not force_new then
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            if vim.api.nvim_buf_is_valid(buf) then
                local name = vim.api.nvim_buf_get_name(buf)
                local buftype = ""
                pcall(function() buftype = vim.bo[buf].buftype end)
                local filetype = ""
                pcall(function() filetype = vim.bo[buf].filetype end)

                -- Ensure we match terminal buffers, but exclude fzf-lua terminal buffers
                if (buftype == "terminal" or string.match(name, "^term://"))
                    and filetype ~= "fzf"
                    and not string.match(name, "fzf") then
                    term_buf = buf
                    break
                end
            end
        end
    end

    vim.cmd(split_cmd)
    if term_buf then
        vim.cmd("buffer " .. term_buf)
    else
        vim.cmd("terminal")
    end
end

-- Terminal splits
-- Option 1: Reopen the same terminal if it exists, otherwise create a new one
keymap("n", "<leader>tv", function() open_terminal("vsplit", false) end, { desc = "Terminal: vertical split (re-use)" })
keymap("n", "<leader>th", function() open_terminal("split", false) end, { desc = "Terminal: horizontal split (re-use)" })

-- Option 2: Always spawn a new terminal buffer
keymap("n", "<leader>tV", function() open_terminal("vsplit", true) end, { desc = "Terminal: vertical split (always new)" })
keymap("n", "<leader>tH", function() open_terminal("split", true) end, { desc = "Terminal: horizontal split (always new)" })

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
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Diagnostic: show" })
keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Diagnostic: prev" })
keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Diagnostic: next" })

-- codecompanion (sage AI)
keymap({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat<CR>", { desc = "CodeCompanion: open chat" })
keymap({ "n", "v" }, "<leader>ai", "<cmd>CodeCompanionChat Add<CR>", { desc = "CodeCompanion: add selection to chat" })
keymap("n", "<leader>at", "<cmd>CodeCompanionChat Toggle<CR>", { desc = "CodeCompanion: toggle chat" })
keymap({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion: inline action" })
keymap("n", "<leader>am", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion: action palette" })

-- markdown (render-markdown.nvim + helpers)
keymap("n", "<leader>mt", "<cmd>RenderMarkdown toggle<CR>", { desc = "Markdown: toggle render" })
keymap("n", "<leader>me", "<cmd>RenderMarkdown expand<CR>", { desc = "Markdown: expand anti-conceal" })
keymap("n", "<leader>mc", "<cmd>RenderMarkdown contract<CR>", { desc = "Markdown: contract anti-conceal" })
keymap("n", "<leader>mp", "<cmd>!open -a Firefox '%:p'<CR>", { desc = "Markdown: preview in browser", silent = true })

-- toggle checkbox on current line
keymap("n", "<leader>mx", function()
    local line = vim.api.nvim_get_current_line()
    if line:match("%[ %]") then
        line = line:gsub("%[ %]", "[x]", 1)
    elseif line:match("%[x%]") then
        line = line:gsub("%[x%]", "[ ]", 1)
    end
    vim.api.nvim_set_current_line(line)
end, { desc = "Markdown: toggle checkbox" })
