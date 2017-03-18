local awful = require("awful")
require('awful.spawn')
local hotkeys_popup = require("awful.hotkeys_popup").widget
local descs = require("descs")
local config = require("config")
local menu = require("menu")
local menubar = require("menubar")

local keybindings = {}

modkey = config.MODKEY

-- {{{ Key bindings
keybindings.globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "h",   awful.tag.viewprev,
              {description = descs.VIEW_PREV_TAG, group = "tag"}),
    awful.key({ modkey,           }, "l",  awful.tag.viewnext,
              {description = descs.VIEW_NEXT_TAG, group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = descs.FOCUS_NEXT, group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = descs.FOCUS_PREV, group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () menu.mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
       {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(config.TERMINAL) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),

    awful.key({ modkey,           }, "Right",     function () awful.tag.incmwfact( 0.05)          end,
              {description = descs.INCREASE_MASTER_WIDTH, group = "layout"}),
    awful.key({ modkey,           }, "Left",     function () awful.tag.incmwfact(-0.05)          end,
              {description = descs.DECREASE_MASTER_WIDTH, group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end,
              {description = "show the menubar", group = "launcher"})
)

keybindings.clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
local tags = require("tags")
local tag_count = tags.get_tag_count()
for i = 1, tag_count do
   keybindings.globalkeys = awful.util.table.join(keybindings.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
           function ()
              local _screen = tags.get_screen_by_index(i)
              local tag = tags.get_tag_by_index(i)
              if _screen and tag then
                 awful.screen.focus(_screen.index)
                 tag:view_only()
              end
           end,
           {description = descs.VIEW_TAG .. "(".. tags.get_tag_by_index(i).name .. ")",
            group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
           function ()
              local _screen = tags.get_screen_by_index(i)
              local tag = tags.get_tag_by_index(i)
              if _screen and tag then
                 awful.tag.viewtoggle(tag)
              end
           end,
           {description = desks.TOGGLE_TAG .. "(" .. tags.get_tag_by_index(i).name .. ")",
            group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
           function ()
              if client.focus then
                 local _screen = tags.get_screen_by_index(i)
                 local tag = tags.get_tag_by_index(i)
                 if _screen and tag then
                    client.focus:move_to_tag(tag)
                 end
              end
           end,
           {description = descs.MOVE_FOCUSED_CLIENT .. "(" .. tags.get_tag_by_index(i).name .. ")",
            group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
           function ()
              if client.focus then
                 local _screen = tags.get_screen_by_index(i)
                 local tag = tags.get_tag_by_index(i)
                 if _screen and tag then
                    client.focus:toggle_tag(tag)
                 end
              end
           end,
           {description = descs.TOGGLE_FORCUSED_CLIENT .. "(" .. tags.get_tag_by_index(i).name .. ")",
            group = "tag"})
   )
end

keybindings.clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

keybindings.mousebuttons = awful.util.table.join(
    awful.button({ }, 3, function () menu.mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
)

return  keybindings
