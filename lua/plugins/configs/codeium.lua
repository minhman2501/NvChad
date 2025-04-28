local config = function()
  local cwd = vim.fn.getcwd()
  if cwd:find "Project" then
    return
  end

  require("codeium").setup {}
end

return config
