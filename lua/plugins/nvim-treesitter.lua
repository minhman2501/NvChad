local opts = require "nvchad.configs.treesitter"
opts.ensure_installed = {
  "lua",
  "css",
  "html",
  "json",
  "vue",
  "scss",
  "javascript",
  "typescript",
  "javascriptreact",
  "typescriptreact",
  "svelte",
  "python",
}

return {
  "nvim-treesitter/nvim-treesitter",
  opts = opts,
}
