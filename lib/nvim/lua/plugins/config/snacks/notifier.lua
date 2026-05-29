--[[
    Description
        Provides a stylish wrapper for vim notifications.

    Pre Config
        The table passed to `snacks.setup()` to configure this module.

    Post Config
        A table of functions that are called inside `snacks.config()` after
        requiring the main `snacks` plugins. You can exclude a particular
        post-config function by adding it to the module's `exclude` table.

        macro_notify
            Display a notification while recording a macro that indicates the
            register being recorded to and when recording ends.

    Module Fields
        pre_config      table       Passed to `snacks.setup()`
        post_config     table       Functions to call in `snacks.config()`
        keys            table[]     Global mappings for `snacks.keys{}`
        disabled        boolean     Controls the module's state
        exclude         string[]    Members of `post_config` to exclude
--]]

local M = {
    disabled = false,
    exclude = {},
}

-- Snacks.opts.module{} --------------------------
--------------------------------------------------

M.pre_config = {}

-- Snacks.config() -------------------------------
--------------------------------------------------

M.post_config = {
    -- Notifications for macro start/stop
    -- Useful when using LuaLine and `vim.opt.cmdheight=0`
    macro_notify = function()
        local function callback()
            local reg = vim.fn.reg_recording()
            if not reg or reg == '' then
                return
            end
            local msg = 'Recording  @' .. reg
            Snacks.notify.info(msg, {
                -- timeout 0 to avoid delayed execution of opts()
                timeout = 0,
                id = 'macro@' .. reg,
                title = 'Macro',
                style = 'compact',
                icon = '',
                opts = function(notif)
                    local _reg = vim.fn.reg_recording()
                    if not _reg or _reg == '' then
                        notif.icon = ''
                        notif.msg = 'Macro stored  @' .. reg
                        -- delay closure of updated notification
                        notif.timeout = 2000
                    end
                end,
                keep = function()
                    local _reg = vim.fn.reg_recording()
                    return _reg and _reg ~= ''
                end,
            })
        end
        vim.api.nvim_create_autocmd(
            { 'RecordingEnter', 'RecordingLeave' },
            { callback = callback }
        )
    end,
}

-- Snacks.keys{} ---------------------------------
--------------------------------------------------

M.keys = {
    {
        '<leader>nh',
        function()
            Snacks.notifier.show_history()
        end,
        desc = 'Notification history (Notifier)',
        mode = 'n',
    },
}

return M
