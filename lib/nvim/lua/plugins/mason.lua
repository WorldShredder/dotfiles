--[[
    Description
        Mason provides a way to quickly and easily manage your Language Servers
        and LSP tools, such as linters and formatters.

    Manage
        New packages can be added for Mason to manage by appennding the `pkgs`
        array below, or less preferably through Mason's GUI.

    Requirements
        - Cargo/Rust (conditional requirement)
        - NPM (conditional requirement)

    TreeSitter
        You can use Mason to install `tree-sitter-cli`, however, older systems
        with Glibc < 2.39 must build TSC from source.

        See plugins/treesitter.lua
--]]

return {
    'mason-org/mason.nvim',
    lazy = false,
    config = function()
        local mason = require('mason')
        local registry = require('mason-registry')
        mason.setup({
            ui = {
                icons = {
                    package_installed = '󱝍',
                    package_pending = '󱝏',
                    package_uninstalled = '󱝡',
                },
            },
        })

        -- Add your mason packages here
        local pkgs = {
            'lua-language-server',
            'luacheck',
            'stylua',
            'bash-language-server',
            'shellcheck',
            'shfmt',
            'clangd',
            'cpplint',
            'clang-format',
            'efm',
        }

        -- Older systems need to build tscli from source, in which
        -- case we don't want mason to install it.
        if vim.fn.executable('tree-sitter') ~= 1 then
            table.insert(pkgs, 'tree-sitter-cli')
        end

        for _, pkg in ipairs(pkgs) do
            if not registry.is_installed(pkg) then
                vim.cmd('MasonInstall ' .. pkg)
            end
        end
    end,
}
