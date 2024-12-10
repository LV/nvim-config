local mapkey = require("util.keymapper").mapvimkey

local M = {}

M.on_attach = function(client, bufnr)
	local opts = { noremap = true, silent = true, buffer = bufnr }

	mapkey("<leader>cfd", "Lspsaga finder", "n", opts) -- go to definition
	mapkey("<leader>cgd", "Lspsaga peek_definition", "n", opts) -- peak definition
	mapkey("<leader>cgD", "Lspsaga goto_definition", "n", opts) -- go to definition
	mapkey("<leader>cgS", "vsplit | Lspsaga goto_definition", "n", opts) -- go to definition
	mapkey("<leader>cca", "Lspsaga code_action", "n", opts) -- see available code actions
	mapkey("<leader>crn", "Lspsaga rename", "n", opts) -- smart rename
	mapkey("<leader>cD", "Lspsaga show_line_diagnostics", "n", opts) -- show  diagnostics for line
	mapkey("<leader>cd", "Lspsaga show_cursor_diagnostics", "n", opts) -- show diagnostics for cursor
	mapkey("<leader>cpd", "Lspsaga diagnostic_jump_prev", "n", opts) -- jump to prev diagnostic in buffer
	-- mapkey("<leader>cnd", "Lspsaga diagnostic_jump_next", "n", opts) -- jump to next diagnostic in buffer
	mapkey("K", "Lspsaga hover_doc", "n", opts) -- show documentation for what is under cursor

	if client.name == "pyright" then
		mapkey("<leader>coi", "PyrightOrganizeImports", "n", opts) -- organise imports
		mapkey("<leader>cdb", "DapToggleBreakpoint", "n", opts) -- toggle breakpoint
		mapkey("<leader>cdr", "DapContinue", "n", opts) -- continue/invoke debugger
		mapkey("<leader>cdt", "lua require('dap-python').test_method()", "n", opts) -- run tests
	end

	if client.name == "tsserver" then
		mapkey("<leader>coi", "TypeScriptOrganizeImports", "n", opts) -- organise imports
	end
end

M.typescript_organise_imports = {
	description = "Organise Imports",
	function()
		local params = {
			command = "_typescript.organizeImports",
			arguments = { vim.fn.expand("%:p") },
		}
		-- reorganise imports
		vim.lsp.buf.execute_command(params)
	end,
}

return M
