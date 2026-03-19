local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require "null-ls"

local AUTOSAVE_DELAY = 500

local opts = {
  sources = {
    null_ls.builtins.formatting.prettierd.with {
      filetypes = {
        "css",
        "scss",
        "less",
        "html",
        "json",
        "yaml",
      },
    },
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.diagnostics.pylint.with {
      diagnostics_postprocess = function(diagnostic)
        diagnostic.code = diagnostic.message_id
      end,
    },
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    require "none-ls.formatting.eslint_d",
  },

  on_attach = function(client, bufnr)
    if client.supports_method "textDocument/formatting" then
      vim.api.nvim_clear_autocmds {
        group = augroup,
        buffer = bufnr,
      }
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format { bufnr = bufnr }
        end,
      })

      vim.api.nvim_create_autocmd({ "InsertLeave" }, {
        group = augroup,
        buffer = bufnr,
        callback = function()
          if vim.bo.modifiable and vim.bo.modified then
            vim.defer_fn(function()
              vim.cmd "silent! write"
            end, AUTOSAVE_DELAY) -- delay in milliseconds
          end
        end,
      })
    end
  end,
}

return opts
