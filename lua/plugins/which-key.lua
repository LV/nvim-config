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
      opts.defaults,
      -- LSP
        -- Clangd
      ["<leader>ca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
      ["<leader>cc"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show code context" },
      ["<leader>cd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
      ["<leader>cD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
      ["<leader>ci"] = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Go to implementation" },
      ["<leader>cr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find references" },
      ["<leader>cR"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },

      -- Templates
      ["<leader>tch"] = { ":Template cpp/header<CR>", "Load C++ header template" },
      ["<leader>tcs"] = { ":Template cpp/source<CR>", "Load C++ source template" },
    })
  end,
}
