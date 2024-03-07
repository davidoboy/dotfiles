local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

function layout(s)
    local tiling_layout_widget = wibox.widget {
        {
            {
                awful.widget.layoutbox(s),
                widget = wibox.container.margin,
                margins = { top = 5, bottom = 5, left = 12, right = 12 }
            },
            id = "background",
            widget = wibox.container.background,
            bg = "#252536",
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
        },
        widget = wibox.container.margin,
        margins = { top = 5, bottom = 5 }
    }

    tiling_layout_widget:buttons(
        gears.table.join(
            awful.button(
                {},
                1,
                function()
                    awful.layout.inc(1)
                end
            ),
            awful.button(
                {},
                3,
                function()
                    awful.layout.inc(-1)
                end
            )
        )
    )

    local old_cursor, old_wibox
    tiling_layout_widget:connect_signal("mouse::enter", function(c)
        c:get_children_by_id("background")[1].bg = "#1f1f2d"
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand2"
    end)

    tiling_layout_widget:connect_signal("mouse::leave", function(c)
        c:get_children_by_id("background")[1].bg = "#252536"
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)


    return tiling_layout_widget
end

return layout
