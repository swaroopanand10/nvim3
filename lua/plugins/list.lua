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
    {
        'navarasu/onedark.nvim',
        config = load_config('ui.onedark'),
        lazy = false,
        priority = 1000,
    },
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
        'nvim-lualine/lualine.nvim',
        config = load_config('ui.lualine'),
        event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'VeryLazy' },
    },
    {
        'folke/todo-comments.nvim',
        cmd = { 'TodoTrouble', 'TodoTelescope' },
        event = 'BufEnter',
        config = true,
         -- stylua: ignore
        keys = {
          { "]t", function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
          { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
          { "<leader>xt", "<cmd>TodoTrouble<cr>", desc = "Todo (Trouble)" },
          { "<leader>xT", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
          { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo" },
          { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        config = load_config('ui.indentline'),
        main = 'ibl',
        -- event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        event = { 'VeryLazy' },
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        config = load_config('ui.rainbow'),
        -- event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        event = { 'VeryLazy' },
    },
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
        -- event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        event = { 'VeryLazy' },
    },
    {
        'uga-rosa/ccc.nvim',
        cmd = { 'CccHighlighterToggle', 'CccConvert', 'CccPick' },
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
    -- {
    --     'gelguy/wilder.nvim',
    --     build = function()
    --         vim.cmd([[silent UpdateRemotePlugins]])
    --     end,
    --     config = load_config('ui.wilder'),
    --     keys = { ':', '/', '?' },
    -- },
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

    -- Tresitter
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {
            -- 'nvim-treesitter/nvim-treesitter-refactor',
            'nvim-treesitter/nvim-treesitter-textobjects',
            -- 'RRethy/nvim-treesitter-endwise',
            -- 'RRethy/nvim-treesitter-textsubjects',
            'windwp/nvim-ts-autotag',
        },
        config = load_config('lang.treesitter'),
        -- event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        event = { 'VeryLazy' },
    },
    -- {
    --     'ckolkey/ts-node-action',
    --     dependencies = { 'nvim-treesitter' },
    -- },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            'neovim/nvim-lspconfig',
            'williamboman/mason-lspconfig.nvim',
        },
        config = load_config('lang.lsp-zero'),
        event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        -- event = { 'VeryLazy' },
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
        'nvimtools/none-ls.nvim',
        dependencies = { 'neovim/nvim-lspconfig', 'jay-babu/mason-null-ls.nvim' },
        config = load_config('lang.null-ls'),
        -- event = { 'BufReadPre', 'BufNewFile' },
        -- event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
        event = { 'VeryLazy' },
    },

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
        cmd = { 'TroubleToggle', 'Trouble' },
        opts = load_configs('tools.trouble').opts,
        keys = load_configs('tools.trouble').keys,
    },
    {
        'theprimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = load_configs('tools.harpoon').config,
        keys = load_configs('tools.harpoon').keys,
    },
    {
        'echasnovski/mini.files',
        config = load_configs('tools.minifiles').config,
        keys = load_configs('tools.minifiles').keys,
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
        build = ':Neorg sync-parsers',
        dependencies = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-neorg/neorg-telescope' },
            { 'nvim-telescope/telescope.nvim' },
        },
        ft = 'norg', -- lazy load on filetype
        opts = load_configs('tools.neorg').opts,
        keys = load_configs('tools.neorg').keys,
    },

    {
        'echasnovski/mini.surround',
        opts = {
            mappings = {
                add = ';;',
                delete = ';d',
                find = ';f',
                find_left = ';F',
                highlight = ';h',
                replace = ';r',
                update_n_lines = ';n',
            },
        },
        keys = { ';;', ';r', ';d', ';h', ';n', ';f', ';F' },
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
    {
        'abecodes/tabout.nvim',
        config = load_config('tools.tabout'),
        event = 'InsertEnter',
    },
    {
        'folke/flash.nvim',
        config = load_configs('tools.flash').config,
        keys = load_configs('tools.flash').keys,
    },
    -- {
    --     'chrisgrieser/nvim-spider',
    --     config = load_config('tools.spider'),
    --     -- event = { 'BufReadPre', 'BufNewFile' },
    -- },
    {
        'folke/which-key.nvim',
        config = load_config('tools.which-key'),
        keys = { '<space>' },
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
            'ThePrimeagen/harpoon',
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
        event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
    },
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
    },
    -- {
    --     'pwntester/octo.nvim',
    --     config = load_config('tools.octo'),
    --     cmd = 'Octo',
    --     opts = true,
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
}

local lsp_servers = {
    'bashls',
    'eslint',
    -- 'elixirls',
    'jsonls',
    'lua_ls',
    -- 'ruby_ls',
    'ruff_lsp',
    -- 'rubocop',
    'rust_analyzer',
    'tsserver',
    -- 'typos_lsp',
    'vimls',
    'clangd',
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
