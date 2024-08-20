-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
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

	-- Lazy-load LSP configurations
	local server_configs = {
		bashls = { filetypes = { "sh", "aliasrc" } },
		clangd = {
			filetypes = { "c", "cpp" },
			cmd = { "clangd", "--offset-encoding=utf-16" },
		},
		dockerls = { filetypes = { "dockerfile" } },
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
		pyright = {
			filetypes = { "python" },
			settings = {
				pyright = {
					disableOrganizeImports = false,
					analysis = {
						useLibraryCodeForTypes = true,
						autoSearchPaths = true,
						diagnosticMode = "workspace",
						autoImportCompletions = true,
					},
				},
			},
		},
		tsserver = {
			filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			commands = {
				TypeScriptOrganizeImports = util.lsp.typescript_organise_imports,
			},
			settings = { typescript = { indentStyle = "space", indentSize = 2 } },
			root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git"),
		},
		emmet_ls = {
			filetypes = {
				"javascriptreact", "typescriptreact", "javascript", "css", "sass",
				"scss", "less", "svelte", "vue", "html",
			},
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

	-- Set up servers lazily
	vim.api.nvim_create_autocmd("FileType", {
		pattern = vim.tbl_keys(server_configs),
		callback = function()
			local ft = vim.bo.filetype
			for server, config in pairs(server_configs) do
				if vim.tbl_contains(config.filetypes or {ft}, ft) then
					setup_server(server)
				end
			end
		end,
	})

	-- Lazy-load EFM server configuration
	local efm_languages = {}
	local efm_filetypes = {
		"c", "cpp", "lua", "python", "json", "jsonc", "sh", "javascript",
		"javascriptreact", "typescript", "typescriptreact", "svelte", "vue",
		"markdown", "docker", "html", "css",
	}

	local function setup_efm()
		local function load_efm_config(type, name)
			local ok, config = pcall(require, string.format("efmls-configs.%s.%s", type, name))
			if ok then
				return config
			else
				vim.notify(string.format("Failed to load %s %s", type, name), vim.log.levels.WARN)
				return {}
			end
		end

		efm_languages = {
			lua = { load_efm_config("linters", "luacheck"), load_efm_config("formatters", "stylua") },
			python = { load_efm_config("linters", "flake8"), load_efm_config("formatters", "black") },
			typescript = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "prettier_d") },
			json = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "fixjson") },
			jsonc = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "fixjson") },
			sh = { load_efm_config("linters", "shellcheck"), load_efm_config("formatters", "shfmt") },
			javascript = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "prettier_d") },
			javascriptreact = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "prettier_d") },
			typescriptreact = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "prettier_d") },
			svelte = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "prettier_d") },
			vue = { load_efm_config("linters", "eslint"), load_efm_config("formatters", "prettier_d") },
			markdown = { load_efm_config("formatters", "prettier_d") },
			docker = { load_efm_config("linters", "hadolint"), load_efm_config("formatters", "prettier_d") },
			html = { load_efm_config("formatters", "prettier_d") },
			css = { load_efm_config("formatters", "prettier_d") },
			c = { load_efm_config("formatters", "clang_format"), load_efm_config("linters", "cpplint") },
			cpp = { load_efm_config("formatters", "clang_format"), load_efm_config("linters", "cpplint") },
		}

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
	end

	-- Set up EFM server lazily
	vim.api.nvim_create_autocmd("FileType", {
		pattern = efm_filetypes,
		callback = function()
			if not efm_languages[vim.bo.filetype] then
				setup_efm()
			end
		end,
		once = true,
	})
end

-- Lazy-load the entire LSP setup
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
