local M = {}

M.signs = {
    Error = '',
    Warn = '',
    Hint = '󱠃',
    Info = '',
}

function M.count()
    local count
    if vim.diagnostic.count ~= nil then
        count = vim.diagnostic.count(0)
        return {
            error = count[vim.diagnostic.severity.ERROR] or 0,
            warn = count[vim.diagnostic.severity.WARN] or 0,
            info = count[vim.diagnostic.severity.INFO] or 0,
            hint = count[vim.diagnostic.severity.HINT] or 0,
        }
    end
end

function M.setup()
    vim.diagnostic.config({
        virtual_text = false,
        -- virtual_text = {
        --     prefix = '',
        --     -- prefix = '',
        --     spacing = 1,
        -- },
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = M.signs.Error,
                [vim.diagnostic.severity.WARN] = M.signs.Warn,
                [vim.diagnostic.severity.HINT] = M.signs.Hint,
                [vim.diagnostic.severity.INFO] = M.signs.Info,
            },
        },
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = 'rounded',
            source = true,
            header = '',
            prefix = '',
            focusable = false,
            style = 'minimal',
        },
    })
end

return M
