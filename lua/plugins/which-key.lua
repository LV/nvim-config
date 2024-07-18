-- display popup with keybindings of command you start typing
return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300 --milliseconds; amount of time before which-key popup shows up after pressing <leader>
  end,
  opts = {
    defaults = {
      -- group prefix names
      ["<leader>c"] = { name = "+code" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>t"] = { name = "+template",
                        c = { name = "+cpp" },
                      },
      ["<leader>w"] = { name = "+windows" },
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register({
      -- templates
      ["<leader>tch"] = { ":Template cpp/header<CR>", "Load C++ header template" },
      ["<leader>tcs"] = { ":Template cpp/source<CR>", "Load C++ source template" },
    }, opts.defaults)
  end,
}
