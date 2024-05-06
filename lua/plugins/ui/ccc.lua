local M = {}

-- local colored_fts = {
--     'cfg',
--     'css',
--     'conf',
--     'lua',
--     'scss',
-- }
local keys = {
    {
        '<leader>jC',
        '<cmd>CccPick<cr>',
        silent = true,
        desc = 'Ccc Pick',
    },
    {
        '<leader>jc',
        '<cmd>CccHighlighterToggle<cr>',
        silent = true,
        desc = 'Ccc highlight toggle',
    },
    {
        '<leader>jp',
        '<cmd>CccPick<cr>',
        silent = true,
        desc = 'Ccc highlight toggle',
    },
}

local config = function()
    local ccc = require('ccc')

    -- Use uppercase for hex codes.
    -- ccc.output.hex.setup({ uppercase = true })
    -- ccc.output.hex_short.setup({ uppercase = true })

    ccc.setup({
        highlighter = {
            auto_enable = true,
            -- filetypes = colored_fts,
            lsp = true,
        },
    })
end

M.keys = keys
M.config = config
return M
