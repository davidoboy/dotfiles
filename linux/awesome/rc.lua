local spawn = require("awful.spawn")
local gfs = require("gears.filesystem")
local gears = require("gears")

beautiful = require("beautiful")
naughty = require("naughty")

config_dir = gears.filesystem.get_configuration_dir()
dpi = beautiful.xresources.apply_dpi
naughty.config.defaults.ontop = true
icons = config_dir .. "ui/icons/"

require("awful.autofocus")

naughty.connect_signal("request::display_error", function(message, startup)
  naughty.notification {
    urgency = "critical",
    title   = "Oops, an error happened" .. (startup and " during startup!" or "!"),
    message = message
  }
end)



rounded_corners = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 5) end
spawn("flameshot", false)

spawn.easy_async_with_shell(gfs.get_configuration_dir() .. "configuration/autostart.sh")

beautiful.init("~/.config/awesome/theme/theme.lua")
require("bindings")
require("configuration")

require("signals")
require("ui")

beautiful.notification_icon_size = 100
awesome.set_preferred_icon_size(32)
naughty.config.padding = 20