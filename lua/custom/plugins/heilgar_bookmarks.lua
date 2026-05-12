return {
  packs = {
    'https://github.com/kkharji/sqlite.lua',
    'https://github.com/heilgar/bookmarks.nvim',
  },
  setup = function()
    require('bookmarks').setup {
      default_mappings = true,
      db_path = vim.fn.stdpath('data') .. '/bookmarks.db',
    }
    require('telescope').load_extension 'bookmarks'
  end,
}
