local awful = require("awful")
local gears = require("gears")
local tags = {}

local screen_tags = {
   [1] = {
      [1] = {
         {"main", awful.layout.layouts[2]},
         {"firefox", awful.layout.layouts[4]},
         {"franz", awful.layout.layouts[4]},
         {"", awful.layout.layouts[1]},
      }
   },
   [2] = {
      [1] = {
         {"main", awful.layout.layouts[2]},
         {"", awful.layout.layouts[1]},
         {"", awful.layout.layouts[1]},
         {"", awful.layout.layouts[1]}
      },
      [2] = {
         {"firefox", awful.layout.layouts[4]},
         {"franz", awful.layout.layouts[4]},
         {"", awful.layout.layouts[1]},
         {"", awful.layout.layouts[1]},
      }
   }
}

local screen_tag_default = {
      {"", awful.layout.layouts[1]},
      {"", awful.layout.layouts[1]},
      {"", awful.layout.layouts[1]},
      {"", awful.layout.layouts[1]},
}

function tags.get_tags_at(screen_index)
   local screen_count = screen.count()
   if  screen_count <= #screen_tags then
      return screen_tags[screen_count][screen_index]
   else
      if screen_no <= #screen_tags then
         return screen_tags[#screen_tags][screen_index]
      else
         return screen_tag_default
      end
   end
end

function find_tag_index_by(_tags, tag_name)
   for index, tag in ipairs(_tags) do
      if string.match(string.lower(tag[1]), string.lower(tag_name)) then
         return index
      end
   end
   return nil
end

function tags.find_screen_index_by(tag_name)
   local screen_count = screen.count()
   local screens
   if screen_count <= #screen_tags then
      screens = screen_tags[screen_count]
   else
      screens = screen_tags[#screen_tags]
   end

   for screen_index, _tags in pairs(screens) do
      if find_tag_index_by(_tags, tag_name) then
         return screen_index
      end
   end
   return nil
end

function tags.get_tag_name_by(app)
   for s in screen do
      for _, tag in pairs(s.tags) do
         local name = tag.name
         if string.match(string.lower(name), string.lower(app)) then
            return name
         end
      end
   end
   return nil
end

function tags.get_tag_count()
   local ret = 0
   for s in screen do
      ret = ret + #s.tags
   end
   return ret
end

return tags
