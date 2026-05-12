return {
  packs = {
    'https://github.com/MunifTanjim/nui.nvim',
    { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' },
  },
  setup = function()
    vim.keymap.set('n', '<leader>o', '<cmd>Neotree<cr>', { desc = 'Open File Choose' })
  end,
}
