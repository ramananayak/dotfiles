vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim',        name = 'catppuccin' },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("^1"),
    },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/ibhagwan/fzf-lua" },
    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/olimorris/codecompanion.nvim" },
    { src = "https://github.com/MeanderingProgrammer/render-markdown.nvim" },
})

require("nvim-web-devicons").setup()
require("catppuccin").setup({ flavour = "mocha" })
require('gitsigns').setup({
    signcolumn = true,
    current_line_blame = false,
})
require('blink.cmp').setup({
    fuzzy = { implementation = 'prefer_rust_with_warning' },
    signature = { enabled = true },
    keymap = {
        preset = "default",
        ["<C-space>"] = {},
        ["<C-p>"] = {},
        ["<Tab>"] = {},
        ["<S-Tab>"] = {},
        ["<C-y>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_and_accept" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-b>"] = { "scroll_documentation_down", "fallback" },
        ["<C-f>"] = { "scroll_documentation_up", "fallback" },
        ["<C-l>"] = { "snippet_forward", "fallback" },
        ["<C-h>"] = { "snippet_backward", "fallback" },
        -- ["<C-e>"] = { "hide" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "normal",
    },

    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
        }
    },

    cmdline = {
        keymap = {
            preset = 'inherit',
            ['<CR>'] = { 'accept_and_enter', 'fallback' },
        },
    },

    sources = {
        default = { "lsp", "codecompanion" },
        providers = {
            codecompanion = {
                name = "CodeCompanion",
                module = "codecompanion.providers.completion.blink",
            },
        },
    }
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    constrain_cursor = "name",
    watch_for_changes = true,
    keymaps = {
        ["g?"] = { "actions.show_help", mode = "n" },
        ["<CR>"] = "actions.select",
        ["<C-v>"] = { "actions.select", opts = { vertical = true } },
        ["<C-s>"] = { "actions.select", opts = { horizontal = true } },
        ["<C-t>"] = { "actions.select", opts = { tab = true } },
        ["<C-p>"] = "actions.preview",
        ["<C-c>"] = { "actions.close", mode = "n" },
        ["<C-l>"] = "actions.refresh",
        ["-"] = { "actions.parent", mode = "n" },
        ["_"] = { "actions.open_cwd", mode = "n" },
        ["`"] = { "actions.cd", mode = "n" },
        ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        ["g\\"] = { "actions.toggle_trash", mode = "n" },
        ["gy"] = {
            callback = function()
                local oil = require("oil")
                local entry = oil.get_cursor_entry()
                local dir = oil.get_current_dir()
                if entry and dir then
                    vim.fn.setreg("+", dir .. entry.name)
                    vim.notify("Yanked: " .. dir .. entry.name)
                end
            end,
            desc = "Yank absolute path",
        },
        ["gY"] = {
            callback = function()
                local oil = require("oil")
                local entry = oil.get_cursor_entry()
                if entry then
                    vim.fn.setreg("+", entry.name)
                    vim.notify("Yanked: " .. entry.name)
                end
            end,
            desc = "Yank relative path",
        },
    },
    view_options = {
        show_hidden = true,
    },
})

-- Route vim.ui.select (LSP code actions, references, etc.) through fzf-lua
require("fzf-lua").register_ui_select()

local actions = require("fzf-lua.actions")
require("fzf-lua").setup({
    winopts = {
        height = 1,
        width = 1,
        backdrop = 85,
        preview = {
            horizontal = "right:70%",
        },
    },
    keymap = {
        builtin = {
            ["<C-f>"] = "preview-page-down",
            ["<C-b>"] = "preview-page-up",
            ["<C-p>"] = "toggle-preview",
        },
        fzf = {
            ["ctrl-a"] = "toggle-all",
            ["ctrl-t"] = "first",
            ["ctrl-g"] = "last",
            ["ctrl-d"] = "half-page-down",
            ["ctrl-u"] = "half-page-up",
        },
    },
    actions = {
        files = {
            ["ctrl-q"] = actions.file_sel_to_qf,
            ["ctrl-n"] = actions.toggle_ignore,
            ["ctrl-h"] = actions.toggle_hidden,
            ["enter"] = actions.file_edit_or_qf,
        },
    },
})

require("render-markdown").setup({
    file_types = { "markdown", "markdown.mdx", "codecompanion" },
    completions = { blink = { enabled = true } },
    heading = { position = "inline", icons = { "󰉫 ", "󰉬 ", "󰉭 ", "󰉮 ", "󰉯 ", "󰉰 " } },
    code = { width = "block", min_width = 60, border = "thick" },
    checkbox = {
        unchecked = { icon = "󰄱 " },
        checked   = { icon = "󰱒 " },
    },
    html = { enabled = false },
    latex = { enabled = false },
    yaml = { enabled = false },
})

require("codecompanion").setup({
    display = {
        chat = {
            window = {
                layout = "vertical",
                position = "right",
                width = 0.35,
            },
            fold_context = true,
            show_header_separator = false,
            show_token_count = true,
        },
        action_palette = {
            provider = "fzf_lua",
            opts = {
                show_preset_actions = false,
                show_preset_prompts = false,
            },
        },
    },
    interactions = {
        chat = {
            adapter = "sage",
            roles = {
                user = "Ramanath",
                llm = function(adapter)
                    return "Sage (" .. adapter.formatted_name .. ")"
                end,
            },
            opts = {
                completion_provider = "blink",
            },
            slash_commands = {
                ["file"]     = { opts = { provider = "fzf_lua" } },
                ["buffer"]   = { opts = { provider = "fzf_lua" } },
                ["terminal"] = {},
            },
        },
        inline = { adapter = "sage" },
    },
    adapters = {
        acp = {
            sage = function()
                local helpers = require("codecompanion.adapters.acp.helpers")
                return {
                    name = "sage",
                    formatted_name = "Sage",
                    type = "acp",
                    roles = {
                        llm = "assistant",
                        user = "user",
                    },
                    commands = {
                        default = { "sage", "acp" },
                        yolo    = { "sage", "acp", "--disable-sandbox" },
                    },
                    defaults = {
                        mcpServers = {},
                        timeout = 30000,
                    },
                    parameters = {
                        protocolVersion = 1,
                        clientCapabilities = {
                            fs = { readTextFile = true, writeTextFile = true },
                        },
                        clientInfo = {
                            name = "CodeCompanion.nvim",
                            version = "1.0.0",
                        },
                    },
                    handlers = {
                        setup = function(self) return true end,
                        form_messages = function(self, messages, capabilities)
                            return helpers.form_messages(self, messages, capabilities)
                        end,
                        on_exit = function(self, code) end,
                    },
                }
            end,
        },
    },
})
