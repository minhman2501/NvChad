local ls = require "luasnip"

ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "typescript", "javascript" })
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("svelte", { "html", "javascript", "typescript" })
