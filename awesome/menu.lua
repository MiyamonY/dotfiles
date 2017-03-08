local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local config = require("config")
local beautiful = require("beautiful")
local menubar = require("menubar")
-- Load Debian menu entries
require("debian.menu")

local menu = {}

local editor = os.getenv("EDITOR") or "editor"
local editor_cmd = config.TERMINAL .. " -e " .. editor

-- Menubar configuration
menubar.utils.terminal = config.TERMINAL -- Set the terminal for applications that require it
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
menu.myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", config.TERMINAL .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}


menu.mymainmenu = awful.menu({ items =
                                  {{ "awesome", menu.myawesomemenu, beautiful.awesome_icon },
                                  { "apps", debian.menu.Debian_menu.Debian },
                                  { "open terminal", terminal }}})

menu.mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                          menu = menu.mymainmenu })

return menu
