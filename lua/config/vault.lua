-- Configuration options for obsidian vault
local function get_hostname()
  local handle = io.popen("hostname") -- Runs the hostname command
  if handle then
    local hostname = handle:read("*a"):gsub("\n", "") -- Removes the newline
    handle:close()
    return hostname
  else
    return nil
  end
end

local hostname = get_hostname()
if hostname == "lvictoria7" then
  VaultPath = "~/bbvault"
else
  VaultPath = "~/vault"
end
