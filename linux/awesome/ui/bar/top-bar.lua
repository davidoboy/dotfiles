local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local widgets = require("ui.bar.widgets")

screen.connect_signal("request::desktop_decoration", function(s)
    local left_widgets = {
        widgets.logo,
        widgets.taglist(s),
        widgets.focused_window,

        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
    }

    local center_widgets = {
        widgets.date_time,
        widgets.weather,

        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
    }

    local right_widgets = {
        widgets.mediaPlayer,
        widgets.system_tray,
        widgets.battery_status,

        widgets.tiling_layout(s),
        widgets.power_control,

        layout = wibox.layout.fixed.horizontal,
        spacing = 10,
    }

    awful.wibar {
        position = "top",
        screen = s,
        height = 40,
        bg = beautiful.bg_normal,
        shape = rounded_corners,
        widget = {
            left_widgets,
            center_widgets,
            right_widgets,
            expand = "none",
            layout = wibox.layout.align.horizontal,
        },
        margins = { top = 10, left = 10, right = 10}
    }
end)