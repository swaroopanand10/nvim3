local M = {}

local keys = {
    {
        '<leader>cf',
        function()
            require('conform').format()
        end,
        desc = 'conform format',
    },
}

local config = function()
    require('conform').setup({
        formatters_by_ft = {
            lua = { 'stylua' },
            -- Conform will run multiple formatters sequentially
            python = { 'isort', 'black', 'ruff_format' },
            -- Use a sub-list to run only the first available formatter
            javascript = { { 'prettierd', 'prettier' } },
            c = { 'clang_format' },
            cpp = { 'clang_format' },
            -- rust = { 'rust-analyzer' },
            sh = { 'shfmt' },
        },
        format_on_save = {
            -- These options will be passed to conform.format()
            -- async = false
            -- timeout_ms = 500,
            -- lsp_fallback = false,
        },
        format_after_save = {
            -- lsp_fallback = false,
        },
    })
end

M.keys = keys
M.config = config
return M
