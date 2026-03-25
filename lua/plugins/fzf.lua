return {
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
  },
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = "FzfLua",
    config = function(_, opts)
      require("fzf-lua").setup(opts)
    end,
  },
}
