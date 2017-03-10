local utils = {}

function utils.array_join(t1, t2)
   if not t1 then
      t1 = {}
   end

   if not t2 then
      return t1
   end

   for _, v in pairs(t2) do
      table.insert(t1, v)
   end
   return t1
end

function utils.find_files_by_ext(dir, ext)
   local files = io.popen("ls -1a " .. dir)
   if not files then
      return {}
   end

   local ret = {}
   for f in files:lines() do
      if string.find(f, "%." .. ext .. "$") then
         table.insert(ret, f)
      end
   end
   return ret
end

function utils.find_files_by_exts(dir, exts)
   local ret
   for _, ext in pairs(exts) do
      utils.array_join(ret, utils.find_files_by_ext(ext))
   end
   return ret
end

return utils
