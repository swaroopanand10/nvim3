local status_ok, lsp_zero = pcall(require, 'lsp-zero')
if not status_ok then
    return
end

lsp_zero.extend_lspconfig()
lsp_zero.on_attach(function(client, bufnr)
    -- lsp_zero.default_keymaps({ buffer = bufnr })
    lsp_zero.default_keymaps({ buffer = bufnr, exclude = { 'gl', 'K' } })
end)

local auto_install = require('lib.util').get_user_config('auto_install', true)
local installed_servers = {}
if auto_install then
    installed_servers = require('plugins.list').lsp_servers
end

local cmp_nvim_lsp = require('cmp_nvim_lsp')

require('lspconfig').clangd.setup({
    -- on_attach = on_attach,
    on_attach = function(client, bufnr)
        print('hello clangd')
    end,
    capabilities = cmp_nvim_lsp.default_capabilities(),
    cmd = {
        'clangd',
        '--offset-encoding=utf-16',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=iwyu',
        '--completion-style=detailed',
        '--function-arg-placeholders',
        '--fallback-style=llvm',
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    root_dir = function(fname)
        return require('lspconfig.util').root_pattern(
            'Makefile',
            'configure.ac',
            'configure.in',
            'config.h.in',
            'meson.build',
            'meson_options.txt',
            'build.ninja'
        )(fname) or require('lspconfig.util').root_pattern('compile_commands.json', 'compile_flags.txt')(fname) or
        require(
            'lspconfig.util'
        ).find_git_ancestor(fname)
    end,
    setup = {
        clangd = function(_, opts)
            local clangd_ext_opts = require('lazyvim.util').opts('clangd_extensions.nvim')
            require('clangd_extensions').setup(vim.tbl_deep_extend('force', clangd_ext_opts or {}, { server = opts }))
            return false
        end,
    },
})

-- require('lspconfig').inlay_hints.enabled = true

-- vim.lsp.handlers['textDocument/hover'] = function(_, result, ctx, config)
--     config = config or {}
--     config.focus_id = ctx.method
--     if not (result and result.contents) then
--         return
--     end
--     local markdown_lines = vim.lsp.util.convert_input_to_markdown_lines(result.contents)
--     markdown_lines = vim.lsp.util.trim_empty_lines(markdown_lines)
--     if vim.tbl_isempty(markdown_lines) then
--         return
--     end
--     return vim.lsp.util.open_floating_preview(markdown_lines, 'markdown', config)
-- end

require('mason').setup({})
require('mason-lspconfig').setup({
    ensure_installed = installed_servers,
    handlers = {
        -- This option does automatic setup for every lsp server mentioned in 'ensure_installed' with default setup.
        lsp_zero.default_setup,

        -- But if we want a custom configuration for a server, then we can do it explicitly like this

        -- Lua
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            local custom_options = {
                enable = true,
                defaultConfig = {
                    align_continuous_assign_statement = false,
                    align_continuous_rect_table_field = false,
                    align_array_table = false,
                },
            }
            lua_opts.settings.Lua.format = custom_options
            require('lspconfig').lua_ls.setup(lua_opts)
        end,

        -- tsserver
        tsserver = function()
            require('lspconfig').tsserver.setup({
                single_file_support = true,
                on_attach = function(client, bufnr)
                    print('hello tsserver')
                end,
            })
        end,
    },
})
