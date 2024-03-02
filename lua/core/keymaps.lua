-- local Util = require('util')

local function map(mode, lhs, rhs, opts)
    opts = opts or {}
    opts.silent = opts.silent ~= false
    vim.keymap.set(mode, lhs, rhs, opts)
end
local opts = { noremap = true, silent = true }

-- Space as leader
map('n', '<Space>', '', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
-- normal_mode = "n", insert_mode = "i", visual_mode = "v",
-- visual_block_mode = "x", term_mode = "t", command_mode = "c",

-- Use jj as escape
map('i', 'jk', '<Esc>', opts)
map('i', 'kj', '<Esc>', opts)
-- map('t', 'JJ', '<C-\\><C-n>', opts)

-- Visual overwrite paste
map({ 'v', 'x' }, 'p', '"_dP', opts)

-- Do not copy on x
map({ 'v', 'x' }, 'x', '"_x', opts)

-- Increment/decrement
map({ 'n', 'v', 'x' }, '-', '<C-x>', opts)
map({ 'n', 'v', 'x' }, '=', '<C-a>', opts)

-- Move to line beginning and end
map({ 'n', 'v', 'x' }, 'gl', '$', { desc = 'End of line' })
map({ 'n', 'v', 'x' }, 'gh', '^', { desc = 'Beginning of line' })

-- Center Cursors
map('n', 'J', 'mzJ`z', opts)
map('n', '<C-d>', '<C-d>zz', opts)
map('n', '<C-u>', '<C-u>zz', opts)
map('n', 'n', 'nzzzv', opts)
map('n', 'N', 'Nzzzv', opts)

-- Better up/down
map('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
map('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move text up and down
map({ 'v', 'x' }, 'J', ":move '>+1<CR>gv-gv", opts)
map({ 'v', 'x' }, 'K', ":move '<-2<CR>gv-gv", opts)

-- Clear search, diff update and redraw
map({ 'i', 'n' }, '<esc>', '<cmd>noh<cr><esc>', { desc = 'Escape and clear hlsearch' })

-- Consistent n/N search navigation
map('n', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('x', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('o', 'n', "'Nn'[v:searchforward]", { expr = true, desc = 'Next search result' })
map('n', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('x', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })
map('o', 'N', "'nN'[v:searchforward]", { expr = true, desc = 'Prev search result' })

-- Better indenting
map('v', '<', '<gv')
map('v', '>', '>gv')

-- Add undo breakpoints
map('i', ',', ',<c-g>u')
map('i', '.', '.<c-g>u')
map('i', ';', ';<c-g>u')

-- Resizing window sizes
map('n', '<C-h>', ':vertical resize -2<CR>', opts)
map('n', '<C-k>', ':resize -2<CR>', opts)
map('n', '<C-j>', ':resize +2<CR>', opts)
map('n', '<C-l>', ':vertical resize +2<CR>', opts)

-- Switching between windows
map('n', '<A-h>', '<C-w>h', opts)
map('n', '<A-j>', '<C-w>j', opts)
map('n', '<A-k>', '<C-w>k', opts)
map('n', '<A-l>', '<C-w>l', opts)

-- Quiting neovim after saving without prompt
map({ 'n', 'i' }, '<C-q>', '<cmd>wqa<cr>', { desc = 'quit all after saving' })
map({ 'n', 'i' }, '<C-S-q>', '<cmd>qa!<cr>', { desc = 'quit all without saving' })

-- mapping for scrolling up and down
map('n', '<A-r>', '<C-y>', opts)
map('n', '<A-e>', '<C-e>', opts)

-- Switching to last buffer
map('n', '<C-b>', '<C-6>', opts)

-- Saving buffer using <ctrl-s>
map('n', '<C-s>', ':w<cr>', opts)

-- Paste only last yanked text keybinds
map('n', 'yp', '"0p', opts)
map('n', 'yP', '"0P', opts)

-- Keymap for toggling winbar
map('n', '<leader>jb', function()
    -- local current_win = vim.fn.winnr()
    local winbar_exists = false

    -- Check if winbar exists
    for _, winid in ipairs(vim.fn.getwininfo()) do
        if winid.winbar == 1 then
            winbar_exists = true
            break
        end
    end
    if winbar_exists then
        vim.o.winbar = nil
    else
        vim.o.winbar = ' %t %m'
    end
end, { desc = 'toggle winbar', silent = true })

-- Keymap for toggling statusbar
map('n', '<leader>jx', function()
    if vim.o.laststatus == 3 then
        vim.o.laststatus = 0
        require('lualine').hide({ unhide = false })
        vim.api.nvim_set_hl(0, 'Statusline', { fg = '#1b1d2b', bg = '#000000' })
        vim.api.nvim_set_hl(0, 'StatuslineNC', { bold = true, fg = '#1b1d2b', bg = '#000000' })
        vim.cmd([[set statusline=%{repeat('─',winwidth('.'))}]])
    else
        require('lualine').hide({ unhide = true })
        vim.o.laststatus = 3
        vim.api.nvim_set_hl(0, 'Statusline', {})
        vim.api.nvim_set_hl(0, 'StatuslineNC', { fg = '#3b4261' })
    end
end, { desc = 'toggle statusbar', silent = true })

--mapping for toggling line numbers for all open windows
map('n', '<leader>ja', function()
    if vim.opt_local.number:get() or vim.opt_local.relativenumber:get() then
        -- vim.cmd([[windo if &filetype != 'noetree'| set nonumber | set norelativenumber | endif]])
        vim.cmd(
            [[let s:currentWindow = winnr() | windo if &filetype != 'neotree'| set nonumber | set norelativenumber | endif | execute s:currentWindow . "wincmd w"]]
        ) -- this helps in keeping focus to current window
    else
        -- vim.cmd([[windo if &filetype != 'noetree'| set number | set relativenumber | endif]])
        vim.cmd(
            [[let s:currentWindow = winnr() | windo if &filetype != 'neotree'| set number | set relativenumber | endif | execute s:currentWindow . "wincmd w"]]
        )
    end
end, { desc = 'toggle lineno on all windows', silent = true })

-- if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
--     map('n', '<leader>uh', function()
--         Util.toggle.inlay_hints()
--     end, { desc = 'Toggle Inlay Hints' })
-- end

-- Stopping lsp
map('n', '<leader>jL', '<cmd>LspStop<cr>', { desc = 'stop lsp', silent = true })

-- Nvim-cmp goint to next line without selecting any entry
map('i', '<A-cr>', '<c-j>', { desc = 'abort cmp then press enter', silent = true })

-- mapping for scrolling up and down
map('n', '<A-r>', '<C-y>', opts)
map('n', '<A-e>', '<C-e>', opts)
