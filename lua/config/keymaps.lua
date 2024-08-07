local mapkey = require("util.keymapper").mapvimkey
-- mapvimkey(keymaps, command, vimmode, options)

-- Pane and Window Navigation
mapkey("<leader>wk", "<C-w>k", "n") -- Navigate up
mapkey("<leader>wj", "<C-w>j", "n") -- Navigate down
mapkey("<leader>wh", "<C-w>h", "n") -- Navigate left
mapkey("<leader>wl", "<C-w>l", "n") -- Navigate right
mapkey("<leader>wk", "wincmd k", "n") -- Navigate up
mapkey("<leader>wj", "wincmd j", "n") -- Navigate down
mapkey("<leader>wh", "wincmd h", "n") -- Navigate left
mapkey("<leader>wl", "wincmd l", "n") -- Navigate right
