local wibox = require("wibox")
local playerctl = require("signals.playerctl")
local awful = require("awful")
local gsurface = require("gears.surface")
local gears = require("gears")

local media_player_widget = wibox.widget {
    {
        {
            {
                {
                    id = "icon",
                    widget = wibox.widget.imagebox,
                    image = icons .. "logos/spotify.svg",
                },
                {
                    {
                        {
                            id = "media_info",
                            markup = "<span font=' JetBrainsMono Nerd Font Mono 10' color='#000'>No media playing</span>",
                            widget = wibox.widget.textbox,
                        },
                        fps = 30,
                        speed = 30,
                        extra_space = 50,
                        expand = true,
                        max_size = dpi(200),
                        widget = wibox.container.scroll.horizontal,
                    },
                    widget = wibox.container.margin,
                    margins = { left = dpi(10), right = dpi(10) },
                },
                {
                    {
                        id = "backward_button",
                        widget = wibox.widget.imagebox,
                        image = icons .. "media/media-backward.svg",
                    },
                    {
                        id = "play_pause_button",
                        widget = wibox.widget.imagebox,
                        image = icons .. "media/media-start.svg",
                    },
                    {
                        id = "forward_button",
                        widget = wibox.widget.imagebox,
                        image = icons .. "media/media-forward.svg",
                    },
                    spacing = dpi(10),
                    layout = wibox.layout.fixed.horizontal,
                },
                layout = wibox.layout.fixed.horizontal,
            },
            widget = wibox.container.margin,
            margins = { top = 5, bottom = 5, left = 10, right = 10 }
        },
        widget = wibox.container.background,
        id = "background",
        shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 5) end,
        bg = "#1DB954",
        bgimage_opacity = 0.5,
    },
    widget = wibox.container.margin,
    margins = { top = 5, bottom = 5 }
}

playerctl:connect_signal(
    "metadata",
    function(_, title, artist, _, _, new)
        media_player_widget:get_children_by_id("media_info")[1].markup = "<span font=' JetBrainsMono Nerd Font Mono 11' color='#000'>" .. title .. " – " .. artist .. "</span>"
    end
)

media_player_widget:get_children_by_id("backward_button")[1]:connect_signal(
    "button::press",
    function()
        awful.spawn("playerctl -p spotify previous", false)
    end
)

local function toggle_play_pause()
    awful.spawn.easy_async("playerctl status -p spotify", function(stdout)
        if stdout:find("Playing", 1, true) then
            awful.spawn("playerctl -p spotify pause", false)
            media_player_widget:get_children_by_id("play_pause_button")[1].image = icons .. "media/media-start.svg"
        else
            awful.spawn("playerctl -p spotify play", false)
            media_player_widget:get_children_by_id("play_pause_button")[1].image = icons .. "media/media-pause.svg"
        end
    end)
end

media_player_widget:get_children_by_id("play_pause_button")[1]:connect_signal(
    "button::press",
    function()
        toggle_play_pause()
    end
)

media_player_widget:get_children_by_id("forward_button")[1]:connect_signal(
    "button::press",
    function()
        awful.spawn("playerctl -p spotify next", false)
    end
)

local function check_status()
    awful.spawn.easy_async_with_shell("playerctl status -p spotify", function(stdout)
        if stdout:find("Playing", 1, true) then
            media_player_widget:get_children_by_id("play_pause_button")[1].image = icons .. "media/media-pause.svg"
        else
            media_player_widget:get_children_by_id("play_pause_button")[1].image = icons .. "media/media-start.svg"
        end
    end)
end

local old_cursor, old_wibox
media_player_widget:connect_signal("mouse::enter", function(c)
    c:get_children_by_id("background")[1].bg = "#19a64b"
    local wb = mouse.current_wibox
    old_cursor, old_wibox = wb.cursor, wb
    wb.cursor = "hand2"
end)

media_player_widget:connect_signal("mouse::leave", function(c)
    c:get_children_by_id("background")[1].bg = "#1DB954"
    if old_wibox then
        old_wibox.cursor = old_cursor
        old_wibox = nil
    end
end)


gears.timer {
    timeout = 1,
    autostart = true,
    call_now = true,
    callback = check_status
}

return media_player_widget

-- playerctl:connect_signal(
--     "metadata", function(_, _, _, album_path)
--         -- album_art.img:set_image(gsurface.load(album_path))
--         media_player_widget.bg_image.bgimage = gears.surface.load(album_path)
--     end
-- )

-- local album_art = wibox.widget {
--     {
--         id = "album_art",
--         widget = wibox.widget.imagebox
--     },
--     widget = wibox.container.margin,
--     margins = { top = dpi(5), bottom = dpi(5), left = dpi(15) }
-- }

