-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local M = {}

M.config = function()
  local function lazy_require(module)
    return setmetatable({}, {
      __index = function(_, key)
        return require(module)[key]
      end,
    })
  end

  local lspconfig = lazy_require("lspconfig")
  local cmp_nvim_lsp = lazy_require("cmp_nvim_lsp")
  local util = {
    lsp = lazy_require("util.lsp"),
    icons = lazy_require("util.icons"),
  }

  local capabilities = cmp_nvim_lsp.default_capabilities()

  -- Set up diagnostic signs
  for type, icon in pairs(util.icons.diagnostic_signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
  end

  -- Define server configurations
  local server_configs = {
    bashls = { filetypes = { "sh", "aliasrc" } },
    clangd = {
      filetypes = { "c", "cpp" },
      cmd = { "clangd", "--offset-encoding=utf-16" },
    },
    dockerls = { filetypes = { "dockerfile" } },
    emmet_ls = {
      filetypes = {
        "css", "html", "javascript", "javascriptreact", "less", "sass",
        "scss", "svelte", "typescript", "typescriptreact", "vue",
      },
    },
    jsonls = { filetypes = { "json", "jsonc" } },
    lua_ls = {
      filetypes = { "lua" },
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = {
              vim.fn.expand("$VIMRUNTIME/lua"),
              vim.fn.expand("$XDG_CONFIG_HOME") .. "/nvim/lua",
            },
          },
        },
      },
    },
    nixd = {
      filetypes = { "nix" },
      root_dir = function(fname)
        return lspconfig.util.root_pattern("flake.nix", ".git")(fname)
          or lspconfig.util.find_git_ancestor(fname)
          or lspconfig.util.path.dirname(fname)
      end,
      cmd = { "nixd" },
      single_file_support = true,
    },
    pyright = {
      filetypes = { "python" },
      settings = {
        python = {
          analysis = {
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            autoImportCompletions = true,
          },
        },
      },
    },
    ts_ls = {
      filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
      commands = {
        TypeScriptOrganizeImports = util.lsp.typescript_organise_imports,
      },
      settings = { typescript = { indentStyle = "space", indentSize = 2 } },
      root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
    },
  }

  -- Function to set up a server
  local function setup_server(server_name)
    local config = vim.tbl_deep_extend("force", {
      capabilities = capabilities,
      on_attach = util.lsp.on_attach,
    }, server_configs[server_name] or {})
    lspconfig[server_name].setup(config)
  end

  -- Set up servers explicitly
  local servers_to_setup = vim.tbl_keys(server_configs)
  for _, server in ipairs(servers_to_setup) do
    setup_server(server)
  end

  -- Lazy-load EFM server configuration remains the same
  local efm_languages = {}
  local efm_filetypes = {
    "c", "css", "cpp", "html", "javascript", "javascriptreact", "json", "jsonc",
    "lua", "markdown", "python", "sh", "typescript", "typescriptreact", "yaml",
  }

  local efm_config_loaded = false

  local function load_efm_config(ft)
    if efm_languages[ft] then return end

    local configs = {
      c = { "clang_format", "cpplint" },
      css = { "prettier_d" },
      cpp = { "clang_format", "cpplint" },
      html = { "prettier_d" },
      javascript = { "eslint", "prettier_d" },
      javascriptreact = { "eslint", "prettier_d" },
      json = { "eslint", "fixjson" },
      jsonc = { "eslint", "fixjson" },
      lua = { "luacheck", "stylua" },
      markdown = { "prettier_d" },
      python = { "flake8", "black" },
      sh = { "shellcheck", "shfmt" },
      typescript = { "eslint", "prettier_d" },
      typescriptreact = { "eslint", "prettier_d" },
      yaml = { "yamllint" },
    }

    if configs[ft] then
      efm_languages[ft] = {}
      for _, tool in ipairs(configs[ft]) do
        local ok, config = pcall(require, "efmls-configs." .. (tool:match("^%a+") == "efmls" and "linters" or "formatters") .. "." .. tool)
        if ok then
          table.insert(efm_languages[ft], config)
        else
          vim.notify("Failed to load " .. tool .. " for filetype " .. ft, vim.log.levels.WARN)
        end
      end
    end
  end

  local function setup_efm()
    if efm_config_loaded then return end

    lspconfig.efm.setup({
      filetypes = efm_filetypes,
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
      },
      settings = {
        languages = efm_languages,
      },
    })

    efm_config_loaded = true
  end

  -- Set up EFM server lazily
  vim.api.nvim_create_autocmd("FileType", {
    pattern = efm_filetypes,
    callback = function()
      local ft = vim.bo.filetype
      load_efm_config(ft)
      setup_efm()
    end,
  })
end

-- Load the LSP setup
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = M.config,
  dependencies = {
    { "windwp/nvim-autopairs", event = "InsertEnter" },
    "williamboman/mason.nvim",
    "creativenull/efmls-configs-nvim",
    { "hrsh7th/nvim-cmp", event = "InsertEnter" },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
  },
}
