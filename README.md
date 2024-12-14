# cmp-unihan

四角号碼 from Unihan_DictionaryLikeData.txt in https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip

[cmp-emoji](https://github.com/hrsh7th/cmp-emoji) based.

[四角号碼入門](https://www.seiwatei.net/chinakan/inpsj.cgi)

```
;6666
┌───────────────────────────┐
│ 嚣 :6666:   󰉿 Text [四角] │
│ 嘂 :6666.0: 󰉿 Text [四角] │
│ 噐 :6666.1: 󰉿 Text [四角] │
│ 器 :6666.3: 󰉿 Text [四角] │
│ 嚚 :6666.1: 󰉿 Text [四角] │
│ 囂 :6666.8: 󰉿 Text [四角] │
└───────────────────────────┘
```

## lazy

```lua
    "hrsh7th/nvim-cmp",
    dependencies = {
      "uga-rosa/utf8.nvim",
      "ousttrue/cmp-unihan",
    },
    config = function()
      local cmp = require "cmp"

      cmp.register_source(
        "unihan",
        require("cmp-unihan").new {
          data = vim.fn.expand "~/.skk/Unihan_DictionaryLikeData.txt",
          trigger_characters = { ";" },
          keyword_pattern = [=[;\zs\d\d*]=],
        }
      )
      cmp.setup {
        sources = {
          {name = "unihan"},
        }
      }
    end,
```
