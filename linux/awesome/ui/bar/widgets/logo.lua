local wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")
local io = io

local config_file = gears.filesystem.get_configuration_dir() .. "configuration/settings.conf"
local svg_files = {"arch.svg", "awesome.svg"}

local function read_index()
    local file = io.open(config_file, "r")
    if file then
        local logoindex = tonumber(file:read("*l"))
        file:close()
        return logoindex
    else
        return 1 -- default index if file doesn't exist
    end
end

local current_svg_index = read_index()

local function write_index(index)
    local file = io.open(config_file, "w")
    if file then
        file:write(tostring(index))
        file:close()
    end
end

local function update_image_widget(widget, index)
    widget:get_children_by_id("img")[1].image = gears.color.recolor_image(icons .. "logos/" .. svg_files[index], beautiful.fg_normal)
end

local image_widget = wibox.widget {
    {
        id = "img",
        image = gears.filesystem.get_configuration_dir() .. "ui/icons`/logos/awesome.svg",
        widget = wibox.widget.imagebox
    },
    widget = wibox.container.margin,
    margins = { top = 10, bottom = 10, left = 15, right = 5 }
}

image_widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            function()
                awful.spawn("jgmenu_run", false)
            end
        ),
        awful.button(
            {},
            3,
            function()
                current_svg_index = (current_svg_index % #svg_files) + 1
                update_image_widget(image_widget, current_svg_index)
                write_index(current_svg_index)
            end
        )
    )
)

local old_cursor, old_wibox
image_widget:connect_signal("mouse::enter", function()
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = "hand2"
end)

image_widget:connect_signal("mouse::leave", function()
    if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
    end
end)

return image_widget