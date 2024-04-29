local options = {
    ai = true,
    autoindent = true,
    autowrite = true,
    backspace = 'indent,eol,start',
    backup = false, -- creates a backup file
    breakindent = true,
    showbreak = string.rep(' ', 3),
    linebreak = true, -- make it so that long lines break smartly
    clipboard = 'unnamedplus', -- allows neovim to access the system clipboard
    cmdheight = 0, -- more space in the neovim command line for displaying messages
    completeopt = 'menu,menuone,noselect', -- mostly just for cmp
    conceallevel = 0, -- so that `` is visible in markdown files
    confirm = true, -- Confirm to save changes before exiting modified buffer
    -- cursorline = true, -- highlight the current line
    expandtab = true, -- convert tabs to spaces
    fileencoding = 'utf-8', -- the encoding written to a file
    formatoptions = 'jcroqlnt', -- tcqj
    grepformat = '%f:%l:%c:%m',
    grepprg = 'rg --vimgrep',
    hlsearch = true, -- highlight all matches on previous search pattern
    ignorecase = true, -- ignore case in search patterns
    inccommand = 'split', -- preview incremental substitute
    laststatus = 3,
    list = false, -- disabling this removes arrows in place tab
    -- listchars = { trail = '', tab = '', nbsp = '_', extends = '>', precedes = '<' }, -- highlight
    -- listchars = { trail = '', nbsp = '_', tab= '  ' }, -- highlight
    mouse = 'a', -- allow the mouse to be used in neovim
    number = false, -- set numbered lines
    numberwidth = 4, -- set number column width to 2 {default 4}
    pumblend = 10, -- Popup blen
    pumheight = 10, -- pop up menu height
    relativenumber = false, -- set relative numbered lines
    scrolloff = 4, -- will keep atleast 4 line above and below the cursorline
    sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal',
    shiftround = true, -- Round indent
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    showcmd = false,
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 1, -- always show tabs
    si = true,
    sidescrolloff = 8,
    smartcase = true, -- smart case
    smartindent = true, -- make indenting smarter again
    smarttab = true,
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = false, -- creates a swapfile
    tabstop = 2, -- insert 2 spaces for a tab
    termguicolors = true, -- set term gui colors (most terminals support this)
    timeoutlen = 70, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 10,
    undofile = true, -- enable persistent undo
    undolevels = 10000,
    updatetime = 50, -- faster completion (4000ms default)
    -- statuscolumn = '%=%{v:relnum?v:relnum:v:lnum} %s',
    signcolumn = 'yes:3',
    -- wildmenu = true, -- wildmenu
    -- wildmode = 'longest:full,full', -- Command-line completion mode
    winminwidth = 5, -- Minimum window width
    wrap = false, -- display lines as one long line
    writebackup = false, -- do not edit backups
    guicursor = 'n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor,a:blinkon100',
}

-- vim.cmd([[
--      setlocal spell spelllang=en "Set spellcheck language to en
--      setlocal spell! "Disable spell checks by default
--      filetype plugin indent on
--      if has('win32')
--         let g:python3_host_prog = $HOME . '/scoop/apps/python/current/python.exe'
--      endif
--  ]])

vim.opt.path:append({ '**' })

-- Undercurl
-- vim.cmd([[let &t_Cs = "\e[4:3m"]])
-- vim.cmd([[let &t_Ce = "\e[4:0m"]])

vim.opt.shortmess:append({ W = true, I = true, c = true })

-- if vim.fn.has('nvim-0.9.0') == 1 then
--     vim.opt.splitkeep = 'screen'
--     vim.opt.shortmess:append({ C = true })
-- end

-- Fix markdown indentation settings
-- vim.g.markdown_recommended_style = 0

for k, v in pairs(options) do
    vim.opt[k] = v
end

-- vim.cmd('set whichwrap+=<,>,[,],h,l')
-- vim.cmd([[set iskeyword+=-]])
