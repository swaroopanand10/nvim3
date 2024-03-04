_G.set_terminal_keymaps = function()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-g>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<m-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<m-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<m-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<m-l>', [[<C-\><C-n><C-W>l]], opts)
end
local M = {}
local opts = {
    size = 15,
    open_mapping = [[<c-\>]],
    hide_numbers = true,
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    -- direction = "float",
    direction = 'horizontal',
    close_on_exit = true,
    shell = vim.o.shell,

    vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()'),
}
local config = function()
    require('toggleterm').setup(opts)
end
M.config = config
return M
