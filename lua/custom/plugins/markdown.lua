return {
  packs = { 'https://github.com/preservim/vim-markdown' },
  setup = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_toc_autofit = 1

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(ev)
        pcall(vim.api.nvim_buf_del_user_command, ev.buf, 'Toc')
        vim.api.nvim_buf_create_user_command(ev.buf, 'Toc', function()
          local prev_win = vim.api.nvim_get_current_win()
          vim.cmd 'Tocv'
          vim.cmd 'wincmd H'
          local toc_win = vim.api.nvim_get_current_win()
          vim.api.nvim_set_option_value('number', false, { win = toc_win })
          vim.api.nvim_set_option_value('relativenumber', false, { win = toc_win })
          vim.api.nvim_set_current_win(prev_win)
        end, {})
      end,
    })
  end,
}
