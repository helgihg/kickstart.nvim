return {
  setup = function()
    -- Use OSC 52 so yanks reach the local clipboard over SSH (via Zellij/tmux/terminal).
    vim.schedule(function()
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy '+',
          ['*'] = require('vim.ui.clipboard.osc52').copy '*',
        },
        paste = {
          ['+'] = require('vim.ui.clipboard.osc52').paste '+',
          ['*'] = require('vim.ui.clipboard.osc52').paste '*',
        },
      }
      vim.o.clipboard = 'unnamedplus'
    end)
  end,
}
