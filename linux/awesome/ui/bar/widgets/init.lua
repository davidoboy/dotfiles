local logo = require("ui.bar.widgets.logo")
local taglist = require("ui.bar.widgets.taglist")
local focused_window = require("ui.bar.widgets.focused-window")

local mediaPlayer = require("ui.bar.widgets.media-player")

local system_tray = require("ui.bar.widgets.system-tray")
local battery_status = require("ui.bar.widgets.battery-status")
local date_time = require("ui.bar.widgets.date-time")
local network_status = require("ui.bar.widgets.network-status")
local tiling_layout = require("ui.bar.widgets.tiling-layout")
local power_control = require("ui.bar.widgets.power-control")
local weather = require("ui.bar.widgets.weather")

local notification_center = require("ui.bar.widgets.notification-center")
local network_speed = require("ui.bar.widgets.network-speed")
local fanSpeed = require("ui.bar.widgets.fan-speed")

local modules = {
    logo = logo,
    taglist = taglist,
    focused_window = focused_window,

    mediaPlayer = mediaPlayer,

    system_tray = system_tray,
    battery_status = battery_status,
    date_time = date_time,
    network_status = network_status,
    tiling_layout = tiling_layout,
    power_control = power_control,
    weather = weather,

    network_speed = network_speed,
    notification_center = notification_center,
    fanSpeed = fanSpeed,
}

return modules