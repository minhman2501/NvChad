---@module 'blink.cmp'
---@type blink.cmp.Config
local opts = {
  snippets = { preset = "luasnip" },
  cmdline = { enabled = true },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },

  keymap = { preset = "default" },

  appearance = {
    use_nvim_cmp_as_default = true,
    nerd_font_variant = "mono",
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 200,
      window = { border = "single" },
    },
  },
}

return opts
