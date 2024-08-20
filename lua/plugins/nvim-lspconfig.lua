-- See https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
local M = {}

M.config = function()
	require("neoconf").setup({})
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local lspconfig = require("lspconfig")
	local capabilities = cmp_nvim_lsp.default_capabilities()

	local on_attach = require("util.lsp").on_attach
	local diagnostic_signs = require("util.icons").diagnostic_signs
	local typescript_organise_imports = require("util.lsp").typescript_organise_imports

	-- Set up diagnostic signs
	for type, icon in pairs(diagnostic_signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	-- Lazy-load LSP configurations
	local server_configs = {
		bashls = {
			filetypes = { "sh", "aliasrc" },
		},
		clangd = {
			filetypes = { "c", "cpp" },
			cmd = { "clangd", "--offset-encoding=utf-16" },
		},
		dockerls = {
			filetypes = { "dockerfile" },
		},
		jsonls = {
			filetypes = { "json", "jsonc" },
		},
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
			commands = { TypeScriptOrganizeImports = typescript_organise_imports },
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
			on_attach = on_attach,
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
		local prettier_d = require("efmls-configs.formatters.prettier_d")
		local luacheck = require("efmls-configs.linters.luacheck")
		local stylua = require("efmls-configs.formatters.stylua")
		local flake8 = require("efmls-configs.linters.flake8")
		local black = require("efmls-configs.formatters.black")
		local eslint = require("efmls-configs.linters.eslint")
		local fixjson = require("efmls-configs.formatters.fixjson")
		local shellcheck = require("efmls-configs.linters.shellcheck")
		local shfmt = require("efmls-configs.formatters.shfmt")
		local hadolint = require("efmls-configs.linters.hadolint")
		local cpplint = require("efmls-configs.linters.cpplint")
		local clangformat = require("efmls-configs.formatters.clang_format")

		efm_languages = {
			lua = { luacheck, stylua },
			python = { flake8, black },
			typescript = { eslint, prettier_d },
			json = { eslint, fixjson },
			jsonc = { eslint, fixjson },
			sh = { shellcheck, shfmt },
			javascript = { eslint, prettier_d },
			javascriptreact = { eslint, prettier_d },
			typescriptreact = { eslint, prettier_d },
			svelte = { eslint, prettier_d },
			vue = { eslint, prettier_d },
			markdown = { prettier_d },
			docker = { hadolint, prettier_d },
			html = { prettier_d },
			css = { prettier_d },
			c = { clangformat, cpplint },
			cpp = { clangformat, cpplint },
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

return {
	"neovim/nvim-lspconfig",
	config = M.config,
	lazy = false,
	dependencies = {
		"windwp/nvim-autopairs",
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
