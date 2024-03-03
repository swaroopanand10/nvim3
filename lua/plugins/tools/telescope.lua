local M = {}
local function is_git_repo()
    vim.fn.system('git rev-parse --is-inside-work-tree')

    return vim.v.shell_error == 0
end

local function get_git_root()
    local dot_git_path = vim.fn.finddir('.git', '.;')
    return vim.fn.fnamemodify(dot_git_path, ':h')
end

local config = function()
    local status_ok, telescope = pcall(require, 'telescope')
    if not status_ok then
        return
    end

    local actions = require('telescope.actions')
    local multi_open_mappings = require('plugins.tools.telescope-multiopen')
    local icons = require('lib.icons')

    local function flash(prompt_bufnr)
        require('flash').jump({
            pattern = '^',
            label = { after = { 0, 0 } },
            search = {
                mode = 'search',
                exclude = {
                    function(win)
                        return vim.bo[vim.api.nvim_win_get_buf(win)].filetype ~= 'TelescopeResults'
                    end,
                },
            },
            action = function(match)
                local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                picker:set_selection(match.pos[1] - 1)
            end,
        })
    end
    local open_with_trouble = function(...)
        return require('trouble.providers.telescope').open_with_trouble(...)
    end
    local open_selected_with_trouble = function(...)
        return require('trouble.providers.telescope').open_selected_with_trouble(...)
    end
    telescope.setup({
        defaults = {
            layout_config = {
                height = 0.8,
                width = 0.9,
                prompt_position = 'top',
                bottom_pane = {
                    height = 0.5,
                    preview_width = 0.6,
                    preview_cutoff = 120,
                },
                center = {
                    height = 0.4,
                    preview_cutoff = 40,
                },
                cursor = {
                    preview_cutoff = 40,
                    preview_width = 0.6,
                },
                horizontal = {
                    preview_width = 0.6,
                    preview_cutoff = 120,
                },
                vertical = {
                    preview_cutoff = 40,
                },
            },
            prompt_prefix = icons.ui.Telescope .. icons.ui.ChevronRight,
            selection_caret = icons.ui.Play,
            multi_icon = icons.ui.Check,
            path_display = { 'smart' },
            sorting_strategy = 'ascending',

            mappings = {
                i = {
                    ['<C-j>'] = actions.move_selection_next,
                    ['<C-k>'] = actions.move_selection_previous,
                    ['<C-n>'] = actions.cycle_history_next,
                    ['<C-p>'] = actions.cycle_history_prev,
                    ['<C-u>'] = actions.preview_scrolling_up,
                    ['<C-d>'] = actions.preview_scrolling_down,
                    ['<C-f>'] = actions.preview_scrolling_right,
                    ['<C-b>'] = actions.preview_scrolling_left,
                    ['<M-j>'] = actions.results_scrolling_left,
                    ['<M-k>'] = actions.results_scrolling_right,
                    ['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
                    ['<C-g>'] = actions.send_selected_to_qflist + actions.open_qflist,
                    ['<C-t>'] = open_with_trouble,
                    ['<A-t>'] = open_selected_with_trouble,
                    ['<C-q>'] = false,
                    ['<M-q>'] = false,
                    ['<A-d>'] = actions.delete_buffer,
                    ['<esc>'] = actions.close,
                    ['<C-c>'] = actions.close,
                    ['<Down>'] = actions.move_selection_next,
                    ['<Up>'] = actions.move_selection_previous,
                    ['<CR>'] = actions.select_default,
                    ['<C-x>'] = actions.select_horizontal,
                    ['<C-v>'] = actions.select_vertical,
                    ['<C-s>'] = flash,
                    ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                    ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                    ['<C-l>'] = actions.complete_tag,
                },

                n = {
                    ['q'] = actions.close,
                    ['<C-u>'] = actions.preview_scrolling_up,
                    ['<C-d>'] = actions.preview_scrolling_down,
                    ['<C-f>'] = actions.preview_scrolling_left,
                    ['<C-b>'] = actions.preview_scrolling_right,
                    ['<M-j>'] = actions.results_scrolling_left,
                    ['<M-k>'] = actions.results_scrolling_right,
                    ['<C-a>'] = actions.send_to_qflist + actions.open_qflist,
                    ['<C-g>'] = actions.send_selected_to_qflist + actions.open_qflist,
                    ['<C-t>'] = open_with_trouble,
                    ['<A-t>'] = open_selected_with_trouble,
                    ['<C-q>'] = false,
                    ['<M-q>'] = false,
                    ['<A-d>'] = actions.delete_buffer,
                    ['<esc>'] = actions.close,
                    ['<CR>'] = actions.select_default,
                    ['<C-x>'] = actions.select_horizontal,
                    ['<C-v>'] = actions.select_vertical,
                    ['s'] = flash,
                    ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                    ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                    ['j'] = actions.move_selection_next,
                    ['k'] = actions.move_selection_previous,
                    ['H'] = actions.move_to_top,
                    ['M'] = actions.move_to_middle,
                    ['L'] = actions.move_to_bottom,
                    ['gg'] = actions.move_to_top,
                    ['G'] = actions.move_to_bottom,
                    ['?'] = actions.which_key,
                },
            },
        },
        pickers = {
            find_files = { mappings = multi_open_mappings },
            git_files = { mappings = multi_open_mappings },
            oldfiles = { mappings = multi_open_mappings },
        },
        extensions = {
            fzf = {
                fuzzy = true,
                override_generic_sorter = true,
                override_file_sorter = true,
                case_mode = 'smart_case',
            },
            undo = {
                use_delta = true,
                use_custom_command = nil,
                side_by_side = true,
                diff_context_lines = vim.o.scrolloff,
                entry_format = 'state #$ID, $STAT, $TIME',
                -- time_format = '%d %b %H:%M',
                mappings = {
                    i = {
                        ['<S-cr>'] = require('telescope-undo.actions').yank_additions,
                        ['<C-cr>'] = require('telescope-undo.actions').yank_deletions,
                        ['<cr>'] = require('telescope-undo.actions').restore,
                    },
                },
            },
            menufacture = { mappings = { main_menu = { [{ 'i', 'n' }] = '<C-e>' } } },
        },
    })

    require('telescope').load_extension('fzf')
    require('telescope').load_extension('menufacture')
    require('telescope').load_extension('undo')
    require('telescope').load_extension('harpoon')
    require('telescope').load_extension('notify')
    require('telescope').load_extension('refactoring')
end
local keys = {
    {
        '<leader>j.',
        '<cmd>lua require("telescope").extensions.menufacture.find_files({cwd = "~/dotstow", hidden = true})<cr>',
        desc = 'all files in dotstow dir',
    },

    {
        '<leader>jk',
        function()
            require('telescope.builtin').find_files({ cwd = require('telescope.utils').buffer_dir() })
        end,
        desc = 'find files(normal) directory of current file',
    },
    {
        '<leader>jK',
        function()
            require('telescope.builtin').find_files({ cwd = require('telescope.utils').buffer_dir(), hidden = true })
        end,
        desc = 'find files(normal) directory of current file',
    },
    {
        '<leader>fb',
        '<cmd>Telescope buffers<cr>',
        desc = 'Buffers',
    },
    {
        '<leader>.',
        '<cmd>Telescope buffers<cr>',
        desc = 'Buffers',
    },
    {
        '<leader>fB',
        '<cmd>Telescope git_branches<cr>',
        desc = 'Checkout branch',
    },
    {
        '<leader>fa',
        '<cmd>lua require("telescope").extensions.menufacture.find_files()<cr>',
        desc = 'normal Files in cwd',
    },
    {
        '<leader>fA',
        '<cmd>lua require("telescope").extensions.menufacture.find_files({hidden = true})<cr>',
        desc = 'All Files in cwd',
    },
    {
        '<leader>fc',
        '<cmd>Telescope git_bcommits<cr>',
        desc = 'File Commits',
    },
    {
        '<leader>fC',
        '<cmd>Telescope git_commits<cr>',
        desc = 'Git Commits',
    },
    {
        '<leader>fe',
        '<cmd>Oil<cr>',
        desc = 'Dir Editor',
    },
    {
        '<leader>ff',
        '<cmd>lua require("telescope").extensions.menufacture.git_files()<cr>',
        desc = 'Find files(git)',
    },
    {
        '<leader><space>',
        '<cmd>lua require("telescope").extensions.menufacture.git_files()<cr>',
        desc = 'Find files(git)',
    },
    {
        '<leader>fH',
        '<cmd>Telescope help_tags<cr>',
        desc = 'Help',
    },
    {
        '<leader>fh',
        '<cmd>Telescope man_pages<cr>',
        desc = 'Man Pages',
    },
    {
        '<leader>fr',
        '<cmd>Telescope oldfiles<cr>',
        desc = 'Recent Files',
    },
    {
        '<leader>fp',
        '<cmd>Telescope<cr>',
        desc = 'Panel',
    },
    {
        '<leader>f"',
        '<cmd>Telescope registers<cr>',
        desc = 'Registers',
    },
    {
        '<leader>f.',
        '<cmd>Telescope symbols<cr>',
        desc = 'Emojis',
    },
    {
        '<leader>f,',
        '<cmd>Nerdy<cr>',
        desc = 'Nerd Glyphs',
    },
    {
        '<leader>sb',
        '<cmd>Telescope current_buffer_fuzzy_find<cr>',
        desc = 'Checkout branch',
    },
    {
        '<leader>/',
        '<cmd>Telescope current_buffer_fuzzy_find<cr>',
        desc = 'Checkout branch',
    },
    {
        '<leader>sG',
        '<cmd>lua require("telescope").extensions.menufacture.live_grep()<cr>',
        desc = 'live grep in cwd',
    },
    {
        '<leader>sg',
        function()
            local opts = {}

            if is_git_repo() then
                opts = {
                    cwd = get_git_root(),
                    -- word_match = '-w',
                }
            end

            -- require('telescope.builtin').live_grep(opts)
            require('telescope').extensions.menufacture.live_grep(opts)
        end,
        desc = 'live grep in .git',
    },
    {
        '<leader>,',
        function()
            local opts = {}

            if is_git_repo() then
                opts = {
                    cwd = get_git_root(),
                    -- word_match = '-w',
                }
            end

            -- require('telescope.builtin').live_grep(opts)
            require('telescope').extensions.menufacture.live_grep(opts)
        end,
        desc = 'live grep in .git',
    },
    {
        '<leader>sW',
        '<cmd>lua require("telescope").extensions.menufacture.grep_string({ word_match = "-w" })<cr>',
        desc = 'grep string in cwd',
    },
    {
        '<leader>sw',
        function()
            local opts = {}

            if is_git_repo() then
                opts = {
                    cwd = get_git_root(),
                    -- word_match = '-w',
                }
            end

            -- require('telescope.builtin').grep_string(opts)
            require('telescope').extensions.menufacture.grep_string(opts)
        end,
        desc = 'grep string in .git',
    },
    {
        '<leader>sC',
        '<cmd>Telescope commands<cr>',
        desc = 'Commands',
    },
    {
        '<leader>sc',
        '<cmd>Telescope command_history<cr>',
        desc = 'Command_history',
    },
    {
        '<leader>sd',
        '<cmd>Telescope diagnostics bufnr=0<cr>',
        desc = 'buffer diagnostics',
    },
    {
        '<leader>sD',
        '<cmd>Telescope diagnostics<cr>',
        desc = 'Workspace diagnostics',
    },
    {
        '<leader>sK',
        '<cmd>Telescope keymaps<cr>',
        desc = 'Keymaps',
    },
    {
        '<leader>sR',
        '<cmd>Telescope resume<cr>',
        desc = 'Last Search',
    },
    {
        '<leader>sL',
        '<cmd>Telescope loclist<cr>',
        desc = 'Location List',
    },
    {
        '<leader>sp',
        '<cmd>Telescope<cr>',
        desc = 'Panel',
    },
    {
        '<leader>sq',
        '<cmd>Telescope quickfix<cr>',
        desc = 'Quickfix',
    },
    {
        '<leader>ss',
        '<cmd>Telescope live_grep grep_open_files=true<cr>',
        desc = 'Find in Open Files',
    },
    {
        '<leader>su',
        '<cmd>Telescope undo<cr>',
        desc = 'Undo History',
    },
    {
        '<leader>s"',
        '<cmd>Telescope registers<cr>',
        desc = 'Registers',
    },
    {
        '<leader>sS',
        '<cmd>Telescope symbols<cr>',
        desc = 'Emojis',
    },
    {
        '<leader>sm',
        '<cmd>Telescope marks<cr>',
        desc = 'marks',
    },
    {
        '<leader>s,',
        '<cmd>Nerdy<cr>',
        desc = 'Nerd Glyphs',
    },
    {
        '<leader>uR',
        '<cmd>Telescope reloader<cr>',
        desc = 'Reload Module',
    },
    {
        '<leader>jd',
        '<cmd>cd %:p:h<cr>',
        desc = 'Change Directory',
    },
}
M.keys = keys
M.config = config
return M
