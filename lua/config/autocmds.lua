-- Disable line numbers when entering terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  callback = function()
    vim.wo.number = false  -- Disable line numbers
    vim.wo.relativenumber = false  -- Disable relative numbers (if enabled)
  end,
}) -- TODO: Fix this. Works when you first launch terminal, but if you open a buffer and then quit to return to terminal, the lines appear again

-- Optional: Re-enable line numbers when leaving terminal mode
vim.api.nvim_create_autocmd("BufLeave", {
  pattern = "term://*",
  callback = function()
    vim.wo.number = true  -- Re-enable line numbers
    vim.wo.relativenumber = true  -- Re-enable relative numbers (if needed)
  end,
})
