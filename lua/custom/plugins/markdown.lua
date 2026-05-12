vim.pack.add { 'https://github.com/preservim/vim-markdown' }
vim.g.vim_markdown_folding_disabled = 1
vim.g.vim_markdown_toc_autofit = 1

vim.api.nvim_create_user_command('TocLeft', function()
  local prev_win = vim.api.nvim_get_current_win()

  local s = vim.o.splitright
  vim.o.splitright = false

  vim.cmd 'Toc'
  local toc_win = vim.api.nvim_get_current_win()

  vim.api.nvim_set_option_value('number', false, { win = toc_win })
  vim.api.nvim_set_option_value('relativenumber', false, { win = toc_win })

  vim.o.splitright = s

  vim.api.nvim_set_current_win(prev_win)
end, {})
