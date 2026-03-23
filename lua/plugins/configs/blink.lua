---@module 'blink.cmp'
---@type blink.cmp.Config

local opts = {
  snippets = { preset = "luasnip" },
  cmdline = { enabled = true },
  sources = {
    default = { "copilot", "lsp", "path", "snippets", "buffer" },
    providers = {
      copilot = {
        module = "blink-copilot",
        name = "copilot",
        score_offset = 300,
        async = true,
      },
    },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
  keymap = { preset = "default" },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
  },
  completion = {
    completion = {
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
          },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 100,
      window = { border = "single" },
    },
  },
}

return opts
