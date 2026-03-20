local null_ls = require("null-ls")

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local AUTOSAVE_DELAY = 500

local opts = {
  sources = {
    -- ✅ Prettier (personal projects)
    null_ls.builtins.formatting.prettierd.with({
      condition = function(utils)
        return utils.root_has_file({
          ".prettierrc",
          ".prettierrc.json",
          "prettier.config.js",
        })
      end,
    }),

    -- ✅ ESLint diagnostics (ALWAYS useful)
    require("none-ls.diagnostics.eslint_d"),

    -- ⚠️ ESLint formatter (ONLY if no prettier)
    require("none-ls.formatting.eslint_d").with({
      condition = function(utils)
        return not utils.root_has_file({
          ".prettierrc",
          ".prettierrc.json",
          "prettier.config.js",
        })
      end,
    }),

    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
  },

  on_attach = function(client, bufnr)
    -- ❌ disable other formatters (important!)
    if client.name == "vtsls" or client.name == "tsserver" then
      client.server_capabilities.documentFormattingProvider = false
    end

    vim.api.nvim_clear_autocmds({
      group = augroup,
      buffer = bufnr,
    })

    -- ✅ Format on save (ONLY null-ls exists now anyway)
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          bufnr = bufnr,
          filter = function(c)
            return c.name == "null-ls"
          end,
        })
      end,
    })

    -- ✅ Auto save (safe)
    vim.api.nvim_create_autocmd("InsertLeave", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        if vim.bo.modifiable and vim.bo.modified then
          vim.defer_fn(function()
            if vim.bo.modified then
              vim.cmd("silent! write")
            end
          end, AUTOSAVE_DELAY)
        end
      end,
    })
  end,
}

return opts
