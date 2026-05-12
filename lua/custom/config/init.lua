local config_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'config')
for file_name, type in vim.fs.dir(config_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    require('custom.config.' .. file_name:gsub('%.lua$', ''))
  end
end
