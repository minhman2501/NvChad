require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set
local del = vim.keymap.del
local tabufline = require("nvchad.tabufline")

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

--Buffer
del('n', '<Tab>')
del('n', '<S-Tab>')
del('n', '<leader>x')

map("n", "<S-l>", function()
  tabufline.next()
end, { desc = "buffer goto next" })

map("n", "<S-h>", function()
  tabufline.prev()
end, { desc = "buffer goto prev" })

map("n", "<C-q>", function()
  tabufline.close_buffer()
end, { desc = "buffer close" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
