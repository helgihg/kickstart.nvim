vim.pack.add { 'https://github.com/MunifTanjim/nui.nvim' }
vim.pack.add { { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = 'v3.x' } }
vim.keymap.set('n', '<leader>o', '<cmd>Neotree<cr>', { desc = 'Open File Choose' })
