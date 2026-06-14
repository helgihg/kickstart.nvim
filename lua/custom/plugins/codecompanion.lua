return {
  packs = { 'https://github.com/olimorris/codecompanion.nvim' },
  setup = function()
    require('codecompanion').setup {
      strategies = {
        chat = { adapter = 'anthropic' },
        inline = { adapter = 'anthropic' },
      },
      display = {
        chat = {
          window = {
            layout = 'horizontal',
            height = 0.25
          },
        },
      },
    }

    vim.keymap.set({ 'n', 'v' }, '<leader>ac', '<cmd>CodeCompanionChat Toggle<cr>', { desc = 'Toggle AI chat' })
    vim.keymap.set('v', '<leader>aa', '<cmd>CodeCompanionChat Add<cr>', { desc = 'Add selection to AI chat' })
    vim.keymap.set({ 'n', 'v' }, '<leader>ai', '<cmd>CodeCompanion<cr>', { desc = 'AI inline assistant' })
  end,
}
