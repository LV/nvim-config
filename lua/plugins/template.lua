local config = function()
  require('template').setup({
    temp_dir = "$XDG_CONFIG_HOME/nvim/lua/templates", --template directory
    author = "Luis Victoria",
    email = "v@lambda.lv",
  })
end

return {
  "nvimdev/template.nvim",
  cmd = { "Template", "TemProject" },
  config = config,
}

-- Template grammar
-- `{{_date_}}` insert current date
-- `{{_cursor_}}` set cursor here
-- `{{_file_name_}}` current file name
-- `{{_author_}}` author info
-- `{{_email_}}` email address
-- `{{_variable_}}` variable name
-- `{{_upper_file_}}` all-caps file name
-- `{{_lua:vim.fn.expand(%:.:r)_}}` set by lua script
