local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
    return
end

local icons = require('lib.icons')
local Util = require('util')

local function is_git_repo()
    vim.fn.system('git rev-parse --is-inside-work-tree')

    return vim.v.shell_error == 0
end

local function get_git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
end

local setup = {
    plugins = {
        marks = true,
        registers = true,
        spelling = {
            enabled = true,
            suggestions = 30,
        },
        presets = {
            operators = true,
            motions = true,
            text_objects = true,
            windows = true,
            nav = true,
            z = true,
            g = true,
            m = true,
            [';'] = true,
        },
    },
    key_labels = {
        ['<leader>'] = icons.ui.Rocket .. 'Space',
        ['<space>'] = icons.ui.Rocket .. 'Space',
    },
    icons = {
        breadcrumb = icons.ui.ArrowOpen,
        separator = icons.ui.Arrow,
        group = '',
    },
    popup_mappings = {
        scroll_down = '<c-d>',
        scroll_up = '<c-u>',
    },
    window = {
        border = 'none',
        position = 'bottom',
        margin = { 0, 0, 0, 0 },
        padding = { 1, 2, 1, 2 },
        winblend = 0,
    },
    layout = {
        height = { min = 4, max = 24 },
        width = { min = 20, max = 50 },
        spacing = 3,
        align = 'center',
    },
    ignore_missing = false,
    hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', '^:', '^ ', '^call ', '^lua ' },
    show_help = true,
    show_keys = true,
    triggers = 'auto',
    triggers_nowait = {
        -- marks
        '`',
        "'",
        'g`',
        "g'",
        -- registers
        '"',
        '<c-r>',
        -- spelling
        'z=',
    },
    triggers_blacklist = {
        i = { 'j', 'j' },
        v = { 'j', 'j', 'k', 'l' },
        n = { 'k', 'l', 'j' },
    },
}

local i = {
    [' '] = 'Whitespace',
    ['"'] = 'Balanced "',
    ["'"] = "Balanced '",
    ['`'] = 'Balanced `',
    ['('] = 'Balanced (',
    [')'] = 'Balanced ) including white-space',
    ['>'] = 'Balanced > including white-space',
    ['<lt>'] = 'Balanced <',
    [']'] = 'Balanced ] including white-space',
    ['['] = 'Balanced [',
    ['}'] = 'Balanced } including white-space',
    ['{'] = 'Balanced {',
    ['?'] = 'User Prompt',
    _ = 'Underscore',
    a = 'Argument',
    b = 'Balanced ), ], }',
    c = 'Class',
    f = 'Function',
    o = 'Block, conditional, loop',
    q = 'Quote `, ", \'',
    t = 'Tag',
}

local a = vim.deepcopy(i)
for k, v in pairs(a) do
    a[k] = v:gsub(' including.*', '')
end

local ic = vim.deepcopy(i)
local ac = vim.deepcopy(a)

for key, name in pairs({ n = 'Next', l = 'Last' }) do
    i[key] = vim.tbl_extend('force', { name = 'Inside ' .. name .. ' textobject' }, ic)
    a[key] = vim.tbl_extend('force', { name = 'Around ' .. name .. ' textobject' }, ac)
end

