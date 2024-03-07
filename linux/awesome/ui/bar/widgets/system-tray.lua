local wibox = require("wibox")
local gears = require("gears")

local systemtray_widget = wibox.widget {
    {
        {
            wibox.widget.systray(),
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 12, right = 12 },
            cursor = "cross"
        },
        widget = wibox.container.background,
        bg = "#252536",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 },
    cursor = "cross"
}

return systemtray_widget