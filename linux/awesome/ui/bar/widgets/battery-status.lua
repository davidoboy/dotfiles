local wibox = require("wibox")
local gears = require("gears")

local battery_widget = wibox.widget {
    {
        {
            {
                {
                    id = "icon",
                    image = gears.filesystem.get_configuration_dir() .. "ui/icons/battery.svg",
                    widget = wibox.widget.imagebox,
                },
                widget = wibox.container.margin,
                margins = { left = 10, right = 5 }
            },
            {
                {
                    id = "percentage",
                    widget = wibox.widget.textbox,
                    text = "100%",
                    font = "JetBrainsMono Nerd Font Mono 10",
                },
                widget = wibox.container.margin,
                margins = { right = 10 }
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        bg = "#252536"
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 }
}

local function update_battery_icon(percentage)
    local icon_path = ""
    if percentage >= 90 then
        icon_path = icons .. "battery/battery-full.svg"
    elseif percentage >= 70 then
        icon_path = icons .. "battery/battery-three-quarters.svg"
    elseif percentage >= 50 then
        icon_path = icons .. "battery/battery-half.svg"
    elseif percentage >= 20 then
        icon_path = icons .. "battery/battery-low.svg"
    elseif percentage >= 10 then
        icon_path = icons .. "battery/battery-empty.svg"
    else
        icon_path = icons .. "battery/battery-dead.svg"
    end
    battery_widget:get_children_by_id("icon")[1]:set_image(icon_path)
end

local function update()
    local percentage = tonumber(io.popen("cat /sys/class/power_supply/BAT0/capacity"):read("*all"))
    battery_widget:get_children_by_id("percentage")[1].text = percentage .. "%"
    update_battery_icon(percentage)
end

update()

gears.timer {
    timeout = 60,
    call_now = true,
    autostart = true,
    callback = update
}

return battery_widget