local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

local weather_widget = wibox.widget {
    {
        {
            {
                {
                    id = "icon",
                    widget = wibox.widget.imagebox,
                    resize = true
                },
                {
                    id = "temp",
                    widget = wibox.widget.textbox
                },
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.margin,
            margins = { left = 10, right = 10 }
        },
        id = "background",
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        bg = "#252536"
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 }
}

local function update_weather_widget()
    awful.spawn.easy_async("python /home/davidoboy/.scripts/main.py", function(stdout)
        local temp = string.match(stdout, "Temperature: ([^°]+)")
        local svg_icon_path = string.match(stdout, "SVG Icon Filled: (%S+)")

        if tonumber(temp) ~= nil then
            temp = math.floor(tonumber(temp) + 0.5) .. "°C"
            weather_widget:get_children_by_id("icon")[1]:set_image(svg_icon_path)
            weather_widget:get_children_by_id("temp")[1]:set_text(" " .. temp)
        else
            temp = temp .. "°C"
            weather_widget:get_children_by_id("icon")[1]:set_image(svg_icon_path)
            weather_widget:get_children_by_id("temp")[1]:set_text(" " .. temp)
        end
    end)
end

update_weather_widget()

awful.widget.watch("python /home/davidoboy/.scripts/main.py", m600, function(widget, stdout)
    local temp = string.match(stdout, "Temperature: ([^°]+)")
    local svg_icon_path = string.match(stdout, "SVG Icon Filled: (%S+)")

    if tonumber(temp) ~= nil then
        temp = math.floor(tonumber(temp) + 0.5) .. "°C"
        weather_widget:get_children_by_id("icon")[1]:set_image(svg_icon_path)
        weather_widget:get_children_by_id("temp")[1]:set_text(" " .. temp)
    else
        temp = temp .. "°C"
        weather_widget:get_children_by_id("icon")[1]:set_image(svg_icon_path)
        weather_widget:get_children_by_id("temp")[1]:set_text(" " .. temp)
    end
end, weather_widget)

weather_widget:connect_signal("button::press", function(_, _, _, button)

    if button == 1 then
        awful.spawn("python /home/davidoboy/.scripts/main.py", false)
    elseif button == 3 then
        update_weather_widget()
    end
end)

local old_cursor, old_wibox
weather_widget:connect_signal("mouse::enter", function(c)
    c:get_children_by_id("background")[1].bg = "#1f1f2d"
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = "hand2"
end)

weather_widget:connect_signal("mouse::leave", function(c)
    c:get_children_by_id("background")[1].bg = "#252536"
    if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
    end
end)

return weather_widget