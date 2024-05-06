local function load_config(package)
    return function()
        require('plugins.' .. package)
    end
end

local function load_configs(package)
    return require('plugins.' .. package)
end

local plugins = {
    -- UI
    -- {
    --     'navarasu/onedark.nvim',
    --     config = load_config('ui.onedark'),
    --     lazy = false,
    --     priority = 1000,
    -- },
    -- {
    --     'rose-pine/neovim',
    --     config = load_config('ui.rosepine'),
    --     lazy = false,
    --     priority = 1000,
    -- },
    -- {
    --     'folke/tokyonight.nvim',
    --     config = load_config('ui.tokyonight'),
    --     lazy = false,
    --     priority = 1000,
    -- },
    {
        'swaroopanand10/coal2.nvim',
        config = load_config('ui.coal2'),
        lazy = false,
        priority = 1000,
    },
    {
        'nvim-lualine/lualine.nvim',
        config = load_config('ui.lualine'),
        -- event = { 'BufReadPre', 'BufNewFile' }, -- no need to load it
        -- event = { 'VeryLazy' },
    },
    -- {
    --     'chrisgrieser/nvim-recorder',
    --     dependencies = 'rcarriga/nvim-notify', -- optional
    --     opts = {}, -- required even with default settings, since it calls `setup()`
    -- },

    {
        'folke/todo-comments.nvim',
        cmd = { 'TodoTrouble', 'TodoTelescope' },
        -- event = 'VeryLazy',
        event = 'LazyFile',
        config = true,
        -- stylua: ignore
        keys = {
            { "]t",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
            { "[t",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
            { "<leader>xt", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
            { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
            { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
            { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = load_config('ui.indentline'),
        main = 'ibl',
        -- event = { 'VeryLazy' },
        event = { 'LazyFile' },
    },
    -- { -- not needed
    --     'echasnovski/mini.indentscope',
    --     config = function()
    --         require('mini.indentscope').setup({
    --             symbol = '│',
    --             options = { try_as_border = true },
    --         })
    --     end,
    --     version = '*',
    --     event = 'LazyFile',
    -- },
    -- {
    --     'HiPhish/rainbow-delimiters.nvim',
    --     config = load_config('ui.rainbow'),
    --     -- event = { 'VeryLazy' },
    --     event = { 'LazyFile' },
    -- },
    {
        'rcarriga/nvim-notify',
        config = load_configs('ui.notify').config,
        keys = load_configs('ui.notify').keys,
        event = 'VeryLazy',
        cmd = 'Notifications',
    },
    {
        'stevearc/dressing.nvim',
        config = load_config('ui.dressing'),
        -- event = { 'VeryLazy' },
        event = { 'LazyFile' },
    },
    {
        'uga-rosa/ccc.nvim',
        cmd = { 'CccHighlighterToggle', 'CccConvert', 'CccPick' },
        config = load_configs('ui.ccc').config,
        keys = load_configs('ui.ccc').keys,
    },
    {
        'nvimdev/dashboard-nvim',
        config = load_config('ui.dashboard'),
        -- Only load when no arguments
        event = function()
            if vim.fn.argc() == 0 then
                return 'VimEnter'
            end
        end,
        cmd = 'Dashboard',
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
        },
        config = load_configs('ui.noice').config,
        keys = load_configs('ui.noice').keys,
    },
    {
        'folke/zen-mode.nvim',
        -- dependencies = {
        --     'folke/twilight.nvim',
        --     config = load_config('ui.twilight'),
        -- },
        config = load_configs('ui.zen-mode').config,
        keys = load_configs('ui.zen-mode').keys,
        cmd = { 'ZenMode' },
    },
    {
        'benlubas/wrapping-paper.nvim',
        keys = {
            {
                mode = { 'n' },
                'gw',
                "<cmd>lua require('wrapping-paper').wrap_line()<cr>",
                silent = true,
                desc = 'fake wrap current line',
            },
        },
    },
    -- Language
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
        },
        config = load_config('lang.dap'),
        cmd = { 'DapUIToggle', 'DapToggleRepl', 'DapToggleBreakpoint' },
    },
    {
        'nvim-neotest/neotest',
        dependencies = {
            'antoinemadec/FixCursorHold.nvim',
            'olimorris/neotest-rspec',
            'haydenmeade/neotest-jest',
        },
        config = load_config('lang.neotest'),
        cmd = 'Neotest',
    },
    {
        'ThePrimeagen/refactoring.nvim',
        config = load_config('lang.refactoring'),
    },

    -- Treesitter
    {
        'nvim-treesitter/nvim-treesitter',
        version = false,
        build = ':TSUpdate',
        dependencies = {
            -- 'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'RRethy/nvim-treesitter-endwise',
            -- 'RRethy/nvim-treesitter-textsubjects',
        },
        init = function(plugin)
            -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
            -- This is needed because a bunch of plugins no longer `require("nvim-treesitter")`, which
            -- no longer trigger the **nvim-treesitter** module to be loaded in time.
            -- Luckily, the only things that those plugins need are the custom queries, which we make available
            -- during startup.
            require('lazy.core.loader').add_to_rtp(plugin)
            require('nvim-treesitter.query_predicates')
        end,
        config = load_config('lang.treesitter'),
        -- event = { 'LazyFile', 'VeryLazy' },
        event = { 'LazyFile' },
    },
    {
        'windwp/nvim-ts-autotag',
        event = 'LazyFile',
        opts = {},
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        -- event = 'VeryLazy',
        event = 'LazyFile',
        enabled = true,
        opts = { mode = 'cursor', max_lines = 3 },
        keys = {
            {
                '<leader>ut',
                '<cmd>TSContextToggle<cr>',
                desc = 'Toggle Treesitter Context',
            },
        },
    },
    {
        'ckolkey/ts-node-action',
        dependencies = { 'nvim-treesitter' },
    },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason-lspconfig.nvim',
        },
        init = function() -- needed this to make it work with noice.nvim
            vim.g.lsp_zero_ui_float_border = 0
        end,
        config = load_config('lang.lsp-zero'),
        -- event = { 'VeryLazy' },
        event = { 'LazyFile' },
    },
    {
        'folke/neodev.nvim',
        ft = { 'lua', 'vim' },
        config = load_config('lang.neodev'),
    },
    {
        'nvimdev/lspsaga.nvim',
        config = load_config('lang.lspsaga'),
        event = 'LspAttach',
    },
    {
        'stevearc/conform.nvim',
        config = load_configs('lang.conform').config,
        keys = load_configs('lang.conform').keys,
    },
    -- {
    --     'Maan2003/lsp_lines.nvim',
    --     config = load_config('lang.lsp-lines'),
    --     event = 'LspAttach',
    -- },
    {
        'williamboman/mason.nvim',
        config = load_config('lang.mason'),
        cmd = 'Mason',
    },
    {
        'WhoIsSethDaniel/mason-tool-installer.nvim',
        config = load_configs('lang.mason_tool_installer').config,
        event = 'VeryLazy',
        -- event = { 'BufReadPre', 'BufNewFile' },
    },
    -- {
    --     'mrcjkb/rustaceanvim',
    --     version = '^4', -- Recommended
    --     lazy = false, -- This plugin is already lazy
    -- },
    -- {
    --     'nvimtools/none-ls.nvim',
    --     dependencies = { 'neovim/nvim-lspconfig', 'jay-babu/mason-null-ls.nvim' },
    --     config = load_config('lang.null-ls'),
    --     -- event = { 'BufReadPre', 'BufNewFile' },
    --     -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    --     event = { 'VeryLazy' },
    -- },
    -- {
    --     'mfussenegger/nvim-lint',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     config = load_configs('lang.nvim_lint').config,
    -- },
    -- {
    --     'kawre/leetcode.nvim',
    --     build = ':TSUpdate html',
    --     cmd = 'Leet',
    --     dependencies = {
    --         'nvim-telescope/telescope.nvim',
    --         'nvim-lua/plenary.nvim', -- required by telescope
    --         'MunifTanjim/nui.nvim',
    --
    --         -- optional
    --         'nvim-treesitter/nvim-treesitter',
    --         'rcarriga/nvim-notify',
    --         'nvim-tree/nvim-web-devicons',
    --     },
    --     config = load_configs('lang.leetcode').config,
    -- },

    -- Completion
    {
        'hrsh7th/nvim-cmp',
        dependencies = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'hrsh7th/cmp-nvim-lua',
            'saadparwaiz1/cmp_luasnip',
        },
        config = load_config('lang.cmp'),
        event = 'InsertEnter',
    },
    {
        'L3MON4D3/LuaSnip',
        version = 'v2.*',
        dependencies = { 'rafamadriz/friendly-snippets' },
        build = 'make install_jsregexp',
        event = 'InsertEnter',
    },

    -- Tools
    {
        'folke/trouble.nvim',
        branch = 'dev',
        cmd = { 'Trouble' },
        opts = load_configs('tools.trouble').opts,
        keys = load_configs('tools.trouble').keys,
    },
    -- {
    --     'theprimeagen/harpoon',
    --     branch = 'harpoon2',
    --     dependencies = { 'nvim-lua/plenary.nvim' },
    --     config = load_configs('tools.harpoon').config,
    --     keys = load_configs('tools.harpoon').keys,
    -- },
    {
        'chentoast/marks.nvim',
        -- event = 'VeryLazy',
        event = 'LazyFile',
        config = load_configs('tools.marks').config,
        -- keys = load_configs('tools.marks').keys,
        -- keys = { 'm' },
    },
    {
        'echasnovski/mini.files',
        config = load_configs('tools.minifiles').config,
        keys = load_configs('tools.minifiles').keys,
    },
    {
        'akinsho/toggleterm.nvim',
        config = load_configs('tools.toggleterm').config,
        cmd = 'ToggleTerm',
        keys = { { '<c-\\>', '<cmd>ToggleTerm<cr>', desc = 'Toggle floating terminal' } },
    },
    {
        's1n7ax/nvim-window-picker',
        config = load_configs('tools.window_picker').config,
        keys = load_configs('tools.window_picker').keys,
    },
    {
        'nvim-tree/nvim-tree.lua',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        config = load_config('tools.nvim-tree'),
        cmd = 'NvimTreeToggle',
    },
    {
        'folke/persistence.nvim',
        event = 'BufReadPre', -- this will only start session saving when an actual file was opened
        opts = {},
        keys = {
            {
                '<leader>js',
                mode = { 'n' },
                function()
                    require('persistence').load()
                end,
                desc = 'restore persistence session',
            },
        },
    },
    -- {
    --     'olimorris/persisted.nvim',
    --     event = 'BufEnter',
    --     config = load_config('tools.persisted'),
    -- },
    {
        'numToStr/Comment.nvim',
        config = load_config('tools.comment'),
        keys = {
            {
                'gcc',
                mode = { 'n' },
                function()
                    require('Comment').toggle()
                end,
                desc = 'Comment',
            },
            {
                'gc',
                mode = { 'v' },
                function()
                    require('Comment').toggle()
                end,
                desc = 'Comment',
            },
        },
    },
    {
        'nvim-neorg/neorg',
        -- build = ':Neorg sync-parsers',
        -- version = 'v7.0.0',
        version = '*',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-neorg/neorg-telescope' },
            { 'nvim-telescope/telescope.nvim' },
            { 'vhyrro/luarocks.nvim' },
        },
        ft = 'norg', -- lazy load on filetype
        opts = load_configs('tools.neorg').opts,
        keys = load_configs('tools.neorg').keys,
    },
    { 'vhyrro/luarocks.nvim', config = true },
    {
        'xeluxee/competitest.nvim',
        dependencies = 'MunifTanjim/nui.nvim',
        config = load_configs('tools.competitest').config,
        keys = load_configs('tools.competitest').keys,
    },
    {
        'Apeiros-46B/qalc.nvim',
        cmd = 'Qalc',
        opts = {
            -- extra command arguments for Qalculate
            cmd_args = { '--set', 'fr 5', '--set', 'appr 3' }, -- this is working
        },
    },
    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = ',a',
                delete = ',d',
                find = ',f',
                find_left = ',F',
                highlight = ',h',
                replace = ',r',
                update_n_lines = ',n',
            },
        },
        keys = { ',a', ',r', ',d', ',h', ',n', ',f', ',F' },
    },
    {
        'windwp/nvim-autopairs',
        config = load_config('tools.autopairs'),
        event = 'InsertEnter',
    },
    {
        'windwp/nvim-spectre',
        config = load_config('tools.spectre'),
        cmd = 'Spectre',
    },
    -- {
    --     'abecodes/tabout.nvim',
    --     config = load_config('tools.tabout'),
    --     event = 'InsertEnter',
    -- },
    {
        'folke/flash.nvim',
        -- event = 'VeryLazy',
        keys = load_configs('tools.flash').keys,
        config = load_configs('tools.flash').config,
    },
    -- {
    --     'chrisgrieser/nvim-spider',
    --     config = load_config('tools.spider'),
    --     -- event = { 'BufReadPre', 'BufNewFile' },
    -- },
    {
        'folke/which-key.nvim',
        config = load_configs('tools.which-key').config,
        keys = load_configs('tools.which-key').keys,
        -- event = 'VeryLazy',
    },
    -- {
    --     'iamcco/markdown-preview.nvim',
    --     build = function()
    --         vim.fn['mkdp#util#install']()
    --     end,
    --     ft = 'markdown',
    --     cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview' },
    -- },

    -- Telescope
    {
        'nvim-telescope/telescope.nvim',
        -- branch = '0.1.x',
        version = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            {
                'nvim-telescope/telescope-fzf-native.nvim',
                build = 'make',
            },
            'nvim-telescope/telescope-symbols.nvim',
            'molecule-man/telescope-menufacture',
            'debugloop/telescope-undo.nvim',
            -- 'ThePrimeagen/harpoon',
        },
        config = load_configs('tools.telescope').config,
        keys = load_configs('tools.telescope').keys,
        cmd = 'Telescope',
    },
    {
        'ibhagwan/fzf-lua',
        lazy = true,
        -- optional for icon support
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = load_configs('tools.fzflua').config,
        keys = load_configs('tools.fzflua').keys,
    },
    {
        '2kabhishek/nerdy.nvim',
        dependencies = { 'stevearc/dressing.nvim' },
        cmd = 'Nerdy',
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        config = load_config('tools.gitsigns'),
        cmd = 'Gitsigns',
        -- event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        event = 'LazyFile',
    },
    -- {
    --     'tpope/vim-fugitive',
    --     cmd = 'Git',
    -- },
    -- {
    --     'NeogitOrg/neogit',
    --     dependencies = {
    --         'nvim-lua/plenary.nvim', -- required
    --         'sindrets/diffview.nvim', -- optional - Diff integration
    --         'nvim-telescope/telescope.nvim', -- optional
    --     },
    --     keys = load_configs('tools.neogit').keys,
    --     config = true,
    -- },
    {
        'sindrets/diffview.nvim',
        cmd = 'DiffviewOpen',
        keys = load_configs('tools.diffview').keys,
    },
    {
        'otavioschwanck/arrow.nvim',
        config = load_configs('tools.arrow').config,
        keys = load_configs('tools.arrow').keys,
        -- keys = { ';' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    },

    -- {
    --     'pwntester/octo.nvim',
    --     config = load_config('tools.octo'),
    --     cmd = 'Octo',
    --     opts = true,
    -- },
    -- { -- not needed that much
    --     'kdheepak/lazygit.nvim',
    --     keys = {
    --         {
    --             '<leader>gg',
    --             '<cmd>LazyGit<cr>',
    --             desc = 'Comment',
    --         },
    --     },
    --     cmd = {
    --         'LazyGit',
    --         'LazyGitConfig',
    --         'LazyGitCurrentFile',
    --         'LazyGitFilter',
    --         'LazyGitFilterCurrentFile',
    --     },
    --     -- optional for floating window border decoration
    --     dependencies = {
    --         'nvim-lua/plenary.nvim',
    --     },
    -- },
}

local ts_parsers = {
    'bash',
    'css',
    -- 'elixir',
    'gitcommit',
    'go',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'markdown',
    'markdown_inline',
    'python',
    -- 'ruby',
    'rust',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
    'c',
    'cpp',
    'zig',
}

local lsp_servers = {
    'bashls',
    'pyright',
    'jsonls',
    'lua_ls',
    'ruff_lsp',
    'rust_analyzer',
    'tsserver',
    -- 'typos_lsp',
    'vimls',
    'clangd',
    'html',
    -- 'emmet_ls',
    'emmet_language_server', -- modified verson of emmet_ls
    'cssls',
    'zls',
}

local null_ls_sources = {
    'shellcheck',
}

return {
    plugins = plugins,
    ts_parsers = ts_parsers,
    lsp_servers = lsp_servers,
    null_ls_sources = null_ls_sources,
}
