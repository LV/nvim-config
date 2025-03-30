-- Because of specific loading requirements, everything
-- LSP related will live inside of this file

-- Because of specific loading requirements, everything
-- LSP related will live inside of this file

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonLog"},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    lazy = false,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup()
    end,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
     { "windwp/nvim-autopairs", event = "InsertEnter" },
     { "hrsh7th/nvim-cmp", event = "InsertEnter" },
     "hrsh7th/cmp-buffer",
     "hrsh7th/cmp-nvim-lsp",
    },
    lazy = false,
  },
}
