local M = {}
local keys = {
    {
        '<S-Enter>',
        function()
            require('noice').redirect(vim.fn.getcmdline())
        end,
        mode = 'c',
        desc = 'Redirect Cmdline',
    },
    {
        '<leader>snl',
        function()
            require('noice').cmd('last')
        end,
        desc = 'Noice Last Message',
    },
    {
        '<leader>snh',
        function()
            require('noice').cmd('history')
        end,
        desc = 'Noice History',
    },
    {
        '<leader>sna',
        function()
            require('noice').cmd('all')
        end,
        desc = 'Noice All',
    },
    {
        '<leader>snd',
        function()
            require('noice').cmd('dismiss')
        end,
        desc = 'Dismiss All',
    },
    -- {
    --     '<c-f>',
    --     function()
    --         if not require('noice.lsp').scroll(4) then
    --             return '<c-f>'
    --         end
    --     end,
    --     silent = true,
    --     expr = true,
    --     desc = 'Scroll forward',
    --     mode = { 'i', 'n', 's' },
    -- },
    -- {
    --     '<c-b>',
    --     function()
    --         if not require('noice.lsp').scroll(-4) then
    --             return '<c-b>'
    --         end
    --     end,
    --     silent = true,
    --     expr = true,
    --     desc = 'Scroll backward',
    --     mode = { 'i', 'n', 's' },
    -- },
}

local config = function()
    local status_ok, noice = pcall(require, 'noice')
    if not status_ok then
        return
    end

    local opts = {
        lsp = {
            override = {
                ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                ['vim.lsp.util.stylize_markdown'] = true,
                ['cmp.entry.get_documentation'] = true,
            },
            -- when loading with persistance it is throwing errors
            signature = {
                enabled = true,
                auto_open = {
                    enabled = true,
                    trigger = false, -- Automatically show signature help when typing a trigger character from the LSP
                    luasnip = false, -- Will open signature help when jumping to Luasnip insert nodes
                    throttle = 50, -- Debounce lsp signature help request by 50ms
                },
                view = nil, -- when nil, use defaults from documentation
                ---@type NoiceViewOptions
                opts = {}, -- merged with defaults from documentation
            },
            -- hover = { enabled = false },
        },
        routes = {
            {
                filter = {
                    event = 'msg_show',
                    any = {
                        { find = '%d+L, %d+B' },
                        { find = '; after #%d+' },
                        { find = '; before #%d+' },
                    },
                },
                view = 'mini',
            },
        },
        presets = {
            bottom_search = true,
            command_palette = true,
            long_message_to_split = true,
            inc_rename = true,
        },
    }
    noice.setup(opts)
end
M.config = config
M.keys = keys
return M
