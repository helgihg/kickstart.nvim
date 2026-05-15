return {
  packs = { 'https://github.com/preservim/vim-markdown' },
  setup = function()
    vim.g.vim_markdown_folding_disabled = 1
    vim.g.vim_markdown_toc_autofit = 1

    vim.api.nvim_create_user_command('MdTocLeft', function()
      local prev_win = vim.api.nvim_get_current_win()

      vim.cmd 'Toc'
      local toc_win = vim.api.nvim_get_current_win()

      vim.cmd 'wincmd H'
      vim.api.nvim_set_option_value('number', false, { win = toc_win })
      vim.api.nvim_set_option_value('relativenumber', false, { win = toc_win })

      vim.api.nvim_set_current_win(prev_win)
    end, {})
  end,
}
