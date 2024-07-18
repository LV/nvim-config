return {
  "glepnir/template.nvim",
  cmd = { "Template", "TemProject" },
  config = function()
    require('template').setup({
      temp_dir = "$XDG_CONFIG_HOME/nvim/lua/templates", --template directory
      author = "Luis Victoria",
      email = "v@lambda.lv",
    })
  end
}
