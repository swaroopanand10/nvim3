local M = {}

local keys = {
    {
        '<leader>-',
        function()
            require('yazi').yazi()
        end,
        desc = 'Open the file manager',
    },
    {
        -- Open in the current working directory
        '<leader>jl',
        function()
            require('yazi').yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open the file manager in nvim's working directory",
    },
}

local config = function()
    require('yazi').setup({
        -- enable this if you want to open yazi instead of netrw.
        -- Note that if you enable this, you need to call yazi.setup() to
        -- initialize the plugin. lazy.nvim does this for you in certain cases.
        open_for_directories = false,
    })
end

M.keys = keys
M.config = config
return M
