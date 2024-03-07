local wibox = require("wibox")
local awful = require("awful")

-- Create a text widget for displaying GPU fan speed
local gpu_fan_speed = wibox.widget.textbox()

-- Function to update GPU fan speed
local function update_gpu_fan_speed()
    awful.spawn.easy_async_with_shell(
        "sensors | grep -i gpu_fan | awk '{print $2}'", -- Command to extract GPU fan speed
        function(stdout)
            gpu_fan_speed:set_text("GPU Fan Speed: " .. stdout:gsub('\n', '')) -- Set text to GPU fan speed value
        end
    )
end

-- Update GPU fan speed initially
update_gpu_fan_speed()

-- Set up a timer to update GPU fan speed periodically
local gpu_fan_speed_update_timer = timer({ timeout = 10 })
gpu_fan_speed_update_timer:connect_signal("timeout", update_gpu_fan_speed)
gpu_fan_speed_update_timer:start()

-- Return GPU fan speed widget
return gpu_fan_speed
