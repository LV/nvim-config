local config = function ()
  vim.keymap.set("n", "<leader>t", function()
    require("taskwarrior_nvim").browser({"ready"})
  end, { noremap = true, silent = true, desc = "Taskwarrior" })
end

return {
  "ribelo/taskwarrior.nvim",
  opts = {
    filter = { "noice", "nofile" }, -- Filtered buffer_name and buffer_type.
    task_file_name = ".taskwarrior.json",
    -- After what period of time should a task be halted due to inactivity?
    granulation = 60 * 1000 * 10,
    notify_start = true, -- Should a notification pop up after starting the task?
    notify_stop = true,
    notify_error = true,
  },
  config = config,
  event = "VeryLazy",
}
