local status_ok, onedark = pcall(require, 'onedark')
if not status_ok then
    return
end

onedark.setup({
    style = 'deep',
    transparent = true,
    term_colors = false,
    ending_tildes = false,
    cmp_itemkind_reverse = false,

    toggle_style_key = '<leader>ct',
    toggle_style_list = { 'dark', 'darker', 'cool', 'warm', 'warmer', 'deep', 'light' },

    -- Options are italic, bold, underline, none and combos 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'italic',
        -- functions = 'italic,bold',
        strings = 'none',
        variables = 'italic',
    },

    lualine = { transparent = true },
    diagnostics = { darker = true, undercurl = true, background = false },
    highlights = {
        -- TSFunction = { fg = '#0000ff', sp = '$cyan', fmt = 'underline,italic' },
        FlashBackdrop = { fg = '#545c7e' },
        FlashLabel = {
            bg = '#ff007c',
            fmt = 'bold',
            fg = '#ffffff',
            -- fg = "#000000",
        },
        Cursor = { -- setting cursor colors(only work if vim.o.guicursor will be set in options)
            bg = '#F92660',
        },

        StatusLine = {
            bg = '#000000',
            fg = '#000000',
        },

        StatusLineNC = {
            bg = '#000000',
            fg = '#000000',
        },
        TreesitterContextBottom = {
            fmt = 'underline',
        },
        CursorLine = {
            bg = '#000000',
        },
        FlashMatch = {
            bg = '#000000',
            fg = '#ffffff',
        },
        Search = {
            bg = '#3E68D7',
            fg = '#c8d3f5',
        },
    },
})
onedark.load()

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Cursor', { bg = '#F92660' })
