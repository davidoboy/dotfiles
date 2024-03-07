local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

local offsetx = dpi(56)
local offsety = dpi(300)
local screen = awful.screen.focused()

local icon_dir = gears.filesystem.get_configuration_dir() .. "ui/icons/"


local volume_adjust = wibox({
    screen = awful.screen.focused(),
    x = screen.geometry.width - offsetx,
    y = dpi(100),
    width = dpi(300),
    height = dpi(56),
    shape = gears.shape.rounded_rect,
    visible = true,
    ontop = true,
    bg = "#1a1b26",
    border_width = dpi(2),
    border_color = beautiful.bg_focus
})


local vol_icon = wibox.widget {
    image = icon_dir .. "volume.svg",
    widget = wibox.widget.imagebox
}

local vol_bar = wibox.widget {
    widget = wibox.widget.progressbar,
    shape = gears.shape.rounded_bar,
    color = beautiful.accent,
    background_color = beautiful.bg_focus,
    max_value = 100,
    value = 0
}



volume_adjust:setup {
    layout = wibox.layout.align.horizontal,
    {
        wibox.container.margin(
            vol_bar, dpi(14), dpi(20), dpi(20), dpi(20)
        ),
        layout = wibox.container.margin
    },
    wibox.container.margin(
        vol_icon
    )
}

local hide_volume_adjust = gears.timer {
    timeout = 14,
    autostart = true,
    callback = function()
        volume_adjust.visible = false
    end
}


hide_volume_adjust:start()

local empty_widget = wibox.widget {
    {
        {

            margins = 5,
            widget = wibox.container.margin,
        },
        {
            {
                text = "Volume",
                font = "JetBrainsMono Nerd Font Mono Bold 20",
                widget = wibox.widget.textbox,
            },
            margins = 5,
            widget = wibox.container.margin,
        },
        layout = wibox.layout.fixed.horizontal,
    },
    bg = beautiful.bg_normal,
    shape = gears.shape.rounded_rect,
    widget = wibox.container.background,
}

-- -- Create a wibox for the empty widget
-- local empty_wibox = awful.wibar({
--     position = "top",
--     screen = awful.screen.focused(),
--     height = 100,  -- Adjust the height as needed
--     width = 300, -- Adjust the width as needed
--     ontop = true,
-- })

-- -- Add the empty widget to the wibox
-- empty_wibox.widget = {
--     {
--         empty_widget,
--         layout = wibox.layout.align.horizontal
--     },
--     widget = wibox.container.margin,
--     margins = 5
-- }

-- awful.placement.top_right(empty_wibox, {
--     margins = {top = 100, right = 10},  -- Increase top margin to move the widget down
--     parent = awful.screen.focused()
-- })












-- local volume_icon = wibox.widget {
--     widget = wibox.widget.imagebox
-- }

-- local volume_adjust = wibox({
--     screen = awful.screen.focused(),
--     x = screen.geometry.width - offsetx,
--     y = dpi(100),
--     width = dpi(300),
--     height = dpi(56),
--     shape = gears.shape.rounded_rect,
--     visible = false,
--     ontop = true,
--     bg = "#1a1b26",
--     border_width = dpi(2),
--     border_color = beautiful.bg_focus
-- })

-- local volume_bar = wibox.widget {
--     widget = wibox.widget.progressbar,
--     shape = gears.shape.rounded_bar,
--     color = beautiful.accent,
--     background_color = beautiful.bg_focus,
--     max_value = 100,
--     value = 0
-- }

-- volume_adjust:setup {
--     layout = wibox.layout.align.vertical,
--     {
--         wibox.container.margin(
--             volume_bar, dpi(14), dpi(20), dpi(20), dpi(20)
--         ),
--         forced_height = offsety * 0.75,

--         layout = wibox.container.rotate
--     },
--     wibox.container.margin(
--         volume_icon
--     )
-- }

-- local hide_volume_adjust = gears.timer {
--     timeout = 4,
--     autostart = true,
--     callback = function()
--         volume_adjust.visible = false
--     end
-- }

-- awesome.connect_signal("volume_change", function()
--     local volume_level = io.popen("pamixer --get-volume"):read("*n")
--     local is_muted = io.popen("pamixer --get-mute"):read("*line")

--     if volume_level == nil then
--         volume_level = 0
--     end

--     volume_bar.value = volume_level

--     if is_muted:match("true") then
--         volume_icon:set_image(icon_dir .. "volume-off.svg")
--     else
--         if volume_level > 40 then
--             volume_icon:set_image(icon_dir .. "volume.svg")
--         elseif volume_level > 0 then
--             volume_icon:set_image(icon_dir .. "volume-low.svg")
--         else
--             volume_icon:set_image(icon_dir .. "volume-off.svg")
--         end
--     end

--     if volume_adjust.visible then
--         hide_volume_adjust:again()
--     else
--         volume_adjust.visible = true
--         hide_volume_adjust:start()
--     end
-- end)