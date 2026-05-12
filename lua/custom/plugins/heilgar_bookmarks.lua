vim.pack.add { 'https://github.com/kkharji/sqlite.lua' }
vim.pack.add { 'https://github.com/heilgar/bookmarks.nvim' }
require('bookmarks').setup {
  default_mappings = true,
  db_path = vim.fn.stdpath('data') .. '/bookmarks.db',
}
require('telescope').load_extension 'bookmarks'
