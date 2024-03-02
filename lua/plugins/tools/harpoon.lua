local M = {}
local config = function()
    local opts = {
        settings = {
            -- save_on_toggle = true,
            -- sync_on_ui_close = true,
            -- border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
            -- key = function()
            --   return vim.loop.cwd()
            -- end,
        },
    }
    require('harpoon'):setup(opts)
end

local keys = {
    {
        '<leader>hw',
        function()
            require('harpoon'):list():append()
        end,
        desc = 'harpoon add',
    },
    {
        '<leader>hi',
        function()
            local harpoon = require('harpoon')
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'harpoon quick menu',
    },
    {
        '<leader>ha',
        function()
            require('harpoon'):list():select(1)
        end,
        desc = 'harpoon to file 1',
    },
    {
        '<leader>hs',
        function()
            require('harpoon'):list():select(2)
        end,
        desc = 'harpoon to file 2',
    },
    {
        '<leader>hd',
        function()
            require('harpoon'):list():select(3)
        end,
        desc = 'harpoon to file 3',
    },
    {
        '<leader>hf',
        function()
            require('harpoon'):list():select(4)
        end,
        desc = 'harpoon to file 4',
    },
    {
        '<leader>hg',
        function()
            require('harpoon'):list():select(5)
        end,
        desc = 'harpoon to file 5',
    },
    {
        '<leader>hh',
        function()
            require('harpoon'):list():select(6)
        end,
        desc = 'harpoon to file 6:,',
    },
    {
        '<leader>hk',
        function()
            require('harpoon'):list():select(7)
        end,
        desc = 'harpoon to file 7',
    },
    {
        '<leader>hl',
        function()
            require('harpoon'):list():select(8)
        end,
        desc = 'harpoon to file 8',
    },
    {
        '<leader>h;',
        function()
            require('harpoon'):list():select(9)
        end,
        desc = 'harpoon to file 9',
    },
    {
        '<leader>hj',
        function()
            require('harpoon'):list():select(10)
        end,
        desc = 'harpoon to file 10',
    },
}
M.config = config
M.keys = keys
return M
