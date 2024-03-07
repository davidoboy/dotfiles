local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local clock_formats = {
    "%a %d, %H:%M",
    "%H:%M"
}

local current_format_index = 1

local file = io.open(icons .. "calendar.svg", "r")
local svg_content = file:read("*all")
file:close()

local clock_widget = wibox.widget {
    {
        {
            {
                {
                    id = "icon",
                    image = gears.surface.load_uncached(icons .. "calendar.svg"),
                    widget = wibox.widget.imagebox,
                },
                widget = wibox.container.margin,
                margins = { top = 7, bottom = 7, left = 10, right = 10 }
            },
            {
                {
                    id = "time",
                    widget = wibox.widget.textbox,
                    markup = "<span font = 'JetBrainsMono Nerd Font Mono Bold 10' color='#7aa2f7'>10:00</span>",
                },
                widget = wibox.container.margin,
                margins = { top = 5, bottom = 5, right = 12 },
            },
            layout = wibox.layout.fixed.horizontal,
        },
        id = "background_role",
        widget = wibox.container.background,
        shape = function(cr, width, height)
            gears.shape.rounded_rect(cr, width, height, 5)
        end,
        bg = "#252536"
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 }
}

local function update_time()
    clock_widget:get_children_by_id("time")[1].markup = "<span color='#fff'>" ..
    os.date(clock_formats[current_format_index]) .. "</span>"
    clock_widget:get_children_by_id("icon")[1].image = gears.surface.load_uncached(icons .. "calendar.svg")

    local date = os.date("*t")
    local month = string.upper(os.date("%b", os.time(date)))
    local day = date.day
    local weekday = os.date("%A")

    local updated_svg_content = svg_content:gsub('<text id="month".-</text>',
        '<text id="month" x="32" y="164" fill="#fff" font-family="monospace" font-size="140px" style="text-anchor: left">' .. month .. '</text>')
    updated_svg_content = updated_svg_content:gsub('<text id="day".-</text>',
        '<text id="day" x="256" y="400" fill="#66757f" font-family="monospace" font-size="256px" style="text-anchor: middle">' .. day .. '</text>')
    updated_svg_content = updated_svg_content:gsub('<text id="weekday".-</text>',
        '<text id="weekday" x="256" y="480" fill="#66757f" font-family="monospace" font-size="64px" style="text-anchor: middle">' .. weekday .. '</text>')

    local file = io.open(icons .. "calendar.svg", "w")
    file:write(updated_svg_content)
    file:close()
end

update_time()

gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = update_time
}

clock_widget:buttons(
    awful.button({}, 3, function()
        current_format_index = current_format_index % #clock_formats + 1
        update_time()
    end)
)

local old_cursor, old_wibox
clock_widget:connect_signal("mouse::enter", function(c)
    c:get_children_by_id("background_role")[1].bg = "#1f1f2d"
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = "hand2"
end)

clock_widget:connect_signal("mouse::leave", function(c)
    c:get_children_by_id("background_role")[1].bg = "#252536"
    if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
    end
end)

return clock_widget