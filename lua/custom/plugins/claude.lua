return {
  packs = { 'https://github.com/greggh/claude-code.nvim' },
  setup = function()
    require('claude-code').setup()
  end,
}
