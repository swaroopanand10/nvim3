local M = {}
local opts = { use_diagnostic_signs = true }
local keys = {
    { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Workspace Diagnostics (Trouble)' },
    { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
    { '<leader>xL', '<cmd>Trouble loclist<cr>', desc = 'Location List (Trouble)' },
    { '<leader>xQ', '<cmd>Trouble quickfix<cr>', desc = 'Quickfix List (Trouble)' },
    {
        '<leader>xd',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
    },
    {
        '<leader>xs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
    },
    {
        '<leader>xp',
        function()
            require('trouble').toggle_preview(opts)
        end,
        desc = 'preview toggle',
    },
    {
        '<leader>xV',
        function()
            require('trouble').jump_split(opts)
        end,
        desc = 'horizonal split',
    },
    {
        '<leader>xv',
        function()
            require('trouble').jump_vsplit(opts)
        end,
        desc = 'vertical split',
    },
    {
        '[q',
        function()
            if require('trouble').is_open() then
                require('trouble').previous({ skip_groups = true, jump = true })
            else
                local ok, err = pcall(vim.cmd.cprev)
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end
        end,
        desc = 'Previous trouble/quickfix item',
    },
    {
        ']q',
        function()
            if require('trouble').is_open() then
                require('trouble').next({ skip_groups = true, jump = true })
            else
                local ok, err = pcall(vim.cmd.cnext)
                if not ok then
                    vim.notify(err, vim.log.levels.ERROR)
                end
            end
        end,
        desc = 'Next trouble/quickfix item',
    },
}
M.keys = keys
M.opts = opts
return M
