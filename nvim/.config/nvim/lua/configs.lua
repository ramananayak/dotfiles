-- Register markdown.mdx filetype
vim.filetype.add({
    extension = { mdx = 'markdown.mdx' },
})

-- Leader Key (Set this first!)
vim.g.mapleader = " " -- Use space as the primary leader key

-- Disable unused remote plugin providers (silences :checkhealth warnings)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- UI & Appearance
vim.opt.termguicolors = true      -- Enable 24-bit RGB colors in the terminal
vim.opt.number = true             -- Show absolute line number for the current line
vim.opt.relativenumber = true     -- Show relative numbers for fast vertical jumping
vim.opt.signcolumn = "yes"        -- Keep sign column open to prevent text shifting (LSP/Gutter)
vim.opt.cursorline = true         -- Highlight the line under the cursor
vim.opt.wrap = false              -- Don't wrap long lines (standard for code)
vim.opt.linebreak = true          -- When wrap is on, break at word boundaries
vim.opt.textwidth = 80            -- Used by gq to hard-wrap text on demand
vim.opt.formatoptions:remove("t") -- Don't auto-wrap text while typing
vim.opt.scrolloff = 8             -- Keep 8 lines visible above/below cursor when scrolling

-- Indentation (Strict PEP 8 for Python)
vim.opt.expandtab = true   -- Convert tabs to spaces (Essential for Python)
vim.opt.tabstop = 4        -- 1 tab = 4 spaces
vim.opt.shiftwidth = 4     -- Auto-indentation uses 4 spaces
vim.opt.softtabstop = 4    -- Backspace deletes 4 spaces instead of 1
vim.opt.smartindent = true -- Intelligent indentation for classes/functions

-- Search Behavior
vim.opt.ignorecase = true -- Ignore case when searching
vim.opt.smartcase = true  -- ...unless search query contains a capital letter
vim.opt.hlsearch = false  -- Turn off highlight after search is done

-- System & Performance
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard (copy/paste to other apps)
vim.opt.mouse = "a"               -- Enable mouse support (scrolling/clicking)
vim.opt.swapfile = false          -- Don't create swap files
vim.opt.undofile = true           -- Persistent undo: remembers changes after closing file
vim.opt.updatetime = 250          -- Faster response time for UI/LSP (default is 4000ms)

-- Split behaviour
vim.opt.splitright = true -- vertical splits open to the right
vim.opt.splitbelow = true -- horizontal splits open below

-- Theme
vim.cmd.colorscheme("catppuccin")

-- vim-surround custom definitions
-- 'c' / 'C': Surround with Markdown code block (prompts for language, press Enter for none)
vim.g["surround_" .. string.byte("c")] = "```\1language: \1\r```"
vim.g["surround_" .. string.byte("C")] = "```\1language: \1\r```"

