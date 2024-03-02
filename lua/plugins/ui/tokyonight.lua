local status_ok, tokyonight = pcall(require, 'tokyonight')
if not status_ok then
    return
end

tokyonight.setup({
      -- style = "night",
      transparent = true, -- Enable this to disable setting the background color
      styles = {
        -- Normal = { guibg = "#ffffff" }, -- not working
        sidebars = "transparent",
        floats = "transparent",
      },
      lualine_bold = true,
      on_colors = function(colors)
        colors.hint = colors.orange
        colors.error = "#ff0000"
        colors.bg_dark = "#000000"
        colors.bg = "#000000"
        colors.bg_float = "#000000"
        colors.bg_highlight = "#000101"
        -- colors.bg_highlight = "#0C090A"
        -- colors.bg_highlight = "#313955" --from treesitter-context
        colors.bg_popup = "#000000"
        colors.bg_sidebar = "#000000"
        colors.bg_statusline = "#000000"
      end,
      on_highlights = function(hl, c)
        local dark = "#000101"
        local visualdark = "#2d3f76"
        local red = "#ff0000"
        local red1 = "#F92660"
        local black = "#000000"
        local blue = "#52b0ef"
        local purple = "#fca7ea"
        hl.TreesitterContext = {
          -- bg = visualdark,
          bg = dark,
        }
        hl.TreesitterContextBottom = {
          underline = true,
          bold = true,
          -- sp = purple,
          sp = "#65BCFF", -- color of indent-blankline copied from hyprland -color-picker
        }
        hl.Cursor = { -- setting cursor colors(only work if vim.o.guicursor will be set in options)
          bg = red1,
          -- bg = blue,
          -- fg = red1,
        }
        hl.FlashBackdrop = { fg = "#545c7e" }
        hl.FlashLabel = {
          bg = "#ff007c",
          bold = true,
          fg = "#ffffff",
          -- fg = "#000000",
        }

        -- editing status line colors, will only work if lualine is disabled
        -- hl.StatusLine = {
        --   bg = black,
        --   fg = black,
        -- }
        -- hl.StatusLineNC = {
        --   bg = black,
        --   fg = black,
        -- }
      end,
})
tokyonight.load()

-- transparent background
vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'Pmenu', { bg = 'none' })
