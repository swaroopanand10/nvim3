local M = {}
local keys = {
    {
        '<leader>jz',
        '<cmd>:ZenMode<cr>',
        silent = true,
        desc = 'zenmode toggle',
    },
}
local config = function()
    local status_ok, zen = pcall(require, 'zen-mode')
    if not status_ok then
        return
    end
    local opts = {
        window = {
            backdrop = 0.95,
            width = 90,
            height = 1,
            options = {
                signcolumn = 'no',
                number = false,
                relativenumber = false,
                cursorline = false,
                cursorcolumn = false,
                foldcolumn = '0',
                list = false,
            },
        },
        plugins = {
            -- disable some global vim options (vim.o...)
            -- comment the lines to not apply the options
            options = {
                enabled = true,
                ruler = false, -- disables the ruler text in the cmd line area
                showcmd = false, -- disables the command in the last line of the screen
                -- you may turn on/off statusline in zen mode by setting 'laststatus'
                -- statusline will be shown only if 'laststatus' == 3
                laststatus = 0, -- turn off the statusline in zen mode
            },
            tmux = { enabled = true }, --seems that true value disables the tmux statusline
            kitty = {
                enabled = false, --disabling it since it is forcing the text size to fall back to default small, anyway didn't need it
                font = '+4', -- font size increment
            },
            gitsigns = { enabled = true },
        },
    }
    zen.setup(opts)
end
M.keys = keys
M.config = config

return M
