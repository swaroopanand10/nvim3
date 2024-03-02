local M = {}
local config = function()
    local opts = {
        hint = 'floating-big-letter',
        show_prompt = false,
    }
    require('window-picker').setup(opts)
    -- keymaps for manupulating window using nvim_window_picker
end
-- local map = vim.keymap.set
local keys = {
    {
        '<leader>jww',
        function()
            local winid = require('window-picker').pick_window()
            if winid then
                vim.api.nvim_set_current_win(winid)
            end
        end,
        desc = 'switch window',
        silent = true,
    },
    {
        '<A-;>',
        function()
            local winid = require('window-picker').pick_window()
            if winid then
                vim.api.nvim_set_current_win(winid)
            end
        end,
        desc = 'switch window',
        silent = true,
    },
    {
        '<leader>jwd',
        function()
            local winid = require('window-picker').pick_window()
            if winid then
                vim.api.nvim_win_close(winid, true)
            end
        end,
        desc = 'delete window',
        silent = true,
    },
    {
        '<leader>jws',
        function()
            local windowid = require('window-picker').pick_window()
            local function swap_with(stay, winid)
                if not winid then
                    return
                end

                local cur_winid = vim.fn.win_getid()

                local cur_bufnr = vim.api.nvim_win_get_buf(cur_winid)
                local target_bufnr = vim.api.nvim_win_get_buf(winid)

                vim.api.nvim_win_set_buf(cur_winid, target_bufnr)
                vim.api.nvim_win_set_buf(winid, cur_bufnr)

                if not stay then
                    vim.api.nvim_set_current_win(winid)
                end
            end
            swap_with(true, windowid)
        end,
        desc = 'swap window',
        silent = true,
    },
}
M.config = config
M.keys = keys
return M
