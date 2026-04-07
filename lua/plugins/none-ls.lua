return {
  "nvimtools/none-ls.nvim",
  dependencies = { "nvimtools/none-ls-extras.nvim" },
  event = "VeryLazy",
  config = function()
    local null_ls = require "null-ls"
    local b = null_ls.builtins
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    -- Expanded detection to catch more React/Web config variations
    local PRETTIER_CONFIGS = {
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.js",
      ".prettierrc.cjs",
      ".prettierrc.yaml",
      ".prettierrc.yml",
      "prettier.config.js",
      "prettier.config.cjs",
    }
    local ESLINT_CONFIGS = {
      ".eslintrc.js",
      ".eslintrc.cjs",
      ".eslintrc.json",
      ".eslintrc.yaml",
      ".eslintrc.yml",
      "eslint.config.js",
      "eslint.config.mjs",
      "eslint.config.cjs",
    }

    null_ls.setup {
      sources = {
        -- 1. Prettierd (Added more config variations)
        b.formatting.prettierd.with {
          condition = function(utils)
            return utils.root_has_file(PRETTIER_CONFIGS)
          end,
        },

        -- 2. ESLint Diagnostics
        require("none-ls.diagnostics.eslint_d").with {
          condition = function(utils)
            return utils.root_has_file(ESLINT_CONFIGS)
          end,
        },

        -- 3. ESLint Formatting (Fallback)
        require("none-ls.formatting.eslint_d").with {
          condition = function(utils)
            local has_prettier = utils.root_has_file(PRETTIER_CONFIGS)
            local has_eslint = utils.root_has_file(ESLINT_CONFIGS)
            return has_eslint and not has_prettier
          end,
        },

        b.formatting.stylua,
      },

      on_attach = function(client, bufnr)
        -- Only create the autocmd if the client is null-ls
        -- This prevents vtsls or others from creating conflicting autocmds
        if client.name == "null-ls" then
          vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(c)
                  return c.name == "null-ls"
                end,
                timeout_ms = 3000,
              }
            end,
          })
          vim.api.nvim_create_autocmd("InsertLeave", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- Only save if the buffer has been changed
              if vim.api.nvim_get_option_value("modified", { buf = bufnr }) then
                vim.schedule(function()
                  vim.cmd "silent! write"
                end)
              end
            end,
          })
        end

        -- Explicitly disable formatting for other servers
        local format_filter = { "vtsls", "typescript-language-server", "tsserver", "svelte" }
        for _, name in ipairs(format_filter) do
          if client.name == name then
            client.server_capabilities.documentFormattingProvider = false
          end
        end
      end,
    }
  end,
}
