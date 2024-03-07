local awful = require("awful")
local modalbind = require("modules.modalbind")
local hotkeys_popup = require("awful.hotkeys_popup")
-- local naughty = require("naughty")
local gears = require("gears")

local icon_dir = gears.filesystem.get_configuration_dir() .. "ui/icons/"

modalbind.init()

modkey = "Mod1"
winkey = "Mod4"

modalbind.default_keys = {
  { "Escape", function() end, "Exit binding", stay_in_mode = false },
}

-- Application launching bind mode
appmode = {
  { "f",                 function() awful.spawn("firefox", false) end,       "Open Firefox" },
  { "d",                 function() awful.spawn("discord", false) end,       "Open Discord" },
  { "c",                 function() awful.spawn("code-insiders", false) end, "Open Visual Studio Code - Insiders" },
  { "s",                 function() awful.spawn("spotify", false) end,       "Open Spotify" },
  { { modkey, "Shift" }, "s",                                                function() awful.spawn("steam", false) end, "Open Steam" },
  { "e",                 function() awful.spawn("thunar", false) end,        "Open Thunar" },

  -- {{ "Control", "Shift" }, "Escape", function() awful.spawn("missioncenter") end, "Open Task Manager" },
}

-- Window Control Bind Mode
windowmode = {
  -- Layout Related
  { { modkey },          "j",     function() awful.client.swap.byidx(1) end,            "Swap with next client by index" },
  { { modkey },          "k",     function() awful.client.swap.byidx(-1) end,           "Swap with previous client by index" },

  { { modkey },          "u",     awful.client.urgent.jumpto,                           "Jump to urgent client" },

  { { modkey },          "l",     function() awful.tag.incmwfact(0.05) end,             "Increase master width factor" },
  { { modkey },          "h",     function() awful.tag.incmwfact(-0.05) end,            "Decrease master width factor" },

  { { modkey },          "h",     function() awful.tag.incnmaster(1, nil, true) end,    "Increase the number of master clients" },
  { { modkey },          "l",     function() awful.tag.incnmaster(-1, nil, true) end,   "Decrease the number of master clients" },

  { { modkey },          "h",     function() awful.tag.incncol(1, nil, true) end,       "Increase the number of columns" },
  { { modkey },          "l",     function() awful.tag.incncol(-1, nil, true) end,      "Decrease the number of columns" },

  { { modkey },          "v",     function() awful.layout.inc(1) end,                   "Select next" },
  { { modkey, "Shift" }, "v",     function() awful.layout.inc(-1) end,                  "Select previous" },

  -- Focus Related
  { { modkey },          "Right", function() awful.client.focus.byidx(1) end,           "Focus next by index" },
  { { modkey },          "Left",  function() awful.client.focus.byidx(-1) end,          "Focus previous by index" },

  { { modkey },          "Tab",   function() awful.client.focus.history.previous() end, "Go back" },

  { { modkey },          "Up",    function() awful.screen.focus_relative(1) end,        "Focus the next screen" },
  { { modkey },          "Down",  function() awful.screen.focus_relative(-1) end,       "Focus the previous screen" },

  { { modkey }, "n", function()
    local c = awful.client.restore()
    if c then
      c:activate { raise = true, context = "key.unminimize" }
    end
  end, "Restore minimized" },
}

