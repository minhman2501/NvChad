local lspconfig = require "lspconfig"
local base = require "nvchad.configs.lspconfig"

local servers = { "lua_ls", "ts_ls", "tailwindcss", "eslint" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = base.on_attach,
    on_init = base.on_init,
    capabilities = base.capabilities,
  }
end
