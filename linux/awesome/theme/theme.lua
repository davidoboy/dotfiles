local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local theme = dofile(themes_path.."default/theme.lua")

local tokyoNightTheme = {
  background = '#1a1b26',
  foreground = '#a9b1d6',
  accent = '#7aa2f7',
  red = '#f7768e',
  orange = '#e0af68',
  green = '#9ece6a',
  cyan = '#7dcfff',
  purple = '#bb9af7',
}


theme.bg = "#1a1b26"
theme.bg_alt = "#1f1f2d"
theme.fg = "#a9b1d6"
theme.accent = "#7aa2f7"
theme.red = "#f7768e"
theme.orange = "#e0af68"
theme.green = "#9ece6a"
theme.blue = "#7dcfff"
theme.purple = "#bb9af7"

local kanagawaTheme = {}
local nordTheme = {}

theme = {}
theme.font = "JetBrainsMono Nerd Font Mono 10"
theme.useless_gap = dpi(7)

-- Global color
theme.fg_focus = "#ffffff"
theme.fg_normal = "#dddddd"
theme.fg_urgent = "#ff6600"

theme.bg_focus = "#343e4f"
theme.bg_normal = "#1a1b26"
theme.bg_urgent = "#4e0000"

theme.accent = tokyoNightTheme.accent

theme.fg_red = tokyoNightTheme.red
theme.fg_blue = tokyoNightTheme.blue
theme.fg_green = tokyoNightTheme.green
theme.fg_yellow = "#e5c07b"
theme.fg_orange = tokyoNightTheme.orange
theme.fg_magenta = tokyoNightTheme.purple
theme.fg_grey = "#abb2bf"
theme.fg_cyan = "#56b6c2"

-- Border
theme.border_width = dpi(1.5)
theme.border_focus  = tokyoNightTheme.accent
theme.border_urgent = tokyoNightTheme.accent
theme.border_normal = tokyoNightTheme.background

-- Taglist
theme.taglist_fg_empty    = "#0000"
theme.taglist_fg_focus    = "#0000"
theme.taglist_fg_occupied = "#0000"
theme.taglist_fg_urgent   = "#0000"
theme.taglist_fg_volatile = "#0000"
theme.taglist_bg_empty    = "#0000"
theme.taglist_bg_focus    = "#0000"
theme.taglist_bg_occupied = "#0000"
theme.taglist_bg_urgent   = "#0000"
theme.taglist_bg_volatile = "#0000"


theme.bg_systray = "#252536"

-- Wallpaper
-- theme.wallpaper           = '~/Pictures/Wallpaper/wallhaven-jxd9p5.png'
-- theme.wallpaper           = '~/Pictures/Wallpaper/botw.png'

-- Awesome icon
theme.awesome_icon        = '~/.config/awesome/Arch-linux-logo.png'

theme.music_icon = "/home/davidoboy/.config/awesome/theme/centered.png"

-- theme.awesome_icon = theme_assets.awesome_icon( theme.menu_height, theme.awesome_icon_bg, theme.awesome_icon_fg )

-- Layout box
theme.layout_centered = "/home/davidoboy/.config/awesome/theme/centered.png"
theme.layout_tile = "/home/davidoboy/.config/awesome/theme/centered.png"
theme.layout_fairh = themes_path.."default/layouts/fairhw.png"
theme.layout_fairv = themes_path.."default/layouts/fairvw.png"
theme.layout_floating  = themes_path.."default/layouts/floatingw.png"
theme.layout_magnifier = themes_path.."default/layouts/magnifierw.png"
theme.layout_max = themes_path.."default/layouts/maxw.png"
theme.layout_fullscreen = themes_path.."default/layouts/fullscreenw.png"
theme.layout_tilebottom = themes_path.."default/layouts/tilebottomw.png"
theme.layout_tileleft   = themes_path.."default/layouts/tileleftw.png"
theme.layout_tile = themes_path.."default/layouts/tilew.png"
theme.layout_tiletop = themes_path.."default/layouts/tiletopw.png"
theme.layout_spiral  = themes_path.."default/layouts/spiralw.png"
theme.layout_dwindle = themes_path.."default/layouts/dwindlew.png"
theme.layout_cornernw = themes_path.."default/layouts/cornernww.png"
theme.layout_cornerne = themes_path.."default/layouts/cornernew.png"
theme.layout_cornersw = themes_path.."default/layouts/cornersww.png"
theme.layout_cornerse = themes_path.."default/layouts/cornersew.png"

theme.notification_font = "JetBrainsMono Nerd Font Mono 12"
theme.notification_margin = 20
theme.notification_timeout = 2
theme.notification_width = 500
theme.notification_bg = "#1a1b26"
theme.notification_fg = "#fff"
theme.notification_border_width = 2
theme.notification_border_color = "#31364d"

-- Icon theme
theme.icon_theme          = 'TokyoNight-SE'

return theme
