local lspconfig = require "lspconfig"
local base = require "nvchad.configs.lspconfig"

local servers =
  { "lua_ls", "ts_ls", "emmet_ls", "tailwindcss", "eslint", "volar", "svelte", "cssls", "pyright", "djlsp" }

lspconfig.volar.setup {
  -- add filetypes for typescript, javascript and vue
  filetypes = { "vue" },
  single_file_support = false,
  init_options = {
    typescript = {
      tsdk = "~/.local/share/NvChad/mason/packages/vue-language-server/node_modules/typescript/lib/",
    },
  },
  on_new_config = function(new_config, new_root_dir)
    local lib_path = vim.fs.find("node_modules/typescript/lib", { path = new_root_dir, upward = true })[1]
    if lib_path then
      new_config.init_options.typescript.tsdk = lib_path
    end
  end,
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = base.on_attach,
    on_init = base.on_init,
    capabilities = base.capabilities,
  }
end

lspconfig.tailwindcss.setup {
  filetypes = { "javascriptreact", "typescriptreact" },
}

lspconfig.ts_ls.setup {
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "typescript",
    "vue",
    "svelte",
  },
}
