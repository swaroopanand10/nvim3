local M = {}
local config = function()
    local opts = {
        mappings = {
            go_in = 'L',
            go_in_plus = '<cr>',
            go_out = 'H',
            go_out_plus = 'K',
            -- synchronize = "<cr>",
        },
        windows = {
            preview = true,
            width_focus = 30,
            width_preview = 30,
        },
        options = {
            -- Whether to use for editing directories
            -- Disabled by default in LazyVim because neo-tree is used for that
            use_as_default_explorer = false,
        },
    }
    require('mini.files').setup(opts)

    local show_dotfiles = true
    local filter_show = function(fs_entry)
        return true
    end
    local filter_hide = function(fs_entry)
        return not vim.startswith(fs_entry.name, '.')
    end

    local toggle_dotfiles = function()
        show_dotfiles = not show_dotfiles
        local new_filter = show_dotfiles and filter_show or filter_hide
        require('mini.files').refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak left-hand side of mapping to your liking
            vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id })
        end,
    })

    -- vim.api.nvim_create_autocmd('User', {
    --     pattern = 'MiniFilesActionRename',
    --     callback = function(event)
    --         require('lazyvim.util').lsp.on_rename(event.data.from, event.data.to)
    --     end,
    -- })

    -- adding features in mini.files to open files in desirabe splits and selected window
    local map_split = function(buf_id, lhs, direction)
        local rhs = function()
            -- Make new window and set it as target
            local new_target_window
            local windowid = require('window-picker').pick_window()
            -- vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
            vim.api.nvim_win_call(windowid, function()
                vim.cmd(direction .. ' split')
                new_target_window = vim.api.nvim_get_current_win()
            end)

            MiniFiles.set_target_window(new_target_window)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'Split ' .. direction
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    local map_select_window = function(buf_id, lhs)
        local rhs = function()
            -- Make new window and set it as target
            local new_target_window
            local windowid = require('window-picker').pick_window()
            -- vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
            vim.api.nvim_win_call(windowid, function()
                new_target_window = vim.api.nvim_get_current_win()
            end)

            MiniFiles.set_target_window(new_target_window)
        end

        -- Adding `desc` will result into `show_help` entries
        local desc = 'open in selected window'
        vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
    end

    vim.api.nvim_create_autocmd('User', {
        pattern = 'MiniFilesBufferCreate',
        callback = function(args)
            local buf_id = args.data.buf_id
            -- Tweak keys to your liking
            map_split(buf_id, '<S-s>', 'belowright horizontal')
            map_split(buf_id, '<C-s>', 'belowright vertical')
            map_select_window(buf_id, '<C-w>')
        end,
    })
end
local keys = {
    {
        '<leader>fm',
        function()
            require('mini.files').open(vim.api.nvim_buf_get_name(0), true)
        end,
        desc = 'Open mini.files (directory of current file)',
    },
    {
        '<leader>fM',
        function()
            require('mini.files').open(vim.loop.cwd(), true)
        end,
        desc = 'Open mini.files (cwd)',
    },
}
M.config = config
M.keys = keys
return M
