local status_ok, cmp = pcall(require, 'cmp')
if not status_ok then
    return
end

local snip_status_ok, luasnip = pcall(require, 'luasnip')
if not snip_status_ok then
    return
end

require('luasnip/loaders/from_vscode').lazy_load()

-- Loading custom plugins here
require('luasnip.loaders.from_vscode').lazy_load({
    paths = vim.fn.stdpath('config') .. '/snippets',
})

local compare = require('cmp.config.compare')

local icons = require('lib.icons')
local kind_icons = icons.kind
vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })

cmp.setup({
    completion = {
        completeopt = 'menu,menuone,noinsert',
    },
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    -- mapping = {
    --     ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    --     ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    --     ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    --     ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
    --     ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
    --     ['<C-b>'] = cmp.mapping.scroll_docs(-2), -- don't know why but adding this makes the c-n and c-p work properly
    --     ['<C-f>'] = cmp.mapping.scroll_docs(2),
    --     ['<C-y>'] = cmp.config.disable,
    --     ['<C-c>'] = cmp.mapping({
    --         i = cmp.mapping.abort(),
    --         c = cmp.mapping.close(),
    --     }),
    --     ['<CR>'] = cmp.mapping.confirm({
    --         select = true,
    --     }),
    --     ['<S-CR>'] = cmp.mapping.confirm({
    --         behavior = cmp.ConfirmBehavior.Replace,
    --         select = true,
    --     }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    --     ['<Tab>'] = cmp.mapping(function(fallback)
    --         if luasnip.expandable() then
    --             luasnip.expand()
    --         elseif luasnip.expand_or_jumpable() then
    --             luasnip.expand_or_jump()
    --         else
    --             fallback()
    --         end
    --     end, {
    --         'i',
    --         's',
    --     }),
    --     ['<S-Tab>'] = cmp.mapping(function(fallback)
    --         if luasnip.jumpable(-1) then
    --             luasnip.jump(-1)
    --         else
    --             fallback()
    --         end
    --     end, {
    --         'i',
    --         's',
    --     }),
    -- },
    mapping = cmp.mapping.preset.insert({ -- this is working correctly in all cases
        ['<C-j>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-k>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping(cmp.mapping.scroll_docs(-3), { 'i', 'c' }),
        ['<C-n>'] = cmp.mapping(cmp.mapping.scroll_docs(3), { 'i', 'c' }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item in this case.
        ['<S-CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-CR>'] = function(fallback)
            cmp.abort()
            fallback()
        end,

        -- tab support only for snippets,
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expandable() then
                luasnip.expand()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {
            'i',
            's',
        }),
    }),

    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        expandable_indicator = true,
        format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = kind_icons[vim_item.kind]

            if entry.source.name == 'copilot' then
                vim_item.kind = icons.git.Octoface
                vim_item.kind_hl_group = 'CmpItemKindCopilot'
            end

            vim_item.menu = ({
                nvim_lsp = '[LSP]',
                luasnip = '[Snippet]',
                buffer = '[Buffer]',
                path = '[Path]',
                neorg = '[neorg]',
            })[entry.source.name]
            return vim_item
        end,
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'luasnip' },
        { name = 'path' },
        { name = 'nvim_lua' },
        { name = 'neorg' },
    },
    sorting = {
        priority_weight = 2,
        comparators = {
            -- require("copilot_cmp.comparators").prioritize,
            -- require("copilot_cmp.comparators").score,
            compare.offset,
            compare.exact,
            -- compare.scopes,
            compare.score,
            compare.recently_used,
            compare.locality,
            -- compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            -- require("copilot_cmp.comparators").prioritize,
            -- require("copilot_cmp.comparators").score,
        },
    },
    confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
    },
    window = {
        documentation = {
            border = 'rounded',
            winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
        },
        completion = {
            border = 'rounded',
            winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
        },
        scrollbar = true,
    },
    experimental = {
        ghost_text = true,
    },
})
