return {
  packs = {
    { src = 'https://github.com/akinsho/bufferline.nvim', version = 'v4.9.1' },
  },
  setup = function()
    require('bufferline').setup {
      options = {
        mode = 'buffers',
        show_buffer_close_icons = false,
        show_close_icon = false,
        always_show_bufferline = true,
      },
    }
    vim.keymap.set('n', '<Tab>', '<Cmd>BufferLineCycleNext<CR>', { silent = true })
    vim.keymap.set('n', '<S-Tab>', '<Cmd>BufferLineCyclePrev<CR>', { silent = true })
    for i = 1, 9 do
      vim.keymap.set('n', '<A-' .. i .. '>', '<Cmd>BufferLineGoToBuffer ' .. i .. '<CR>', { silent = true })
    end
  end,
}
