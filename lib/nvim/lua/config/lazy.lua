--[[
    Description
        Bootstrap script for Lazy.Nvim.

    Structure
        config              Core config files
        plugins             Contains all plugin specs.
            config          Contains plugin-specific module specs and helpers.
        lsp
            servers         LSP server configs
            tools
                formatters  Code formatter configs
                linters     Code linter and analysis configs
            utils           Utils for managing LSP-related configs
        themes              Theme plugin specs
        utils               General utilities

    Updates
        Plugin updates are not checked automatically to reduce the number of
        startup messages. Feel free to change this below.
--]]

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
    local out = vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        '--branch=stable',
        lazyrepo,
        lazypath,
    })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
            { out, 'WarningMsg' },
            { '\nPress any key to exit...' },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    spec = {
        { import = 'plugins' },
        { import = 'themes' },
    },
    opts = {
        -- colorscheme = 'dracula',
    },
    -- Plugin installer theme
    install = { colorscheme = { 'habamax' } },
    -- Auto-check for updates
    checker = { enabled = false },
})
