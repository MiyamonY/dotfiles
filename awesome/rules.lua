local beautiful = require("beautiful")
local awful = require("awful")
local keybindings = require("keybindings")
local tags = require("tags")

local rules = {}

default_rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = keybindings.clientkeys,
                    buttons = keybindings.clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
   },

   -- Floating clients.
   { rule_any = {
        instance = {
           "DTA",  -- Firefox addon DownThemAll.
           "copyq",  -- Includes session name in class.
        },
        class = {
           "Arandr",
           "Gpick",
           "Kruler",
           "MessageWin",  -- kalarm.
           "Sxiv",
           "Wpa_gui",
           "pinentry",
           "veromix",
           "xtightvncviewer"},

        name = {
           "Event Tester",  -- xev.
        },
        role = {
           "AlarmWindow",  -- Thunderbird's calendar.
           "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
   }, properties = { floating = true }},

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
                }, properties = { titlebars_enabled = true }
   },
}

function create_rules_by(app_classes)
   local ret = {}
   for _, class in pairs(app_classes) do
      local s = tags.find_screen_index_by(class)
      local t = tags.get_tag_name_by(class)
      if s and t then
         table.insert(ret, { rule = { class = class },
                             properties = { screen = s, tag = t } })
      end
   end
   return ret
end

local app_classes = {"Luakit", "Chromium"}
local app_rules = create_rules_by(app_classes)

for _, rule in pairs(app_rules) do
   table.insert(default_rules, rule)
end

rules.rules = default_rules

return rules
