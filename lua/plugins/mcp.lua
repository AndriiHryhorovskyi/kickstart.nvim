local function create_default_config()
  local config_path = vim.fn.expand '~/.config/mcphub/servers.json'
  local config_dir = vim.fn.expand '~/.config/mcphub'
  -- Check if the config directory exists
  local dir_exists = vim.fn.isdirectory(config_dir) == 1
  if not dir_exists then
    vim.fn.mkdir(config_dir, 'p')
  end

  -- Check if the file already exists
  local file = io.open(config_path, 'r')
  if file then
    file:close()
    return -- File already exists, so do nothing
  end

  -- Create the file
  local file = io.open(config_path, 'w')
  if file then
    file:write '{"mcpServers": {}}'
    file:close()
    print('Created ' .. config_path .. ' for mcphub.nvim')
  else
    print('Error creating ' .. config_path)
  end
end

return {
  'ravitemer/mcphub.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required for Job and HTTP requests
  },
  -- uncomment the following line to load hub lazily
  --cmd = "MCPHub",  -- lazy load
  -- build = 'npm install -g mcp-hub@latest', -- Installs required mcp-hub npm module
  -- uncomment this if you don't want mcp-hub to be available globally or can't use -g
  build = 'bundled_build.lua', -- Use this and set use_bundled_binary = true in opts  (see Advanced configuration)
  opts = {
    use_bundled_binary = true,
    auto_approve = false,
    extensions = {
      avante = {
        make_slash_commands = true, -- make /slash commands from MCP server prompts
      },
    },
  },
  config = function(_, opts)
    create_default_config()
    require('mcphub').setup(opts)
  end,
}
