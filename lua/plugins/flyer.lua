return {
  "A7Lavinraj/fyler.nvim",
  dependencies = {
    {
      "nvim-mini/mini.icons",
      config = function()
        require("mini.icons").setup()
        -- This magic line forces mini.icons to pretend to be the default engine,
        -- guaranteeing Fyler picks up the correct React/TypeScript Nerd Fonts.
        require("mini.icons").mock_nvim_web_devicons()
      end,
    },
  },

  -- Fyler strongly recommends setting lazy = false so it can properly
  -- hijack the default netrw explorer when you open a directory.
  lazy = false,

  -- This replaces your old nvim-tree keymap
  keys = {
    {
      "<leader>e",
      function()
        -- Tell fyler explicitly to open as a floating window
        require("fyler").open { kind = "float" }
      end,
      desc = "Open Fyler (Float)",
    },
  },

  opts = {
    -- You can customize your floating window dimensions/borders here if needed
    -- depending on the latest v2 API in :help fyler.nvim
  },
  config = function(_, opts)
    require("fyler").setup(opts)

    -- 1. Function to set the base Fyler colors (from Setup 2)
    local function set_fyler_colors()
      local colors = require("base46").get_theme_tb "base_30"
      local base_16 = require("base46").get_theme_tb "base_16"

      -- PERFECT FOLDERS: Target Fyler's specific groups
      vim.api.nvim_set_hl(0, "FylerFSDirectoryName", { fg = colors.blue, bold = true })
      vim.api.nvim_set_hl(0, "FylerFSDirectoryIcon", { fg = colors.blue })
      pcall(vim.api.nvim_set_hl, 0, "FylerFSFileName", { fg = base_16.base05 })

      -- Background and Borders
      vim.api.nvim_set_hl(0, "FylerNormal", { link = "NormalFloat" })
      vim.api.nvim_set_hl(0, "FylerBorder", { link = "FloatBorder" })
    end

    -- Run folder color fixes on startup and theme change
    set_fyler_colors()
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = set_fyler_colors,
    })

    -- 2. The FileType Autocmd (The magic that fixed the title in Setup 1)
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "fyler",
      callback = function()
        -- Add the container padding back
        vim.opt_local.signcolumn = "yes:1"

        -- PERFECT TITLE: Force the title right as the window opens
        local colors = require("base46").get_theme_tb "base_30"
        vim.api.nvim_set_hl(0, "FloatTitle", { fg = colors.blue, bg = "NONE", bold = true })
        pcall(vim.api.nvim_set_hl, 0, "FylerTitle", { fg = colors.blue, bg = "NONE", bold = true })
      end,
    })
  end,
}
