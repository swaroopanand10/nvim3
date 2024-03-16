local M = {}

local config = function()
    require('lint').linters_by_ft = {
        -- markdown = { 'vale' },
        javascript = {
            'eslint_d',
        },
        typescript = {
            'eslint_d',
        },
        javascriptreact = {
            'eslint_d',
        },
        typescriptreact = {
            'eslint_d',
        },
    }
end

M.config = config
return M
