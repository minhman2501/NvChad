local opts = {
  -- your configuration comes here
  enabled = true,
  message_template = "<author> • <date> • <summary> • <<sha>>",
  date_format = "%B, %d-%Y %H:%M",
  virtual_text_column = 1,
}

return opts
