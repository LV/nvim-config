-- Because of specific loading requirements, everything
-- LSP related will live inside of this file

-- Because of specific loading requirements, everything
-- LSP related will live inside of this file

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    cmd = {"Mason", "MasonInstall", "MasonUninstall", "MasonLog"},
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
          }
        }
      })
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
    },
    config = function()
      require("mason-lspconfig").setup({
        -- Specify servers you want automatically installed and set up
        ensure_installed = {
          -- Add other servers here that you want automatically installed
          -- "lua_ls",
          -- "pyright",
          -- "rust_analyzer",
          -- "tsserver",
        },
        -- Automatically install servers configured via lspconfig
        automatic_installation = true,
      })

      -- This is the crucial part for automatic server setup
      require("mason-lspconfig").setup_handlers({
        -- Default handler for installed servers
        function(server_name)
          require("lspconfig")[server_name].setup({
            -- You can specify server-specific settings here if needed
            -- For example:
            -- settings = { ... }
          })
        end,

        -- You can also set up server-specific handlers
        -- For example, to add special settings for lua_ls:
        -- ["lua_ls"] = function()
        --   require("lspconfig").lua_ls.setup({
        --     settings = {
        --       Lua = {
        --         diagnostics = {
        --           globals = { "vim" }
        --         },
        --         workspace = {
        --           library = vim.api.nvim_get_runtime_file("", true),
        --           checkThirdParty = false,
        --         },
        --         telemetry = {
        --           enable = false,
        --         },
        --       }
        --     }
        --   })
        -- end,
        -- Add more server-specific handlers as needed
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      -- Completion plugins
      { "windwp/nvim-autopairs", event = "InsertEnter" },
      { "hrsh7th/nvim-cmp", event = "InsertEnter" },
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-nvim-lsp",
    },
    -- We don't need a config function here because the config
    -- is already handled in mason-lspconfig
  },
}
