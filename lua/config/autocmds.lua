-- File-specific line indentation
local function set_indentation_settings(filetype_opts)
  local group = vim.api.nvim_create_augroup("IndentationSettings", { clear = true })
  for filetype, opts in pairs(filetype_opts) do
    vim.api.nvim_create_autocmd("FileType", {
      group = group,
      pattern = filetype,
      command = string.format("setlocal %s shiftwidth=%d tabstop=%d", opts.expandtab and "expandtab" or "noexpandtab", opts.shiftwidth, opts.tabstop)
    })
  end
end

set_indentation_settings({
  go = {
    expandtab = false,
    shiftwidth = 4,
    tabstop = 4,
  },

  json = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },

  lua = {
    expandtab = true,
    shiftwidth = 2,
    tabstop = 2,
  },
})
