local M = {}

local keys = {
    {
        '<A-q>',
        function()
            require('notify').dismiss({ silent = true, pending = true })
        end,
        mode = { 'n', 'i' },
        desc = 'Dismiss all Notifications',
    },
}

 local config = function()
    local status_ok, notify = pcall(require, 'notify')
    if not status_ok then
        return
    end

    local icons = require('lib.icons')

    notify.setup({
        background_colour = '#000',
        fps = 30,
        icons = {
            DEBUG = icons.ui.Bug,
            ERROR = icons.diagnostics.Error,
            INFO = icons.diagnostics.Info,
            TRACE = icons.ui.Bookmark,
            WARN = icons.diagnostics.Warn,
        },
        level = 2,
        minimum_width = 50,
        render = 'default',
        stages = 'fade_in_slide_out',
        timeout = 2000,
        top_down = false,
    })

    -- Controls noisy notifications
    local buffered_messages = {
        'Client %d+ quit',
        'No node found at cursor',
    }

    local message_notifications = {}

    vim.notify = function(msg, level, opts)
        opts = opts or {}
        for _, pattern in ipairs(buffered_messages) do
            if string.find(msg, pattern) then
                if message_notifications[pattern] then
                    opts.replace = message_notifications[pattern]
                end

                opts.on_close = function()
                    message_notifications[pattern] = nil
                end
                message_notifications[pattern] = notify.notify(msg, level, opts)
                return
            end
        end

        notify.notify(msg, level, opts)
    end
end

M.keys = keys
M.config = config
return M
