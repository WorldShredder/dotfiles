--[[
    Description
        TreeSitter (archived) is an incremental parsing tree generator which
        powers all of the highlighting, auto-indentation and syntax-based
        code folding in the editor for a given set of languages. This is a
        very powerful and (currently) necessary plugin.

    Warning
        Due to TreeSitter's status as an experimental plugin, it is recommended
        that you pin it to a particular commit that is compatible with your
        version of Neovim. This configuration is pinned for Neovim >= 0.12.

    Requirements
        - tree-sitter-cli (Neovim >= 0.12)
            - Glibc >= 2.39 for pre-built binaries
              See plugins/mason.lua
        - Cargo/Rust for TSC

    Managing Parsers
        You can add or remove languages from the TreeSitter config by editing
        the `languages` tables.
--]]

return {
    'nvim-treesitter/nvim-treesitter',
    commit = '4916d65',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        -- https://stackoverflow.com/a/79889920
        local ts = require('nvim-treesitter')
        local languages = {
            -- Markup Languages
            'vimdoc',
            'markdown',
            'html',
            'css',
            -- Config Languages
            'json',
            'yaml',
            -- Scripting Languages
            'bash',
            'lua',
            'vim',
            -- High Level Languages
            'cpp',
            'rust',
            -- Low Level Languages
            'c',
        }
        ts.setup({})

        -- Failed installs may require tree-sitter-cli via Mason
        ts.install(languages)

        -- Enable languages by filetype
        vim.api.nvim_create_autocmd('FileType', {
            pattern = languages,
            callback = function()
                -- TS Syntax Highlighting
                vim.treesitter.start()
                -- TS Code folding
                vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                vim.wo.foldmethod = 'expr'
                vim.cmd.normal('zR') -- open all folds by default
                -- TS Smart Indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })
    end,
}
