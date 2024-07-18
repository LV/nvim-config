return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup()

    -- Basic keymaps
    vim.keymap.set("n", "<leader>fa", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>ff", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

    vim.keymap.set("n", "<leader>fj", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>fk", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>fl", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>f;", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>fq", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>fe", function() harpoon:list():next() end)
  end,
  keys = {
    { "<leader>fa", desc = "Harpoon add" },
    { "<leader>ff", desc = "Harpoon quick menu" },
    { "<leader>fj", desc = "Harpoon select 1" },
    { "<leader>fk", desc = "Harpoon select 2" },
    { "<leader>fl", desc = "Harpoon select 3" },
    { "<leader>f;", desc = "Harpoon select 4" },
    { "<leader>fq", desc = "Harpoon prev" },
    { "<leader>fe", desc = "Harpoon next" },
  },
}