local opts = {
    mode = 'n',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
local mappings = {
    e = { '<cmd>NvimTreeToggle<cr>', icons.documents.OpenFolder .. 'Explorer' },
    -- q = { '<cmd>q<cr>', icons.ui.Close .. 'Quit' },
    -- Q = { '<cmd>qa!<cr>', icons.ui.Power .. 'Force Quit!' },
    -- w = { '<cmd>w<cr>', icons.ui.Save .. 'Save' },
    -- x = { '<cmd>x<cr>', icons.ui.Pencil .. 'Write and Quit' },
    u = {
        name = icons.ui.NeoVim .. 'Config',
        e = { '<cmd>e ~/.config/nvim/init.lua<cr>', 'Edit Config' },
        F = { '<cmd>retab<cr>', 'Fix Tabs' },
        i = { vim.show_pos, 'Inspect Position' },
        -- l = { '<cmd>:g/^\\s*$/d<cr>', 'Clean Empty Lines' },
        n = { '<cmd>set relativenumber!<cr>', 'Relative Numbers' },
        N = { '<cmd>Telescope notify<cr>', 'Notifications' },
        l = { '<cmd>Telescope reloader<cr>', 'Reload Module' },
        R = { '<cmd>ReloadConfig<cr>', 'Reload Configs' },
        m = { '<cmd>MarkdownPreviewToggle<cr>', 'Markdown Preview' },
        w = {
            function()
                Util.toggle('wrap')
            end,
            'toggle wrap mode',
        },
        c = {
            function()
                Util.toggle('conceallevel', false, { 0, conceallevel })
            end,
            'Toggle Conceal',
        },
        d = {
            function()
                Util.toggle.diagnostics()
            end,
            'Toggle Diagnostics',
        },
        r = {
            '<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>',
            'Redraw / clear hlsearch / diff update',
        },
    },
    d = {
        name = icons.ui.Bug .. 'Debug',
        b = { '<cmd>DapToggleBreakpoint<cr>', 'Breakpoint' },
        c = { '<cmd>DapContinue<cr>', 'Continue' },
        i = { '<cmd>DapStepInto<cr>', 'Into' },
        l = { "<cmd>lua require'dap'.run_last()<cr>", 'Last' },
        o = { '<cmd>DapStepOver<cr>', 'Over' },
        O = { '<cmd>DapStepOut<cr>', 'Out' },
        r = { '<cmd>DapToggleRepl<cr>', 'Repl' },
        R = { '<cmd>DapRestartFrame<cr>', 'Restart Frame' },
        t = { '<cmd>DapUIToggle<cr>', 'Debugger' },
        x = { '<cmd>DapTerminate<cr>', 'Exit' },
    },
    f = {
        name = icons.ui.Telescope .. 'Find',
    },
    k = {
        name = icons.ui.Telescope .. 'Fzflua',
    },
    j = {
        name = icons.ui.Telescope .. 'Find2',
        -- c = { '<cmd>CccHighlighterToggle<cr>', 'Colorize' },
        -- C = { '<cmd>CccConvert<cr>', 'Convert Color' },
        -- p = { '<cmd>CccPick<cr>', 'Pick Color' },
    },

    s = {
        name = icons.ui.Telescope .. 'search',
        p = { '<cmd>Lspsaga peek_definition<cr>', 'Peek Definition' },
        P = { '<cmd>Lspsaga goto_definition<cr>', 'Goto Definition' },
    },

    g = {
        name = icons.git.Octoface .. 'Git',
        a = { '<cmd>Gitsigns stage_hunk<cr>', 'Stage Hunk' },
        A = { '<cmd>Gitsigns stage_buffer<cr>', 'Stage Buffer' },
        b = { '<cmd>Gitsigns blame_line<cr>', 'Blame' },
        c = { '<cmd>Git<cr>', 'Commit' },
        -- C = { '<cmd>CoAuthor<cr>', 'Add Co Author' },
        d = { '<cmd>Gitsigns preview_hunk<cr>', 'Preview Hunk' },
        D = { '<cmd>Gitsigns diffthis HEAD<cr>', 'Diff' },
        g = { '<cmd>ToggleTerm lazygit<cr>', 'Lazygit' },
        -- h = { '<cmd>Octo<cr>', 'Octo' },
        j = { '<cmd>Gitsigns next_hunk<cr>', 'Next Hunk' },
        k = { '<cmd>Gitsigns prev_hunk<cr>', 'Prev Hunk' },
        r = { '<cmd>Gitsigns reset_hunk<cr>', 'Reset Hunk' },
        R = { '<cmd>Gitsigns reset_buffer<cr>', 'Reset Buffer' },
        s = { '<cmd>Telescope git_status<cr>', 'Changed files' },
        S = { '<cmd>Telescope git_stash<cr>', 'Stashed Changes' },
        t = {
            name = 'Git Toggle',
            b = { '<cmd>Gitsigns toggle_current_line_blame<cr>', 'Blame' },
            d = { '<cmd>Gitsigns toggle_deleted<cr>', 'Deleted' },
            l = { '<cmd>Gitsigns toggle_linehl<cr>', 'Line HL' },
            n = { '<cmd>Gitsigns toggle_numhl<cr>', 'Number HL' },
            s = { '<cmd>Gitsigns toggle_signs<cr>', 'Signs' },
            w = { '<cmd>Gitsigns toggle_word_diff<cr>', 'Word Diff' },
        },
        u = { '<cmd>Gitsigns undo_stage_hunk<cr>', 'Undo Stage Hunk' },
        v = { '<cmd>Gitsigns select_hunk<cr>', 'Select Hunk' },
    },
    h = {
        name = icons.ui.Bookmark .. 'Harpoon',
    },
    c = {
        name = icons.ui.Gear .. 'LSP',
        a = { '<cmd>Lspsaga code_action<cr>', 'Code Action' },
        d = { '<cmd>Lspsaga show_cursor_diagnostics <cr>', 'show cursor diagnostic' },
        D = { '<cmd>Lspsaga show_line_diagnostics <cr>', 'show line diagnostic' },
        -- f = { '<cmd>LspZeroFormat<cr>', 'Format' },
        g = { '<cmd>Lspsaga finder<cr>', 'Finder' },
        G = { '<cmd>Telescope lsp_references<cr>', 'References' },
        h = { '<cmd>Lspsaga hover_doc<cr>', 'Hover' },
        i = { '<cmd>Lspsaga show_buf_diagnostics<cr>', 'buffer Diagnostics' },
        I = { '<cmd>Lspsaga show_workspace_diagnostics<cr>', 'workspace Diagnostics' },
        j = { '<cmd>Lspsaga diagnostic_jump_next<cr>', 'Next Diagnostic' },
        k = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'Prev Diagnostic' },
        l = { "<cmd>lua require('lsp_lines').toggle()<cr>", 'Toggle LSP Lines' },
        L = { '<cmd>LspInfo<cr>', 'LSP Info' },
        o = { '<cmd>Lspsaga outline<cr>', 'Outline' },
        p = { '<cmd>Telescope lsp_incoming_calls<cr>', 'Incoming Calls' },
        P = { '<cmd>Telescope lsp_outgoing_calls<cr>', 'Outgoing Calls' },
        r = { '<cmd>Lspsaga rename<cr>', 'Rename' },
        R = { '<cmd>Lspsaga project_replace<cr>', 'Replace' },
        s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
        S = { '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', 'Workspace Symbols' },
        t = { '<cmd>Lspsaga peek_type_definition<cr>', 'Peek Type Definition' },
        T = { '<cmd>Lspsaga goto_type_definition<cr>', 'Goto Type Definition' },
        w = { '<cmd>Lspsaga winbar_toggle <cr>', 'toggle winbar' },
    },
    l = {
        name = icons.ui.Package .. 'Packages',
        c = { '<cmd>Lazy check<cr>', 'Check' },
        d = { '<cmd>Lazy debug<cr>', 'Debug' },
        h = { '<cmd>Lazy<cr>', 'Plugins' },
        m = { '<cmd>Mason<cr>', 'Mason' },
        i = { '<cmd>Lazy install<cr>', 'Install' },
        l = { '<cmd>Lazy log<cr>', 'Log' },
        p = { '<cmd>Lazy profile<cr>', 'Profile' },
        r = { '<cmd>Lazy restore<cr>', 'Restore' },
        s = { '<cmd>Lazy sync<cr>', 'Sync' },
        u = { '<cmd>Lazy update<cr>', 'Update' },
        x = { '<cmd>Lazy clean<cr>', 'Clean' },
    },
    r = {
        name = icons.diagnostics.Hint .. 'Refactor',
        b = { "<cmd>lua require('spectre').open_file_search()<cr>", 'Replace Buffer' },
        e = { "<cmd>lua require('refactoring').refactor('Extract Block')<CR>", 'Extract Block' },
        f = { "<cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", 'Extract To File' },
        i = { "<cmd>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
        n = { '', 'Swap Next' },
        p = { '', 'Swap Previous' },
        r = { '', 'Smart Rename' },
        d = { '', 'Go To Definition' },
        h = { '', 'List Definition Head' },
        l = { '', 'List Definition' },
        j = { '', 'Next Usage' },
        k = { '', 'Previous Usage' },
        R = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", 'Refactor Commands' },
        S = { "<cmd>lua require('spectre').open()<cr>", 'Replace' },
        s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], 'Replace Word' },
        v = { "<cmd>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", 'Replace Word' },
    },
    t = {
        name = icons.ui.Terminal .. 'Terminal',
        ['`'] = { '<cmd>Sterm<cr>', 'Horizontal Terminal' },
        n = { '<cmd>Sterm node<cr>', 'Node' },
        p = { '<cmd>Sterm bpython<cr>', 'Python' },
        r = { '<cmd>Sterm irb<cr>', 'Ruby' },
        s = { '<cmd>Sterm<cr>', 'Horizontal Terminal' },
        t = { '<cmd>Fterm<cr>', 'Terminal' },
        v = { '<cmd>Vterm<cr>', 'Vertical Terminal' },
    },
    i = {
        name = icons.ui.Note .. 'Neorg',
    },
    T = {
        name = icons.ui.Test .. 'Test',
        f = { '<cmd>lua require("neotest").run.run(vim.fn.expand("%"))<cr>', 'Run Test' },
        F = { '<cmd>lua require("neotest").run.run()<cr>', 'Run Current Test' },
        o = { '<cmd>Neotest output-panel<cr>', 'Test Output' },
        O = { '<cmd>Neotest summary<cr>', 'Test Summary' },
    },
    w = {
        name = icons.ui.Windows .. 'Split',
        ['-'] = { '<C-w>s', 'Split Below' },
        ['|'] = { '<C-w>v', 'Split Right' },
        c = { '<cmd>tabclose<cr>', 'Close Tab' },
        d = { '<C-w>c', 'Close Window' },
        f = { '<cmd>tabfirst<cr>', 'First Tab' },
        h = { '<C-w>h', 'Move Left' },
        j = { '<C-w>j', 'Move Down' },
        k = { '<C-w>k', 'Move Up' },
        l = { '<C-w>l', 'Move Right' },
        L = { '<cmd>tablast<cr>', 'Last Tab' },
        o = { '<cmd>tabnext<cr>', 'Next Tab' },
        O = { '<cmd>tabprevious<cr>', 'Previous Tab' },
        p = { '<C-w>p', 'Previous Window' },
        q = { '<cmd>bw<cr>', 'Close Current Buf' },
        s = { '<cmd>split<cr>', 'Horizontal Split File' },
        t = { '<cmd>tabnew<cr>', 'New Tab' },
        v = { '<cmd>vsplit<cr>', 'Vertical Split File' },
        W = { "<cmd>lua require'utils'.sudo_write()<cr>", 'Force Write' },
    },
    b = {
        D = { '<cmd>bdelete!<cr>', 'force close Current Buf' },
        d = { '<cmd>bdelete<cr>', 'close Current Buf' },
        b = { '<cmd>blast<cr>', 'switch to last buffer' },
    },
    y = {
        name = icons.ui.Clipboard .. 'Yank',
        f = { '<cmd>%y+<cr>', 'Copy Whole File' },
        p = { '<cmd>CRpath<cr>', 'Copy Relative Path' },
        P = { '<cmd>CApath<cr>', 'Copy Absolute Path' },
        g = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', 'Copy Git URL' },
    },
    x = {
        name = icons.ui.Clipboard .. 'trouble',
        l = { '<cmd>lopen<cr>', 'Location List' },
        q = { '<cmd>copen<cr>', 'Quickfix List' },
    },
}

