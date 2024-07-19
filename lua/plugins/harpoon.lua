return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    local harpoon = require("harpoon")

    -- REQUIRED
    harpoon:setup({})

    -- Use Telescope as UI
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
          results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
      }):find()
    end

    -- Basic keymaps
    vim.keymap.set("n", "<leader>fa", function() harpoon:list():add() end)
    vim.keymap.set("n", "<leader>ff", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    -- vim.keymap.set("n", "<leader>ff", function() toggle_telescope(harpoon:list()) end) --use if you prefer to use Telescope's UI

    vim.keymap.set("n", "<leader>fj", function() harpoon:list():select(1) end)
    vim.keymap.set("n", "<leader>fk", function() harpoon:list():select(2) end)
    vim.keymap.set("n", "<leader>fl", function() harpoon:list():select(3) end)
    vim.keymap.set("n", "<leader>f;", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    vim.keymap.set("n", "<leader>fi", function() harpoon:list():prev() end)
    vim.keymap.set("n", "<leader>fo", function() harpoon:list():next() end)
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
