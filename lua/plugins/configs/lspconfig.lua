local base = require "nvchad.configs.lspconfig"

local servers = {
  "lua_ls",
  "ts_ls",
  "emmet_ls",
  "tailwindcss",
  "eslint",
  "svelte",
  "cssls",
  "pyright",
  "djlsp",
}

-- Enable all servers
vim.lsp.enable(servers)

-- Global config (like your base)
vim.lsp.config("*", {
  on_attach = base.on_attach,
  on_init = base.on_init,
  capabilities = base.capabilities,
})

-- Tailwind override
vim.lsp.config("tailwindcss", {
  filetypes = { "javascriptreact", "typescriptreact" },
})

-- TS override
vim.lsp.config("ts_ls", {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "typescript" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "typescriptreact",
    "javascriptreact",
    "svelte",
  },
})
