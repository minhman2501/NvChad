return {
  "f-person/git-blame.nvim",
  -- load the plugin at startup
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    enabled = true,
    message_template = "<author> • <date> • <summary> • <<sha>>",
    date_format = "%r • %b %d, %Y %H:%M",
    virtual_text_column = 1,
  },
}
