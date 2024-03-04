-- local status_ok, neorg = pcall(require, 'neorg')
-- if not status_ok then
--     return
-- end

local M = {}
local keys = {
    {
        '<leader>in',
        '<cmd>:Neorg<cr>',
        silent = true,
        desc = 'neorg menu',
    },
    {
        '<leader>ip',
        '<cmd>:Neorg sync-parsers<cr>',
        silent = true,
        desc = 'Neorg sync-parsers',
    },
    {
        '<leader>ii',
        '<cmd>:Neorg index<cr>',
        silent = true,
        desc = 'Neorg index',
    },
    {
        '<leader>iw',
        '<cmd>:Telescope neorg switch_workspace<cr>',
        silent = true,
        desc = 'Neorg switch workspace',
    },

    {
        '<leader>il',
        '<cmd>:Telescope neorg find_linkable<cr>',
        silent = true,
        desc = 'Neorg find_linkable in current workspace',
    },

    {
        '<leader>ih',
        '<cmd>:Telescope neorg search_headings<cr>',
        silent = true,
        desc = 'Neorg search headings in current file',
    },
    {
        '<leader>if',
        '<cmd>:Telescope neorg find_norg_files<cr>',
        silent = true,
        desc = 'Neorg search files in current workspace',
    },
    {
        '<leader>ir',
        '<cmd>:Neorg return<cr>',
        silent = true,
        desc = 'Neorg return',
    },
    {
        '<leader>im',
        '<cmd>:Neorg inject-metadata<cr>',
        silent = true,
        desc = 'Neorg inject-metadata',
    },
    {
        '<leader>is',
        '<cmd>:Neorg generate-workspace-summary<cr>',
        silent = true,
        desc = 'Neorg generate-workspace-summary',
    },
    {
        '<leader>ij',
        '<cmd>:Neorg journal<cr>',
        silent = true,
        desc = 'Neorg journal menu',
    },
    {
        '<leader>ik',
        '<cmd>:Neorg keybind all<cr>',
        silent = true,
        desc = 'Neorg keybind all',
    },
    {
        '<leader>ie',
        '<cmd>:Neorg keybind all core.integrations.telescope.insert_link<cr>',
        silent = true,
        desc = 'insert link',
    },
    {
        '<leader>ia',
        '<cmd>:Neorg keybind all core.integrations.telescope.insert_file_link<cr>',
        silent = true,
        desc = 'insert file link',
    },
}
local opts = {
    load = {
        ['core.defaults'] = {}, -- Loads default behaviour
        ['core.concealer'] = {}, -- Adds pretty icons to your documents
        ['core.dirman'] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = '~/notes/default',
                    cprg = '~/notes/cprg',
                    cppprg = '~/notes/cppprg',
                    networking = '~/notes/networking',
                    comparch = '~/notes/comparch',
                    rs = '~/notes/rs',
                    asm = '~/notes/asm',
                    os = '~/notes/os',
                    wayland = '~/notes/wayland',
                    gtk = '~/notes/gtk',
                    unix = '~/notes/unix',
                    js = '~/notes/js',
                    css = '~/notes/css',
                },
                default_workspace = nil, -- doing this is best as it puts us in workspace of current dir
                index = 'index.norg',
                -- open_last_workspace = true, -- not working
            },
        },
        ['core.integrations.telescope'] = {},
        ['core.completion'] = {
            config = {
                engine = 'nvim-cmp',
            },
        },
        ['core.export'] = {},
        ['core.summary'] = {},
        ['core.ui'] = {},
        ['core.ui.calendar'] = {},
    },
}

M.opts = opts
M.keys = keys

return M
