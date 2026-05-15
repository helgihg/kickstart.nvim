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
          local lines = vim.api.nvim_buf_get_lines(vim.api.nvim_win_get_buf(toc_win), 0, -1, false)
          local max_width = 0
          for _, line in ipairs(lines) do
            max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
          end
          vim.api.nvim_win_set_width(toc_win, max_width + 2)
          vim.api.nvim_set_current_win(prev_win)
          vim.cmd 'vsplit'
          local dummy_win = vim.api.nvim_get_current_win()
          local dummy_buf = vim.api.nvim_create_buf(false, true)
          vim.api.nvim_win_set_buf(dummy_win, dummy_buf)
          vim.api.nvim_set_option_value('number', false, { win = dummy_win })
          vim.api.nvim_set_option_value('relativenumber', false, { win = dummy_win })
          vim.api.nvim_set_option_value('signcolumn', 'no', { win = dummy_win })
          vim.api.nvim_win_set_width(prev_win, 120)
          vim.api.nvim_set_current_win(prev_win)
        end, {})
        vim.bo[ev.buf].textwidth = 120
        vim.cmd 'Toc'
      end,
    })
  end,
}
