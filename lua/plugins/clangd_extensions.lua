return {
  { "p00f/clangd_extensions.nvim" },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    cmd = "LspInfo",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local wk = require("which-key")
      local on_attach = function(client, bufnr)
        -- Mappings
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local opts = { noremap=true, silent=true }

        -- LSP related keymaps with leader key
        buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", vim.tbl_extend("force", opts, { desc = "Code action" }))
        buf_set_keymap("n", "<leader>cc", "<cmd>lua vim.lsp.buf.hover()<CR>", vim.tbl_extend("force", opts, { desc = "Show code context" }))
        buf_set_keymap("n", "<leader>cd", "<cmd>lua vim.lsp.buf.definition()<CR>", vim.tbl_extend("force", opts, { desc = "Go to definition" }))
        buf_set_keymap("n", "<leader>cD", "<cmd>lua vim.lsp.buf.declaration()<CR>", vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
        buf_set_keymap("n", "<leader>ci", "<cmd>lua vim.lsp.buf.implementation()<CR>", vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
        buf_set_keymap("n", "<leader>cr", "<cmd>lua vim.lsp.buf.references()<CR>", vim.tbl_extend("force", opts, { desc = "Find references" }))
        buf_set_keymap("n", "<leader>cR", "<cmd>lua vim.lsp.buf.rename()<CR>", vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

        -- Register with which-key
        wk.register({
          ["<leader>c"] = {
            name = "+code",
            a = "Code action",
            c = "Show code context",
            d = "Go to definition",
            D = "Go to declaration",
            i = "Go to implementation",
            r = "Find references",
            R = "Rename symbol",
          },
        }, { buffer = bufnr })

        -- Set up clangd_extensions
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
      end

      -- Setup for clangd
      lspconfig["clangd"].setup({
        on_attach = on_attach,
        cmd = {
          "clangd",
          "--suggest-missing-includes",
        },
        init_options = {
          clangdFileStatus = true,
          usePlaceholders = true,
          completeUnimported = true,
          semanticHighlighting = true,
        },
      })
    end,
  },
}
