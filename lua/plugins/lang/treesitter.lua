local configs = require('nvim-treesitter.configs')

local auto_install = require('lib.util').get_user_config('auto_install', true)
local installed_parsers = {}
if auto_install then
    installed_parsers = require('plugins.list').ts_parsers
end

-- local textobjects = require('plugins.lang.textobjects') -- this was slowing down zig files, so I will disable it when using zig

configs.setup({
    ensure_installed = installed_parsers,
    sync_install = false,
    ignore_install = {  'tmux' },
    auto_install = true,

    -- textobjects = textobjects, -- was slowing down zig and anyway don't need it much
    autopairs = { enable = true },
    -- endwise = { enable = true },
    autotag = { enable = true },
    matchup = { enable = true },
    indent = { enable = true },

    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = false,
    },

    context_commentstring = {
        enable = true,
        enable_autocmd = false,
    },

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<c-space>',
            node_incremental = '<c-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },

    -- textsubjects = {
    --     enable = true,
    --     prev_selection = ',',
    --     keymaps = {
    --         ['.'] = { 'textsubjects-smart', desc = 'Select the current text subject' },
    --         ['a;'] = {
    --             'textsubjects-container-outer',
    --             desc = 'Select outer container (class, function, etc.)',
    --         },
    --         ['i;'] = {
    --             'textsubjects-container-inner',
    --             desc = 'Select inside containers (classes, functions, etc.)',
    --         },
    --     },
    -- },
    --
    -- refactor = {
    --     highlight_definitions = {
    --         enable = true,
    --         clear_on_cursor_move = true,
    --     },
    --     highlight_current_scope = { enable = true },
    --     smart_rename = {
    --         enable = true,
    --         keymaps = {
    --             smart_rename = '<leader>rr',
    --         },
    --     },
    --     navigation = {
    --         enable = true,
    --         keymaps = {
    --             goto_definition = '<leader>rd',
    --             list_definitions = '<leader>rl',
    --             list_definitions_toc = '<leader>rh',
    --             goto_next_usage = '<leader>rj',
    --             goto_previous_usage = '<leader>rk',
    --         },
    --     },
    -- },
})
