local agent_name = "copilot"

return {
  "folke/sidekick.nvim",
  opts = {},
  keys = {
    {
      "<leader>af",
      function()
        require("sidekick.cli").focus { name = agent_name }
      end,
      desc = "Sidekick Focus",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle { name = agent_name, focus = true }
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
        require("sidekick.cli").send { name = agent_name, msg = "{selection}" }
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
