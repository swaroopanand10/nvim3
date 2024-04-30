local M = {}

local config = function()
    local status_ok, fzflua = pcall(require, 'fzf-lua')
    local actions = require('fzf-lua.actions')
    if not status_ok then
        return
    end

    local opts = {
        'telescope',
        keymap = {
            builtin = {
                ['<F1>'] = 'toggle-help',
                ['<F2>'] = 'toggle-fullscreen',
                ['C-j'] = 'down',
                ['C-k'] = 'up',
                -- Only valid with the 'builtin' previewer
                -- ["<F3>"]     = "toggle-preview-wrap",
                ['<C-h>'] = 'toggle-preview-wrap',
                ['<F4>'] = 'toggle-preview',
                ['<F5>'] = 'toggle-preview-ccw',
                ['<F6>'] = 'toggle-preview-cw',
                ['<C-d>'] = 'preview-page-down',
                ['<C-u>'] = 'preview-page-up',
                ['<S-left>'] = 'preview-page-reset',
            },
            fzf = {
                ['ctrl-z'] = 'abort',
                ['ctrl-j'] = 'down',
                ['ctrl-k'] = 'up',
                ['ctrl-f'] = 'half-page-down',
                ['ctrl-b'] = 'half-page-up',
                ['ctrl-a'] = 'beginning-of-line',
                ['ctrl-e'] = 'end-of-line',
                ['alt-a'] = 'toggle-all',
                -- Only valid with fzf previewers (bat/cat/git/etc)
                ['f3'] = 'toggle-preview-wrap',
                ['f4'] = 'toggle-preview',
                ['ctrl-d'] = 'preview-page-down',
                ['ctrl-u'] = 'preview-page-up',
                ['ctrl-q'] = 'select-all+accept',
            },
        },
        files = {
            fzf_opts = {
                ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-files-history',
            },
            actions = {
                -- inherits from 'actions.files', here we can override
                -- or set bind to 'false' to disable a default action
                -- action to toggle `--no-ignore`, requires fd or rg installed
                ['ctrl-r'] = { actions.toggle_ignore },
                ['ctrl-g'] = false,
                -- uncomment to override `actions.file_edit_or_qf`
                --   ["default"]   = actions.file_edit,
                -- custom actions are available too
                --   ["ctrl-y"]    = function(selected) print(selected[1]) end,
            },
        },
        grep = {
            fzf_opts = {
                ['--history'] = vim.fn.stdpath('data') .. '/fzf-lua-grep-history',
            },
            actions = {
                -- actions inherit from 'actions.files' and merge
                -- this action toggles between 'grep' and 'live_grep'
                ['ctrl-g'] = false,
                ['ctrl-r'] = { actions.grep_lgrep },
                -- uncomment to enable '.gitignore' toggle for grep
                ['ctrl-e'] = { actions.toggle_ignore },
            },
        },
    }

    fzflua.setup(opts)
