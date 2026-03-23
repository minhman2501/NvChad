local null_ls = require "null-ls"
local b = null_ls.builtins

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Helper to detect config files in the project root
local has_file = function(files)
  return function(utils)
    return utils.root_has_file(files)
  end
end

local opts = {
  sources = {
    -- 1. Prettierd: Runs ONLY if prettier config exists
    b.formatting.prettierd.with {
      condition = has_file { ".prettierrc", ".prettierrc.json", "prettier.config.js" },
    },

    -- 2. ESLint Diagnostics: Always show linting errors
    require("none-ls.diagnostics.eslint_d").with {
      condition = has_file { ".eslintrc.js", ".eslintrc.cjs", "eslint.config.js" },
    },

    -- 3. ESLint Formatting: The "Fallback" Formatter
    -- This only activates if ESLint exists but Prettier DOES NOT.
    require("none-ls.formatting.eslint_d").with {
      condition = function(utils)
        local has_eslint = utils.root_has_file { ".eslintrc.js", ".eslintrc.cjs", "eslint.config.js" }
        local has_prettier = utils.root_has_file { ".prettierrc", ".prettierrc.json", "prettier.config.js" }
        return has_eslint and not has_prettier
      end,
    },

    -- standard tools for other parts of your NvChad IDE
    b.formatting.stylua,
    b.formatting.black,
    b.formatting.isort,
  },

  on_attach = function(client, bufnr)
    -- VETERAN MOVE: Force disable formatting on conflicting LSPs
    -- This ensures ONLY null-ls handles the logic defined above.
    local format_filter = { "vtsls", "svelte", "typescript-language-server" }
    for _, name in ipairs(format_filter) do
      if client.name == name then
        client.server_capabilities.documentFormattingProvider = false
        client.server_capabilities.documentRangeFormattingProvider = false
      end
    end

    -- Format on Save (0.11 Optimized)
    if client.supports_method "textDocument/formatting" then
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
            timeout_ms = 2500, -- Svelte files with many components need extra time
          }
        end,
      })
    end
  end,
}

return opts
