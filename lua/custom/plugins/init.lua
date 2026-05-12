local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'custom', 'plugins')
local all_packs = {}
local all_setups = {}

for file_name, type in vim.fs.dir(plugins_dir) do
  if type == 'file' and file_name:match '%.lua$' and file_name ~= 'init.lua' then
    local spec = require('custom.plugins.' .. file_name:gsub('%.lua$', ''))
    for _, pack in ipairs(spec.packs or {}) do
      table.insert(all_packs, pack)
    end
    if spec.setup then
      table.insert(all_setups, spec.setup)
    end
  end
end

vim.pack.add(all_packs)

for _, setup in ipairs(all_setups) do
  setup()
end
