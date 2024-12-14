local source = {}

source.opts = {
  data = vim.fn.expand "~" .. ".ssh/Unihan_DictionaryLikeData.txt",
  trigger_characters = { ":" },
  key_pattern = [=[[:digit:][:digit:]*]=],
}

source.setup = function(opts)
  local utf8 = require "utf8"

  for k, v in pairs(opts) do
    source.opts[k] = v
  end

  local uv = vim.loop
  source.ITEMS = {
    -- {
    --   -- U+5650	kFourCornerCode	6666.1
    --   word = ":66661:",
    --   label = "噐 :66661:",
    --   insertText = "噐",
    --   filterText = ":66661:",
    -- },
  }
  local stat = uv.fs_stat(opts.data)
  if stat then
    local fd = uv.fs_open(opts.data, "r", 0)
    if fd then
      local src = uv.fs_read(fd, stat.size, nil)
      if src then
        for unicode, goma in string.gmatch(src, "U%+([A-F0-9]+)\tkFourCornerCode\t([%d%.]+)") do
          print(unicode, goma)
          local codepoint = tonumber(unicode, 16)
          local ch = utf8.char(codepoint)
          table.insert(source.ITEMS, {
            word = ":" .. goma .. ":",
            label = ch .. " :" .. goma .. ":",
            insertText = ch,
            filterText = ":" .. goma .. ":",
          })
          -- break
        end
      end
    end
  end
end

source.new = function()
  local self = setmetatable({}, { __index = source })
  self.commit_items = nil
  self.insert_items = nil
  return self
end

source.get_trigger_characters = function()
  return source.opts.trigger_characters
end

source.get_keyword_pattern = function()
  return source.opts.key_pattern
end

source.complete = function(self, params, callback)
  -- Avoid unexpected completion.
  if not vim.regex(self.get_keyword_pattern() .. "$"):match_str(params.context.cursor_before_line) then
    return callback()
  end

  if self:option(params).insert then
    if not self.insert_items then
      self.insert_items = vim.tbl_map(function(item)
        item.word = nil
        return item
      end, source.ITEMS)
    end
    callback(self.insert_items)
  else
    if not self.commit_items then
      self.commit_items = source.ITEMS
    end
    callback(self.commit_items)
  end
end

source.option = function(_, params)
  return vim.tbl_extend("force", {
    insert = false,
  }, params.option)
end

return source
