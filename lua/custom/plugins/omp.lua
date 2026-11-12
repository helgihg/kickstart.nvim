return {
  packs = {
    'https://github.com/folke/snacks.nvim',
    'https://github.com/rauls-kjarners/omp.nvim',
  },
  setup = function()
    require('omp').setup()

    vim.keymap.set('n', '<leader>ao', function()
      require('snacks').terminal.toggle('omp', {
        win = {
          position = 'right',
          width = 0.4,
        },
      })
    end, { desc = 'Toggle Oh My Pi' })
  end,
}