end
local keys = {
    { '<leader>kF', '<cmd>FzfLua<cr>', silent = true, desc = 'fzflua' },
    -- { "<leader>ka", "<cmd>FzfLua files cwd=/home/swaroop/<cr>", desc = "fzflua files in ~" },
    { '<leader>kc', '<cmd>FzfLua files cwd=/home/swaroop/.config/<cr>', desc = 'fzflua config files' },
    { '<leader>k.', '<cmd>FzfLua files cwd=$HOME/dotstow/<cr>', desc = 'fzflua dotstow files' },
    { '<leader>kh', '<cmd>FzfLua files cwd=/home/swaroop/.local/<cr>', desc = 'fzflua local files' },
    { '<leader>kR', '<cmd>FzfLua lgrep_curbuf<cr>', desc = 'fzflua curbuf livegrep regex' },
    { '<leader>kr', '<cmd>FzfLua grep_curbuf<cr>', desc = 'fzflua curbuf grep fuzzy' },
    { '<leader>kw', '<cmd>FzfLua grep_visual<cr>', desc = 'fzflua visualgrep workspace fuzzy' },
    { '<leader>kW', '<cmd>FzfLua live_grep_glob<cr>', desc = 'fzflua livegrep workspace regex' },
    -- { "<leader>kf", "<cmd>FzfLua files<cr>", desc = "fzflua find files" },
    -- { "<leader>kp", "<cmd>FzfLua files cwd=/home/swaroop/Projects/<cr>", desc = "fzflua find files" },
    { '<leader>kb', '<cmd>FzfLua buffers<cr>', desc = 'fzflua find buffers' },
    { '<leader>kl', '<cmd>FzfLua blines<cr>', desc = 'fzflua find bufferlines fuzzy' },
    { '<leader>kL', '<cmd>FzfLua lines<cr>', desc = 'fzflua find workspace lines fuzzy' },
    { '<leader>kd', '<cmd>FzfLua resume<cr>', desc = 'resume' },
    { '<leader>kD', '<cmd>FzfLua live_grep_resume<cr>', desc = 'resume live grep' },
    -- map("n", "<leader>ko","<cmd>call fzf#run({'source': 'find ~/ -type d', 'sink':  'edit','down': '35%'})<cr>",opts); -- not working for some reason
    -- map("n", "<leader>ko","<cmd>:lua require'fzf-lua'.files({prompt='LS> ',cmd = 'find ~/ -type d', cwd='~/'})<cr>",opts);
    -- map("n", "<leader>kO","<cmd>:lua require'fzf-lua'.files({prompt='LS> ',cmd = 'find ~/ -type d', cwd='./' })<cr>",opts);
    {
        '<leader>ko',
        function()
            require('fzf-lua').files({
                prompt = 'LS> ',
                cmd = 'find ~/ -type d',
                cwd = '~/',
                winopts = { preview = { hidden = 'true' } },
            })
        end,
        silent = true,
        desc = 'fuzzy search all directories in ~',
    },
    { -- this will search all(including hidden) files in the git repo
        '<leader>kf',
        function()
            require('fzf-lua').git_files({
                prompt = 'LS> ',
                cmd = 'find -type f',
                -- cwd = "~/",
                winopts = { preview = { hidden = 'true' } },
            })
        end,
        silent = true,
        desc = 'fuzzy search all files in git repo',
    },
    {
        '<leader>kO',
        function()
            require('fzf-lua').files({
                prompt = 'LS> ',
                cmd = 'find . -type d',
                -- cwd = "cwd", -- it was saying that value cwd is depreciated
                winopts = { preview = { hidden = 'true' } },
            })
        end,
        silent = true,
        desc = 'fuzzy search all directories in .',
    },
    {
        '<leader>kp',
        function()
            require('fzf-lua').files({
                prompt = 'LS> ',
                cmd = 'find /home/swaroop/Projects -type d',
                cwd = '~/Projects/',
                winopts = { preview = { hidden = 'true' } },
            })
        end,
        silent = true,
        desc = 'fuzzy search projects',
    },
    {
        '<leader>ka',
        function()
            require('fzf-lua').files({
                prompt = 'LS> ',
                -- cmd = "find /home/swaroop/ -not -path '*/.*'",
                cmd = 'find ~ -not -path "*/.*" -not -name "*.exe" -not -name "*.out" -not -name "*.pdf" -not -name "*.jpg" -not -name "*.png" -not -name "*.jpeg" -not -name "*.tar" -not -name "*.mp3" -not -name "*.opus" -not -name "*.docx" -type f',
                cwd = '~/',
                winopts = { preview = { hidden = 'true' } },
            })
        end,
        silent = true,
        desc = 'fuzzy search normal files in ~',
    },
    {
        '<leader>kA',
        function()
            require('fzf-lua').files({
                prompt = 'LS> ',
                cmd = 'find /home/swaroop/',
                cwd = '~/',
                winopts = { preview = { hidden = 'true' } },
            })
        end,
        silent = true,
        desc = 'fuzzy search all files in ~',
    },
}
M.config = config
M.keys = keys
return M
