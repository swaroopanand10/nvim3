require('coal').setup({
    colors = {
        smoky_black = '#000000',
    },
})
-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })

-- some other customizatios
-- vim.api.nvim_set_hl(0, 'Cursor', { fg = 'none', bg = '#ff007c' })
-- vim.api.nvim_set_hl(0, 'Cursor', { fg = 'none', bg = '#52B0EF' })
vim.api.nvim_set_hl(0, 'TreesitterContextBottom', { underline = true })
-- vim.api.nvim_set_hl(0, 'LSPInlayHint', { fg = '#6D6985', bg = '#2B283E' }) -- rosepine
-- vim.api.nvim_set_hl(0, 'LSPInlayHint', { fg = '#545C7E', bg = '#1D202D' }) -- tokyonight
-- vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#F65866', bg = '#455574', bold = true })
-- vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#E06C75', bg = 'none', bold = true })
-- vim.api.nvim_set_hl(0, 'MatchParen', { fg = '#FF9E64', bg = '#455574', bold = true }) --tokyonight
-- vim.api.nvim_set_hl(0, 'Visual', { fg = '#ffffff', bg = '#3E68D7' })
vim.api.nvim_set_hl(0, 'Visual', { fg = '#ffffff', bg = '#455574' })
