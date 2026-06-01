--[[
    Description
        General purpose autocommands.
--]]

---- FORMATTERS ----------------------------------
--------------------------------------------------

-- Format text files on open
vim.api.nvim_create_autocmd('FileType', {
    -- luacheck: ignore 113
    ---@diagnostic disable-next-line: undefined-global
    group = augroup,
    pattern = { 'markdown', 'text', 'gitcommit' },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.linebreak = true
        vim.opt_local.spell = true
    end,
})
