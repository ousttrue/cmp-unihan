# cmp-unihan

nvim-cmp 漢字

四角号碼 from Unihan_DictionaryLikeData.txt in https://www.unicode.org/Public/UCD/latest/ucd/Unihan.zip

[cmp-emoji](https://github.com/hrsh7th/cmp-emoji) based.

## lazy

```lua
{
  cmp-unihan,
  opts = {
    data = vim.fn.expand("~") .. ".ssh/Unihan_DictionaryLikeData.txt",
  },
},
```
