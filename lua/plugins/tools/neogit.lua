local M = {}

local keys = {
    {
        '<leader>gn',
        function()
            require('neogit').open({ kind = 'vsplit' })
        end,
        'neogit',
    },
}
M.keys = keys
return M
