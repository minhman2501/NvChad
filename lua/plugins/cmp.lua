return {
  {
    "hrsh7th/nvim-cmp",
    enabled = false,
  },
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets",
      "fang2hou/blink-copilot",
      {
        -- snippet plugin
        "L3MON4D3/LuaSnip",
        dependencies = "rafamadriz/friendly-snippets",
        opts = { history = true, updateevents = "TextChanged,TextChangedI" },
        config = function(_, opts)
          require "nvchad.configs.luasnip"
          require("luasnip").config.set_config(opts)
        end,
      },
    },
    version = "1.*",
    opts = {
      snippets = { preset = "luasnip" },

      appearance = {
        -- Link to NvChad's existing Cmp highlight groups
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },

      completion = {
        menu = {
          border = "rounded",
          draw = {
            -- Correct "table of tables" structure
            columns = {
              { "kind_icon" },
              { "label", "label_description", gap = 1 },
              { "source_name" },
            },
            components = {
              kind_icon = {
                ellipsis = false,
                text = function(ctx)
                  -- Safer module loading to prevent "module not found" crashes
                  local status, tailwind = pcall(require, "blink.cmp.completion.windows.render.tailwind")
                  if status and tailwind.get_hex_color(ctx.item) then
                    return "󱓻 "
                  end
                  return ctx.kind_icon .. ctx.icon_gap
                end,
                highlight = function(ctx)
                  return "BlinkCmpKind" .. ctx.kind
                end,
              },
              source_name = {
                width = { max = 5 },
                text = function(ctx)
                  local names = { lsp = "LSP", snippets = "SNP", buffer = "BUF", copilot = "AI" }
                  return "[" .. (names[ctx.source_name:lower()] or ctx.source_name:sub(1, 3)) .. "]"
                end,
                highlight = "BlinkCmpSource",
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          window = { border = "rounded" },
        },
      },

      sources = {
        default = { "lsp", "copilot", "path", "snippets", "buffer" },
        providers = {
          copilot = {
            module = "blink-copilot",
            name = "copilot",
            score_offset = 100,
            async = true,
          },
        },
      },

      keymap = {
        preset = "enter",
        -- Priority: blink menu → snippet → sidekick NES → raw tab
        ["<Tab>"] = {
          "select_next",
          "snippet_forward",
          function(_cmp)
            return require("sidekick").nes_jump_or_apply()
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      },
    },
    opts_extend = { "sources.default" },
  },
}