local vopts = {
    mode = 'v',
    prefix = '<leader>',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local vmappings = {
    l = {
        name = icons.ui.Gear .. 'LSP',
        a = '<cmd><C-U>Lspsaga range_code_action<CR>',
    },
    r = {
        name = icons.diagnostics.Hint .. 'Refactor',
        r = { "<Esc><cmd>lua require('telescope').extensions.refactoring.refactors()<CR>", 'Refactor Commands' },
        e = { "<esc><cmd>lua require('refactoring').refactor('Extract Function')<CR>", 'Extract Function' },
        f = { "<esc><cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", 'Extract To File' },
        v = { "<esc><cmd>lua require('refactoring').refactor('Extract Variable')<CR>", 'Extract Variable' },
        i = { "<esc><cmd>lua require('refactoring').refactor('Inline Variable')<CR>", 'Inline Variable' },
    },
    s = { "<esc><cmd>'<,'>SnipRun<cr>", icons.ui.Play .. 'Run Code' },
    q = { '<cmd>q<cr>', icons.ui.Close .. 'Quit' },
    Q = { '<cmd>qa!<cr>', icons.ui.Power .. 'Force Quit!' },
    x = { '<cmd>x<cr>', icons.ui.Pencil .. 'Write and Quit' },
    y = {
        name = icons.ui.Clipboard .. 'Yank',
        g = { '<cmd>lua require"gitlinker".get_buf_range_url()<cr>', 'Copy Git URL' },
    },
}

local no_leader_opts = {
    mode = 'n',
    prefix = '',
    buffer = nil,
    silent = true,
    noremap = true,
    nowait = true,
}

local no_leader_mappings = {
    -- ['<S-h>'] = { '<cmd>bprevious<cr>', 'Previous Buffer' },
    -- ['<S-l>'] = { '<cmd>bnext<cr>', 'Next Buffer' },

    -- ['<C-f>'] = { '<cmd>Telescope find_files<cr>', 'Find Files' },
    -- ['<C-g>'] = { '<cmd>Fterm lazygit<cr>', 'Lazygit' },

    ['['] = {
        name = icons.ui.ArrowLeft .. 'Previous',
        b = { '<cmd>bprevious<cr>', 'Previous Buffer' },
        B = { '<cmd>bfirst<cr>', 'First Buffer' },
        e = { 'g;', 'Previous Edit' },
        j = { '<C-o>', 'Previous Jump' },
        h = { '<cmd>lua require("harpoon.ui").nav_prev()<cr>', 'Prev Harpoon' },
    },
    [']'] = {
        name = icons.ui.ArrowRight .. 'Next',
        b = { '<cmd>bnext<cr>', 'Next Buffer' },
        B = { '<cmd>blast<cr>', 'Last Buffer' },
        e = { 'g,', 'Next Edit' },
        j = { '<C-i>', 'Next Jump' },
        h = { '<cmd>lua require("harpoon.ui").nav_next()<cr>', 'Next Harpoon' },
    },

    ['#'] = { '<cmd>edit #<cr>', 'Alternate Buffer' },
    K = { '<cmd>silent Lspsaga hover_doc<cr>', 'LSP saga Hover', silent = true }, -- added in keymaps folder
    U = { '<cmd>redo<cr>', 'Redo' },
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
which_key.register(no_leader_mappings, no_leader_opts)
which_key.register({ mode = { 'o', 'x' }, i = i, a = a })
