local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local wifi_widget = wibox.widget {
    {
        {
            {
                id = "icon",
                image = gears.filesystem.get_configuration_dir() .. "ui/icons/wifi.svg", -- Default icon
                widget = wibox.widget.imagebox,
            },
            {
                id = "text",
                text = "WiFi: Not Connected", -- Default text
                widget = wibox.widget.textbox,
            },
            layout = wibox.layout.fixed.horizontal,
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 10, right = 10 }
        },
            widget = wibox.container.background,
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end, 
            bg = "#252536"
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 },
}

local function update_wifi_status()
    awful.spawn.easy_async_with_shell(
        "nmcli -t -f active,ssid,signal,device dev wifi list | grep ^yes",
        function(stdout)
            local active_wifi = stdout:match("yes:(.*):(.*):(.*)")
            if active_wifi then
                local ssid, signal, device = active_wifi:match(":(.*):(.*):(.*)")
                local icon_name = "wifi"

                -- Choose icon based on signal strength
                if tonumber(signal) <= 50 then
                    icon_name = "wifi-strong"
                elseif tonumber(signal) <= 70 then
                    icon_name = "wifi-medium"
                else
                    icon_name = "wifi-weak"
                end

                -- Check if using Ethernet
                if device:find("eth") then
                    icon_name = "ethernet"
                end

                -- Update icon and text
                wifi_widget:get_children_by_id("icon")[1].image = gears.filesystem.get_configuration_dir() ..
                "ui/icons/" .. icon_name .. ".svg"
                wifi_widget:get_children_by_id("text")[1].text = "WiFi: " .. ssid
            else
                -- WiFi not connected
                wifi_widget:get_children_by_id("icon")[1].image = gears.filesystem.get_configuration_dir() ..
                "ui/icons/wifi-disconnected.svg"
                wifi_widget:get_children_by_id("text")[1].text = "WiFi: Not Connected"
            end
        end
    )
end

-- Update WiFi status initially
update_wifi_status()

-- Update WiFi status every 10 seconds
gears.timer {
    timeout = 10,
    autostart = true,
    call_now = true,
    callback = function() update_wifi_status() end
}

return wifi_widget
