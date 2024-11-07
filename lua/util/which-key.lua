require("util/input-prompt")

-- 'Create Note' Functions
function CreateAtomicNote()
  local input_title = PromptInput("Atomic Note Title: ")
  if input_title and input_title ~= "" then
    vim.cmd(string.format("ObsidianNew Atomic/%s.md", input_title))
    -- Set the frontmatter
    vim.schedule(function()
      local frontmatter = string.format([[---
id: "%s"
aliases:
  - %s
tags:
  - atomic-note
---
]],
        os.date("%Y%m%d%H%M%S"),  -- id
        input_title  -- alias
      )

      -- Replace entire buffer content with our new content
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(frontmatter, "\n", {}))
    end)
  end
end

function CreateFleetingNote()
  vim.cmd(string.format("ObsidianNew Fleeting/%s.md", os.date("%Y%m%d%H%M%S")))
  vim.schedule(function()
    local frontmatter = string.format([[---
id: "%s"
aliases:
  - null
tags:
  - fleeting-note
  dt
---
]],
      os.date("%Y%m%d%H%M%S")
    )

    -- Replace entire buffer content with our new content
    vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split(frontmatter, "\n", {}))
  end)
end

function CreateNote()
  local input_title = PromptInput("Note Title: ")
  if input_title and input_title ~= "" then
    vim.cmd(string.format("ObsidianNew Notes/%s.md", input_title))
    vim.schedule(function()
      vim.api.nvim_buf_set_lines(0, 0, -1, false, vim.split("", "\n", {}))
    end)
  end
end
