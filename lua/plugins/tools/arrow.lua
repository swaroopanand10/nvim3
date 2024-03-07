local M = {}
local config = function()
    require('arrow').setup({
        show_icons = true,
        always_show_path = false,
        separate_by_branch = false, -- Bookmarks will be separated by git branch
        hide_handbook = false, -- set to true to hide the shortcuts on menu.
        save_path = function()
            return vim.fn.stdpath('cache') .. '/arrow'
        end,
        mappings = {
            edit = 'e',
            delete_mode = 'D',
            clear_all_items = 'C',
            toggle = 'w', -- used as save if separate_save_and_remove is true
            open_vertical = 'v',
            open_horizontal = '-',
            quit = 'q',
            remove = 'x', -- only used if separate_save_and_remove is true
        },
        -- custom_actions = {
        --     open = function(target_file_name, current_file_name) end, -- target_file_name = file selected to be open, current_file_name = filename from where this was called
        --     split_vertical = function(target_file_name, current_file_name) end,
        --     split_horizontal = function(target_file_name, current_file_name) end,
        -- },
        window = { -- controls the appearance and position of an arrow window (see nvim_open_win() for all options)
            width = 'auto',
            height = 'auto',
            row = 'auto',
            col = 'auto',
            border = 'double',
        },
        separate_save_and_remove = true, -- if true, will remove the toggle and create the save/remove keymaps.
        leader_key = ';',
        global_bookmarks = false, -- if true, arrow will save files globally (ignores separate_by_branch)
        -- index_keys = '123456789zxcbnmZXVBNM,afghjklAFGHJKLwrtyuiopWRTYUIOP', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
        index_keys = 'asdfghjkl;123456789zruio', -- keys mapped to bookmark index, i.e. 1st bookmark will be accessible by 1, and 12th - by c
        full_path_list = { 'update_stuff' }, -- filenames on this list will ALWAYS show the file path too.
    })
end
local keys = {
    {
        ';',
        -- function()
        --     -- print("hello")
        -- end,
        desc = 'arrow nvim',
    },
}
M.config = config
M.keys = keys
return M
