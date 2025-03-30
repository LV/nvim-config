-- Because of specific loading requirements, everything
-- LSP related will live inside of this file

-- If for some reason you can't use Mason (e.g. proxy), then change
-- this variable to false
local useMason = true

if useMason then
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

else
  -- Fallback code in case Mason cannot be used

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
        -- Include `.h` here so clangd can handle them
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
      gopls = {
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        cmd = { "gopls" },
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      },
      golangci_lint_ls = {
        cmd = { "golangci-lint-langserver" },
        filetypes = { "go", "gomod" },
        init_options = {
          command = { "golangci-lint", "run", "--out-format", "json" },
        },
      },
      rust_analyzer = {
        filetypes = { "rust" },
        cmd = { "rust-analyzer" },
        settings = {
          ["rust-analyzer"] = {
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
            procMacro = { enable = true },
          },
        },
        root_dir = function(fname)
          return lspconfig.util.root_pattern("Cargo.toml", "rust-project.json")(fname)
            or lspconfig.util.find_git_ancestor(fname)
            or vim.fn.getcwd()
        end,
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
      basedpyright = {
        filetypes = { "python" },
        python = {
          analysis = {
            useLibraryCodeForTypes = true,
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            autoImportCompletions = true,
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
      tinymist = {
        filetypes = { "typst" },
        settings = {
          exportPdf = "onType",
          outputPath = "$root/$dir/$name",
          semanticTokens = "enable",
          systemFonts = true,
        },
        root_dir = function(fname)
          return lspconfig.util.root_pattern(".git", "typst.toml")(fname)
            or lspconfig.util.find_git_ancestor(fname)
            or vim.fn.getcwd()
        end,
        cmd = { "tinymist" },
      },
      zls = {
        filetypes = { "zig" },
        cmd = { "zls" },
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

    -- Automatically guess `.h` filetype based on neighboring files
    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = "*.h",
      callback = function()
        local fname = vim.fn.expand("%:r") -- file name without extension
        if vim.fn.glob(fname .. ".cpp") ~= "" or vim.fn.glob(fname .. ".cc") ~= "" or vim.fn.glob(fname .. ".cxx") ~= "" then
          vim.bo.filetype = "cpp"
        elseif vim.fn.glob(fname .. ".c") ~= "" then
          vim.bo.filetype = "c"
        else
          -- Default to C++ if unsure
          vim.bo.filetype = "cpp"
        end
      end,
    })

    -- EFM configuration
    local efm_config_loaded = false

    -- Try loading efmls configs for clang tools
    local ok_clang_tidy, clang_tidy = pcall(require, "efmls-configs.linters.clang_tidy")
    local ok_clang_format, clang_format = pcall(require, "efmls-configs.formatters.clang_format")

    -- Fallback if efmls-configs not installed or linters/formatters not found
    if not ok_clang_tidy then
      clang_tidy = {
        lintCommand = "clang-tidy --quiet --extra-arg=-std=c++17 --",
        lintStdin = true,
        lintFormats = { "%f:%l:%c: %m" },
      }
    end
    if not ok_clang_format then
      clang_format = {
        formatCommand = "clang-format --style=Google",
        formatStdin = true,
      }
    end

    local efm_languages = {
      c = { clang_tidy, clang_format },
      cpp = { clang_tidy, clang_format },
      lua = {
        {
          lintCommand = "luacheck --formatter plain --codes -",
          lintStdin = true,
          lintFormats = { "%f:%l:%c: %m" },
        },
      },
      css = {},
      html = {},
      javascript = {},
      javascriptreact = {},
      json = {},
      jsonc = {},
      markdown = {},
      python = {},
      sh = {},
      typescript = {},
      typescriptreact = {},
      yaml = {},
    }

    -- We now include `h` as well. Since we set it dynamically above, it will either appear as `c` or `cpp` after the autocmd
    local efm_filetypes = {
      "c", "cpp", "lua", "css", "html", "javascript", "javascriptreact",
      "json", "jsonc", "markdown", "python", "sh", "typescript",
      "typescriptreact", "yaml",
      -- We don't explicitly list "h" here, because after the autocmd it's either `c` or `cpp`.
    }

    local function load_efm_config(ft)
      -- If you had previously tried to dynamically load configs, you can remove or adjust it here
      -- Since we have a static configuration, we don't really need dynamic loading
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
        on_attach = util.lsp.on_attach,
        capabilities = capabilities,
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
end
