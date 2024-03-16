local M = {}

local keys = {
    {
        '<leader>cf',
        function()
            -- require('conform').format()
            require('conform').format({ async = true, lsp_fallback = true })
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
            -- html = { 'html' },
        },
        format_on_save = function(bufnr)
            -- Disable with a global or buffer-local variable
            vim.g.disable_autoformat = true
            vim.b[bufnr].disable_autoformat = true
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                return
            end
            return { timeout_ms = 500, lsp_fallback = true }
        end,
        -- format_on_save = {
        --     -- These options will be passed to conform.format()
        --     -- async = false
        --     -- timeout_ms = 500,
        --     -- lsp_fallback = false,
        -- },
        -- format_after_save = {
        --     -- lsp_fallback = false,
        -- },
    })
end

M.keys = keys
M.config = config
return M
