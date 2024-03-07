local awful_layout = require("awful.layout")
local awful_tag = require("awful.tag")

local bling_layout = require("modules.bling.layout")
local machi = require("modules.layout-machi")
require("beautiful").layout_machi = machi.get_icon()


tag.connect_signal("request::default_layouts", function()
    awful_layout.append_default_layouts({
        awful_layout.suit.tile,
         bling_layout.centered,
        machi.default_layout,
        awful_layout.suit.floating,
        awful_layout.suit.tile.left,
        awful_layout.suit.tile.bottom,
        awful_layout.suit.tile.top,
        awful_layout.suit.fair,
        awful_layout.suit.fair.horizontal,
        awful_layout.suit.spiral,
        awful_layout.suit.spiral.dwindle,
        -- awful_layout.suit.max,
        -- awful_layout.suit.max.fullscreen,
        awful_layout.suit.magnifier,
        awful_layout.suit.corner.nw,
        -- machi.default_editor,
    })
end)

-- label-active =  
-- label-occupied =  
-- label-empty =  



screen.connect_signal(
    "request::desktop_decoration", function(s)
        awful_tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, {
            --   awful_layout.layouts[1],
            awful_layout.suit.floating,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            machi.default_layout,
            -- bling_layout.centered,
        })

        local is_vertical = s.geometry.height > s.geometry.width
        if is_vertical then
            for _, tag in ipairs(s.tags) do
                tag.layout = awful_layout.suit.tile.bottom

                tag.layouts = {
                    awful_layout.suit.tile.bottom,
                    awful_layout.suit.max,
                    awful_layout.suit.magnifier,
                    bling_layout.horizontal,
                    awful_layout.suit.spiral,
                    bling_layout.deck,
                    awful_layout.suit.floating
                }
            end
        end
    end)
