local status_ok, rosepine = pcall(require, 'rose-pine')
if not status_ok then
    return
end

rosepine.setup({
    groups = {
        error = '#ff0000',
        hint = '#ff966c',
    },
    variant = 'moon', -- auto, main, moon, or dawn
    dark_variant = 'moon', -- main, moon, or dawn
    styles = {
        bold = true,
        italic = true,
        transparency = true,
    },
    highlight_groups = {
        -- Comment = { fg = "foam" },
        -- VertSplit = { fg = "muted", bg = "muted" },
        StatusLine = {
            bg = '#000000',
            fg = '#000000',
        },
        StatusLineNC = {
            bg = '#000000',
            fg = '#000000',
        },
        TreesitterContextBottom = {
            underline = true,
        },
        FlashBackdrop = { fg = '#545c7e' },
        FlashLabel = {
            bg = '#ff007c',
            bold = true,
            fg = '#ffffff',
            -- fg = "#000000",
        },
        Cursor = { -- setting cursor colors(only work if vim.o.guicursor will be set in options)
            bg = '#F92660',
        },

        NotifyBackground = {
            -- fg = c.fg,
            bg = '#000000',
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
-- rosepine.load()
vim.cmd("colorscheme rose-pine")

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
