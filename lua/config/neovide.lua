-- Docs: https://neovide.dev/configuration.html

vim.o.guifont = "PragmataPro Mono Liga:h19"
vim.g.neovide_transparency = 1.0 -- TODO: Make it so that transparency is 1.0 if launching from WSL (Maybe add a custom flag), set to 0.75 otherwise


-- Override configuration variables if launching on Neovide
if vim.g.neovide then
  vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
      vim.cmd("silent! cd ~")
    end
  })
end
