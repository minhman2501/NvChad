local config = function()
  require("copilot").setup {
    panel = {
      enabled = false,
    },
    suggestion = {
      enabled = true,
      auto_trigger = true,
    },
    filetypes = {
      javascript = true,
      typescript = true,
      javascriptreact = true,
      typescriptreact = true,
      css = true,
      html = true,
      svelte = true,
      vue = true,
      ["*"] = false,
    },
  }
end

return config
