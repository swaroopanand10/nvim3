local M = {}
local keys = {
    {
        '<leader>gh',
        '<cmd>DiffviewOpen<cr>',
        desc = 'open diffview',
    },
    {
        '<leader>gH',
        '<cmd>DiffviewFileHistory<cr>',
        desc = 'open diffview file history',
    },
}
M.keys = keys
return M
