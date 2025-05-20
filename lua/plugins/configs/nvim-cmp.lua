local nvchad_cmp = require "nvchad.configs.cmp"

local opts = vim.tbl_deep_extend("force", nvchad_cmp, {
  sources = vim.tbl_deep_extend("force", nvchad_cmp.sources, {
    { name = "codeium" }, -- 🚀 Codeium AI suggestions first
    { name = "nvim_lsp" }, -- LSP completions
    { name = "luasnip" }, -- Snippet completions
    { name = "buffer" }, -- Buffer words
    { name = "path" }, -- Filesystem paths
  }),
})

return opts
