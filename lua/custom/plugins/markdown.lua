return {
  -- The vim-markdown plugin provides syntax, folding, and the :Toc command.
  packs = { 'https://github.com/preservim/vim-markdown' },
  setup = function()
    -- Don't let the plugin fold sections; we want the whole document visible.
    vim.g.vim_markdown_folding_disabled = 1
    -- Shrink the TOC window to fit its contents instead of a fixed width.
    vim.g.vim_markdown_toc_autofit = 1

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function(ev)
        -- Replace vim-markdown's built-in :Toc with our own layout-aware version.
        -- pcall guards against the command not yet existing on this buffer.
        pcall(vim.api.nvim_buf_del_user_command, ev.buf, 'Toc')
        vim.api.nvim_buf_create_user_command(ev.buf, 'Toc', function()
          -- Remember where we started so we can return here at the end.
          local prev_win = vim.api.nvim_get_current_win()

          -- Open the plugin's vertical TOC, then move it to the far left.
          vim.cmd 'Tocv'
          vim.cmd 'wincmd H'
          local toc_win = vim.api.nvim_get_current_win()

          -- The TOC is a navigation sidebar, so hide line numbers.
          vim.api.nvim_set_option_value('number', false, { win = toc_win })
          vim.api.nvim_set_option_value('relativenumber', false, { win = toc_win })

          -- Size the TOC window to its widest line (plus a little padding).
          local lines = vim.api.nvim_buf_get_lines(vim.api.nvim_win_get_buf(toc_win), 0, -1, false)
          local max_width = 0
          for _, line in ipairs(lines) do
            max_width = math.max(max_width, vim.fn.strdisplaywidth(line))
          end
          vim.api.nvim_win_set_width(toc_win, max_width + 4)

          -- Return to the document window. It fills whatever space remains to
          -- the right of the TOC sidebar.
          vim.api.nvim_set_current_win(prev_win)
        end, {})

        -- Soft-wrap long lines visually only -- never insert real newlines into
        -- the file. textwidth=0 and dropping the 't' formatoption disable Vim's
        -- automatic hard wrapping; 'wrap' turns on visual wrapping and
        -- 'linebreak' makes it break between words instead of mid-word.
        vim.bo[ev.buf].textwidth = 0
        vim.opt_local.formatoptions:remove 't'
        vim.wo.wrap = true
        vim.wo.linebreak = true

        -- Build the TOC layout automatically once the buffer is ready.
        -- Deferred via schedule so the FileType event finishes settling first.
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(ev.buf) then
            vim.cmd 'Toc'
          end
        end)
      end,
    })
  end,
}
