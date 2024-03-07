local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")
local config_dir = gears.filesystem.get_configuration_dir()

local powerbutton_widget = wibox.widget {
    {
        {
            {
                id = "img",
                image = config_dir .. "ui/icons/power.svg",
                widget = wibox.widget.imagebox
            },
            widget = wibox.container.margin,
            margins = { top = 7, bottom = 7, left = 12, right = 12 }
        },
        widget = wibox.container.background,
        bg = "#f7768e",
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5, right = 10}
}

powerbutton_widget:buttons(
    awful.button({}, 1, function()
        awesome.emit_signal("widgets::notifications::toggle")
    end)
)

return powerbutton_widget