-- Terminal Program Bind Mode
terminalmode = {
  { "p", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/pipes", false) end,                 "Execute pipes with custom configuration" },
  { { modkey }, "p", function()
    awful
        .spawn("wezterm -e pipes.sh", false)
  end, "Execute pipes with default configuration" },

  { "n", function() awful.spawn("wezterm -e '/usr/bin/zsh -c \"neofetch && zsh\"' --hold &", false) end, "Execute neofetch with custom configuration" },
  { { modkey }, "n", function()
    awful
        .spawn("wezterm -e neofetch", false)
  end, "Execute neofetch with default configuration" },

  { "c", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/cbonsai", false) end, "Execute cbonsai with custom configuration" },
  { { modkey }, "c", function()
    awful
        .spawn("wezterm -e cbonsai", false)
  end, "Execute cbonsai with default configuration" },


  { "t", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/tig", false) end,     "Execute tig with custom configuration" },
  { { modkey }, "t", function()
    awful
        .spawn("wezterm -e tig", false)
  end, "Execute tig with default configuration" },

  { "r", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/ranger", false) end,  "Execute ranger with custom configuration" },
  { { modkey }, "r", function()
    awful
        .spawn("wezterm -e ranger", false)
  end, "Execute ranger with default configuration" },

  { "s", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/sshmenu", false) end, "Execute sshmenu with custom configuration" },
  { { modkey }, "s", function()
    awful
        .spawn("wezterm -e sshmenu", false)
  end, "Execute sshmenu with default configuration" },

  { "m", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/matrix", false) end,  "Execute matrix with custom configuration" },
  { { modkey }, "m", function()
    awful
        .spawn("wezterm -e cmatrix", false)
  end, "Execute matrix with default configuration" },

  { "f", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/fortune", false) end, "Execute fortune with custom configuration" },
  { { modkey }, "f", function()
    awful
        .spawn("wezterm -e fortune", false)
  end, "Execute fortune with default configuration" },

  { "d", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/diskusage", false) end, "Execute diskusage with custom configuration" },
  { { modkey }, "d", function()
    awful
        .spawn("wezterm -e diskusage", false)
  end, "Execute diskusage with default configuration" },

  { "b", function() awful.spawn("wezterm -e /home/davidoboy/.scripts/bandwhich", false) end, "Execute bandwhich with custom configuration" },
  { { modkey }, "b", function()
    awful
        .spawn("wezterm -e bandwhich", false)
  end, "Execute bandwhich with custom configuration" },
}

-- Binding Modes
awful.keyboard.append_global_keybindings({
  awful.key({ "Mod4" }, "1", function()
    modalbind.grab { keymap = appmode, name = "Application Mode", stay_in_mode = true }
  end, { description = "show main menu", group = "awesome" }),

  awful.key({ "Mod4" }, "2", function()
    modalbind.grab { keymap = windowmode, name = "Window Mode", stay_in_mode = true }
  end, { description = "show main menu", group = "awesome" }),

  awful.key({ "Mod4" }, "3", function()
    modalbind.grab { keymap = terminalmode, name = "Terminal Program Mode", stay_in_mode = false }
  end, { description = "show main menu", group = "awesome" }),
})

-- Media/Volume Keys
awful.keyboard.append_global_keybindings({
  awful.key({}, "XF86AudioPrev", function()
    awful.spawn("playerctl -p spotify previous", false)
  end, { description = "Previous", group = "media" }),

  awful.key({}, "XF86AudioPlay", function()
    awful.spawn("playerctl -p spotify play-pause", false)
  end, { description = "Play/Pause", group = "media" }),

  awful.key({}, "XF86AudioNext", function()
    awful.spawn("playerctl -p spotify next", false)
  end, { description = "Next", group = "media" }),

  awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%", false)
    awesome.emit_signal("volume_change")
    -- naughty.notify {
    --   text = "Volume: " .. io.popen("pamixer --get-volume"):read("*n") .. "%",
    --   icon = icon_dir .. "volume-low.svg",
    --   font = "JetBrainsMono Nerd Font Mono Bold 12",
    --   margin = 20,
    --   timeout = 2,
    --   width = 300,
    --   bg = "#1a1b26",
    --   fg = "#fff",
    --   border_width = 2,
    --   border_color = "#31364d",
    -- }
  end, { description = "Lower Volume", group = "media" }),

  awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%", false)
    awesome.emit_signal("volume_change")
    -- naughty.notify {
    --   text = "Volume: " .. io.popen("pamixer --get-volume"):read("*n") .. "%",
    --   icon = icon_dir .. "volume.svg",
    --   font = "JetBrainsMono Nerd Font Mono Bold 12",
    --   margin = 20,
    --   timeout = 2,
    --   width = 300,
    --   bg = "#1a1b26",
    --   fg = "#fff",
    --   border_width = 2,
    --   border_color = "#31364d",
    -- }
  end, { description = "Raise Volume", group = "media" }),

  awful.key({}, "XF86AudioMute", function()
    awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle", false)
    awesome.emit_signal("volume_change")
    -- local is_muted = io.popen("pamixer --get-mute"):read("*line")
    -- if is_muted == "true" then
    --   naughty.notify {
    --     text = "Audio Muted",
    --     icon = icon_dir .. "volume-off.svg",
    --     font = "JetBrainsMono Nerd Font Mono Bold 12",
    --     margin = 20,
    --     timeout = 2,
    --     width = 300,
    --     bg = "#1a1b26",
    --     fg = "#fff",
    --     border_width = 2,
    --     border_color = "#31364d",
    --   }
    -- else
    --   naughty.notify {
    --     text = "Audio Unmuted",
    --     icon = icon_dir .. "volume.svg",
    --     font = "JetBrainsMono Nerd Font Mono Bold 12",
    --     margin = 20,
    --     timeout = 2,
    --     width = 300,
    --     bg = "#1a1b26",
    --     fg = "#fff",
    --     border_width = 2,
    --     border_color = "#31364d",
    --   }
    -- end
  end, { description = "Mute", group = "media" })
})


awful.keyboard.append_global_keybindings({
  awful.key({}, "Print", function()
      awful.util.spawn(apps.screenshot, false)
    end,
    { description = "Take a screenshot", group = "tag" }),
})



-- General Awesome keys
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, }, "s", hotkeys_popup.show_help,
    { description = "show help", group = "awesome" }),


  awful.key({ modkey }, "Return", function()
    awful.spawn("wezterm start", false)
  end, { description = "Open Task Manager", group = "awesome" }),



  awful.key({ "Control", "Shift" }, "Escape", function()
    awful.spawn("missioncenter", false)
  end, { description = "Open Task Manager", group = "awesome" }),

  awful.key({ modkey, }, "w", function()
    mymainmenu:show()
  end, { description = "show main menu", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "r",
    awesome.restart,
    { description = "reload awesome", group = "awesome" }),

  awful.key({ modkey, "Shift" }, "c", awesome.quit,
    { description = "quit awesome", group = "awesome" }),

  awful.key({ modkey }, "space", function()
    awful.util.spawn("rofi -show drun")
  end, { description = "run rofi", group = "launcher" }),

  awful.key({ winkey, "Shift" }, "s", function()
    awful.util.spawn("flameshot gui")
  end, { description = "Take a screenshot", group = "launcher" }),

  awful.key({ modkey, }, "Return", function() awful.spawn(terminal, false) end,
    { description = "open a terminal", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
  awful.key({ modkey, }, "Left", awful.tag.viewprev,
    { description = "view previous", group = "tag" }),
  awful.key({ modkey, }, "Right", awful.tag.viewnext,
    { description = "view next", group = "tag" }),
})

-- Client related keybindings
awful.keyboard.append_global_keybindings({
  awful.key {
    modifiers   = { modkey },
    keygroup    = "numrow",
    description = "only view tag",
    group       = "tag",
    on_press    = function(index)
      local screen = awful.screen.focused()
      local tag = screen.tags[index]
      if tag then
        tag:view_only()
      end
    end,
  },

  awful.key {
    modifiers   = { modkey, "Shift" },
    keygroup    = "numrow",
    description = "move focused client to tag",
    group       = "tag",
    on_press    = function(index)
      if client.focus then
        local tag = client.focus.screen.tags[index]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end,
  },

  awful.key {
    modifiers   = { modkey },
    keygroup    = "numpad",
    description = "select layout directly",
    group       = "layout",
    on_press    = function(index)
      local t = awful.screen.focused().selected_tag
      if t then
        t.layout = t.layouts[index] or t.layout
      end
    end,
  }
})

-- Mouse bindings
awful.mouse.append_global_mousebindings({
  awful.button({}, 3, function()
    awful.spawn("jgmenu_run", false)
  end),
})
