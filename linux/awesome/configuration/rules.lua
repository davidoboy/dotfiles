local awful = require("awful")
local ruled = require("ruled")

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = {},
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id         = "floating",
        rule_any   = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            name     = {
                "Event Tester", -- xev.
            },
            role     = {
                "AlarmWindow", -- Thunderbird's calendar.
                "ConfigManager", -- Thunderbird's about:config.
                "pop-up", -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Move windows to specific tags
    -- 1: 󰋜, 2: 󰖟, 3: 󰠮, 4: 󰭹, 5: 󰨞, 6: , 7: 󰓓, 8: 󰊴, 9: 󰕧, 10: 

    -- Tag 2
    ruled.client.append_rule {
        rule = { class = "firefox" },
        properties = { screen = 1, tag = "2" }
    }

    -- Tag 4
    ruled.client.append_rule {
        rule = { class = "discord" },
        properties = { screen = 1, tag = "4" }
    }

    -- Tag 5
    ruled.client.append_rule {
        rule = { class = "Code - Insiders" },
        properties = { screen = 1, tag = "5" }
    }

    -- Tag 7
    ruled.client.append_rule {
        rule = { class = "steam" },
        properties = { screen = 1, tag = "7" }
    }

    -- Tag 8
    ruled.client.append_rule {
        rule = { class = "steam_app_1607250" },
        properties = { screen = 1, tag = "8" }
    }

    -- Tag 9
    ruled.client.append_rule {
        rule = { class = "zoom " },
        properties = { screen = 1, tag = "9" }
    }

    ruled.client.append_rule {
        rule = { class = "obs" },
        properties = { screen = 1, tag = "9" }
    }

    -- Tag 10
    ruled.client.append_rule {
        rule = { class = "Spotify" },
        properties = { screen = 1, tag = "10" }
    }
end)

ruled.notification.connect_signal('request::rules', function()
    ruled.notification.append_rule {
        rule       = {},
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
            position         = "top_middle"
        }
    }
end)
