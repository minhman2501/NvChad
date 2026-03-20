local base = require "nvchad.configs.lspconfig"

local servers = {
  "lua_ls",
  "vtsls", -- ✅ replaced ts_ls
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

-- Global config
vim.lsp.config("*", {
  on_attach = base.on_attach,
  on_init = base.on_init,
  capabilities = base.capabilities,
})

-- Tailwind override
vim.lsp.config("tailwindcss", {
  filetypes = { "javascriptreact", "typescriptreact" },
})

-- ✅ vtsls override (important)
vim.lsp.config("vtsls", {
  settings = {
    typescript = {
      tsserver = {
        maxTsServerMemory = 4096, -- 🔥 huge perf boost
      },
    },
  },

  -- Vue support (same idea as before)
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "typescript", "javascript" }, -- 🔥 include js too
      },
    },
  },

  filetypes = {
    "javascript",
    "typescript",
    "javascriptreact",
    "typescriptreact",
    "vue", -- ✅ important for Vue
    "svelte",
  },
})
