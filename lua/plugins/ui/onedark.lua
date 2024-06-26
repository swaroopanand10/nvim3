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
        DiagnosticWarn = {
            fg = '#ff966c',
        },
        DiagnosticError = {
            fg = '#ff0000',
        },
        DiagnosticVirtualTextWarn = {
            fg = '#ff966c',
        },
        PmenuSel = {
            fg = '#e0def4',
            bg = '#393552',
        },
        -- Comment = {
        --     fg = '#908CAA',
        --     bg = '#000000',
        -- },
        -- TSComment = {
        --     fg = '#908CAA',
        --     bg = '#000000',
        -- },
        ['@comment'] = {
            fg = '#908CAA',
            bg = '#000000',
        },
        ['@lsp.type.comment'] = {
            fg = '#908CAA',
            bg = '#000000',
        },
        ['@variable'] = {
            fg = '#E0DEF4',
            -- fg = '#ffffff',
        },
        ['@lsp.type.variable'] = {
            fg = '#E0DEF4',
            -- fg = '#ffffff',
        },
        -- looked fine before it
        -- DiagnosticVirtualTextError = {
        --     fg = '#ff0000',
        -- },
    },
})
onedark.load()

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Cursor', { bg = '#F92660' })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#c4a7e7"})
-- vim.api.nvim_set_hl(0, "@comment", { link = "Comment"})
