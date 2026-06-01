--[[
    Description
        Provides a configurable statusline similar to tmux2k for Tmux.

    Management
        You can add or remove snacks by excluding or unexcluding a given snack
        using the `excludes` table below.

    Defining Snacks
        To define a new snack, create a new config in plugins/config/snacks
        or clone an existing config and edit accordingly.

    Keymaps
        Mappings defined in module configs.
--]]

local diagnostics = require('lsp.utils.diagnostics')

return {
    'nvim-lualine/lualine.nvim',
    dependencies = {
        'nvim-tree/nvim-web-devicons',
        'folke/snacks.nvim',
    },
    lazy = false,
    config = function()
        require('lualine').setup({
            options = {
                icons_enabled = true,
                theme = 'base16',
                globalstatus = true,
                always_show_tabline = false,
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = {
                    {
                        'filename',
                        file_status = true,
                        newfile_status = true,
                        path = 0,
                        draw_empty = false,
                        symbols = {
                            modified = '',
                            readonly = '',
                            unnamed = '',
                            newfile = '',
                        },
                    },
                },
                lualine_c = {
                    {
                        'diagnostics',
                        sources = { diagnostics.count },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        symbols = diagnostics.signs,
                        colored = true,
                        update_in_insert = false,
                        always_visible = true,
                    },
                },
                lualine_x = { 'lsp_status' },
                lualine_y = { 'filetype' },
                lualine_z = { 'location' },
            },
            inactive_sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'filename' },
                lualine_c = {
                    {
                        'diagnostics',
                        sources = { diagnostics.count },
                        sections = { 'error', 'warn', 'info', 'hint' },
                        symbols = diagnostics.signs,
                        colored = true,
                        update_in_insert = false,
                        always_visible = true,
                    },
                },
                lualine_x = {},
                lualine_y = { 'filetype' },
                lualine_z = { 'location' },
            },
            tabline = {
                lualine_a = {
                    {
                        'tabs',
                        tab_max_length = 12,
                        max_length = function()
                            return vim.o.columns / 2
                        end,
                        mode = 1,
                        path = 1,
                        use_mode_colors = true,
                        symbols = {
                            modified = '',
                        },
                        fmt = function(name, context)
                            local buflist = vim.fn.tabpagebuflist(context.tabnr)
                            local winnr = vim.fn.tabpagewinnr(context.tabnr)
                            local bufnr = buflist[winnr]
                            local mod = vim.fn.getbufvar(bufnr, '&mod')

                            if name == '[No Name]' then
                                name = '󱂬 ' .. bufnr .. ':' .. winnr
                            else
                                name = name .. (mod == 1 and ' ' or '')
                            end

                            return name
                        end,
                    },
                },
                lualine_z = {
                    {
                        'tabs',
                        tab_max_length = 12,
                        max_length = function()
                            return vim.o.columns / 2
                        end,
                        mode = 0,
                        use_mode_colors = true,
                    },
                },
            },
            extensions = { 'mason', 'trouble' },
        })
    end,
}
