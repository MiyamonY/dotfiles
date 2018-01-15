-- global settings
local settings = require "settings"
settings.override_setting("window.home_page", "luakit://bookmarks/")
-- settings.override_setting("window.new_tab_page", "luakit://bookmarks/")

-- search engine
search_engines = {
   default_search = "https://www.google.co.jp/search?q=%s",
   g = "https://www.google.co.jp/search?q=%s",
}

search_engines.default = search_engines

-- follow mode
local select = require "select"
select.label_maker = function()
   local chars = charset("fjghdksla")
   return trim(sort(reverse(chars)))
end

-- key binds
local modes = require "modes"
modes.remap_binds("normal",
                  {{"e", "^f$", true},
                     {"E", "^F$", true}})

modes.remove_binds("normal", {"<BackSpace>", "f"})

modes.add_binds("normal",
                {{"b", "Go back in the browser history.", function (w, m) w:back(m.count) end },
                   {"l", "Go to next tab.", function (w) w:next_tab() end },
                   {"h", "Go to previous tab.", function (w) w:prev_tab() end},
                   { "x", "Close current tab (or `[count]` tabs).",
                     function (w, m) for _=1,m.count do w:close_tab() end end, {count=1} },
                   { "f", "Go forward in the browser history.", function (w, m) w:forward(m.count) end }})

-- follow mode
local follow = require "follow"

follow.stylesheet = [===[
#luakit_select_overlay {
    position: absolute;
    left: 0;
    top: 0;
    z-index: 2147483647; /* Maximum allowable on WebKit */
}

#luakit_select_overlay .hint_overlay {
    display: block;
    position: absolute;
    background-color: #ffff99;
    border: 1px dotted #000;
    opacity: 0.3;
}

#luakit_select_overlay .hint_label {
    display: block;
    position: absolute;
    background-color: #1c1c1c;
    border: 1px dashed #000;
    color: #fff;
    font-size: 20px;
    font-family: monospace, courier, sans-serif;
}

#luakit_select_overlay .hint_selected {
    background-color: #00ff00 !important;
}
]===]
