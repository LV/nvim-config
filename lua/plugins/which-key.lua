-- display popup with keybindings of command you start typing
return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.nvim" },
  event = "VeryLazy",
  opts = {
    spec = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },

      -- LSP
      { "<leader>c", group = "code" },
        -- clangd
      { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Code action" },
      { "<leader>cc", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Show code context" },
      { "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "Go to definition" },
      { "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "Go to declaration" },
      { "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "Go to implementation" },
      { "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "Find references" },
      { "<leader>cR", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },

      { "<leader>f", group = "file" },
      { "<leader>g", group = "git" },

      -- Template
      { "<leader>t", group = "template" },
      { "<leader>tc", group = "cpp" },
      { "<leader>tch", "<cmd>Template cpp/header<CR>", desc = "Load C++ header template" },
      { "<leader>tcs", "<cmd>Template cpp/source()<CR>", desc = "Load C++ source template" },
    },
  },
}

