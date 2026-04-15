return {
  "folke/sidekick.nvim",
  opts = {},
  keys = {
    {
      "<leader>af",
      function()
        require("sidekick.cli").focus { name = "copilot" }
      end,
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle { name = "copilot", focus = true }
      end,
      desc = "Sidekick Toggle Copilot",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Sidekick Detach Session",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send { name = "copilot", msg = "{selection}" }
      end,
      mode = { "x" },
      desc = "Sidekick Send Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
  },
}
