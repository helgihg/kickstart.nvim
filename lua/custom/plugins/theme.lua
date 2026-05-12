return {
  packs = { 'https://github.com/ellisonleao/gruvbox.nvim' },
  setup = function()
    require('gruvbox').setup {
      italic = {
        strings = false,
        emphasis = false,
        comments = false,
        operators = false,
        folds = false,
      },
    }
    vim.cmd.colorscheme 'gruvbox'
  end,
}
