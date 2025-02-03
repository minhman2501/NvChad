require "nvchad.mappings"

-- add yours here
local map = vim.keymap.set
local del = vim.keymap.del

local tabufline = require "nvchad.tabufline"

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- del("n", "<Tab>")
-- del("n", "<S-Tab>")
del("n", "<leader>x")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
local mappings = {
  n = {
    --Tmux Navigation
    ["<C-h>"] = { "<cmd>TmuxNavigateLeft<cr>", "window left" },
    ["<C-j>"] = { "<cmd>TmuxNavigateDown<cr>", "window down" },
    ["<C-k>"] = { "<cmd>TmuxNavigateUp<cr>", "window up" },
    ["<C-l>"] = { "<cmd>TmuxNavigateRight<cr>", "window right" },
    --Buffer
    ["<S-l>"] = {
      function()
        tabufline.next()
      end,
      "Buffer goto next",
    },
    ["<S-h>"] = {
      function()
        tabufline.prev()
      end,
      "Buffer goto previous",
    },
    ["<C-q>"] = {
      function()
        tabufline.close_buffer()
      end,
      "Buffer close",
    },
  },
}

for mode, maps in pairs(mappings) do
  for key, val in pairs(maps) do
    map(mode, key, val[1], { desc = val[2] })
  end
end
