local awful = require("awful")
local gears = require("gears")
local wibox = require("wibox")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local get_taglist = function(s)
    local taglist_buttons = gears.table.join(
        awful.button({}, 1,
            function(t) t:view_only() end),
        awful.button({ modkey }, 1, function(t)
            if client.focus then client.focus:move_to_tag(t) end
        end), awful.button({}, 3, awful.tag.viewtoggle),
        awful.button({ modkey }, 3, function(t)
            if client.focus then client.focus:toggle_tag(t) end
        end), awful.button({}, 4, function(t)
            awful.tag.viewnext(t.screen)
        end), awful.button({}, 5, function(t)
            awful.tag.viewprev(t.screen)
        end))

    local unfocus_icon = ""
    local unfocus_color = "#90b0f5"

    local empty_icon = ""
    local empty_color = "#4C6070"

    local focus_icon = ""
    local focus_color = "#7aa2f7"

    local update_tags = function(self, c3)
        local tagicon = self:get_children_by_id('icon_role')[1]
        if c3.selected then
            tagicon.text = focus_icon
            self.fg = focus_color
        elseif #c3:clients() == 0 then
            tagicon.text = empty_icon
            self.fg = empty_color
        else
            tagicon.text = unfocus_icon
            self.fg = unfocus_color
        end
    end

    local taglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        layout = { spacing = 0, layout = wibox.layout.fixed.horizontal },
        widget_template = {
            {
                { id = 'icon_role', font = "FiraCode Nerd Font Mono Regular 15", widget = wibox.widget.textbox },
                id = 'margin_role',
                top = dpi(0),
                bottom = dpi(0),
                left = dpi(5),
                right = dpi(5),
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background,
            create_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end,

            update_callback = function(self, c3, index, objects)
                update_tags(self, c3)
            end,
        },
        buttons = taglist_buttons
    }

    taglist = wibox.widget {
        {
            {
                {
                    taglist,
                    layout = wibox.layout.align.horizontal,
                },
                margins = { top = dpi(5), bottom = dpi(5), left = dpi(12), right = dpi(12) },
                widget = wibox.container.margin,
            },
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, 5)
            end,
            bg = "#252536",
            widget = wibox.container.background,
        },
        widget = wibox.container.margin,
        margins = dpi(5),
    }

    local old_cursor, old_wibox
    taglist:connect_signal("mouse::enter", function(c)
        local wb = mouse.current_wibox
        old_cursor, old_wibox = wb.cursor, wb
        wb.cursor = "hand2"
    end)

    taglist:connect_signal("mouse::leave", function(c)
        if old_wibox then
            old_wibox.cursor = old_cursor
            old_wibox = nil
        end
    end)

    return taglist
end


return get_taglist