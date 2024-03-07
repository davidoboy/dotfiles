local wibox = require("wibox")
local gears = require("gears")

local activewindow_widget = wibox.widget {
    {
        {
            {
                {
                    id = "icon",
                    widget = wibox.widget.imagebox,
                },
                widget = wibox.container.margin,
                margins = { top = 3, bottom = 3, left = 10, right = 10 }
            },
            {
                {
                    id = "title",
                    widget = wibox.widget.textbox,
                    font = "JetBrainsMono Nerd Font Mono 10",
                },
                widget = wibox.container.margin,
                margins = { top = 3, bottom = 3, right = 10 }
            },
            layout = wibox.layout.fixed.horizontal,
        },
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        bg = "#252536"
    },
    maxsize = dpi(200),
    expand = true,
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 }
}

local function update()
    local c = client.focus
    if c then
        activewindow_widget.visible = true
        activewindow_widget:get_children_by_id("icon")[1].image = c.icon
        activewindow_widget:get_children_by_id("title")[1].text = (c.name or ""):sub(1, 60)
    else
        activewindow_widget.visible = false
    end
end
client.connect_signal("focus", update)
client.connect_signal("unfocus", update)
client.connect_signal("property::name", update)

return activewindow_widget