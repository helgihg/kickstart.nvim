local function git_root()
  local dir = vim.fn.expand '%:p:h'
  local out = vim.fn.systemlist { 'git', '-C', dir, 'rev-parse', '--show-toplevel' }
  if vim.v.shell_error == 0 and out[1] and out[1] ~= '' then
    return vim.fs.normalize(out[1])
  end
end

local function git_commit()
  local dir = vim.fn.expand '%:p:h'
  local out = vim.fn.systemlist { 'git', '-C', dir, 'rev-parse', 'HEAD' }
  if vim.v.shell_error == 0 and out[1] and out[1] ~= '' then
    return out[1]
  end
  return 'HEAD'
end

local function repo_relpath()
  local abs = vim.fs.normalize(vim.fn.expand '%:p')
  local root = git_root()
  if root and abs:sub(1, #root) == root then
    return abs:sub(#root + 2)
  else
    return vim.fn.expand '%:t'
  end
end

local function remote_prefix(commit)
  local dir = vim.fn.expand '%:p:h'
  local out = vim.fn.systemlist { 'git', '-C', dir, 'config', '--get', 'remote.origin.url' }
  local url = (out[1] or ''):gsub('/$', ''):gsub('%.git$', '')
  if url:match '^git@' then
    local host, path = url:match '^git@([^:]+):(.+)$'
    if host and path then
      return ('https://%s/%s/src/commit/%s/'):format(host, path, commit)
    end
  elseif url:match '^https?://' then
    return ('%s/src/commit/%s/'):format(url, commit)
  end
  return ''
end

local function build_url(range_start, range_end)
  local commit = git_commit()
  local prefix = remote_prefix(commit)
  local file = repo_relpath()
  local anchor = (range_end and range_end ~= range_start) and ('#L' .. range_start .. '-L' .. range_end) or ('#L' .. range_start)
  return prefix .. file .. anchor
end

-- Normal mode: single cursor line -> #L{line}
vim.keymap.set('n', '<leader>l', function()
  local line = vim.fn.line '.'
  local s = build_url(line, line)
  vim.fn.setreg('+', s)
  print(s)
end, { desc = 'Copy remote:file#Lline (commit)' })

-- Visual mode: selected line range -> #L{start}-L{end}
vim.keymap.set('x', '<leader>l', function()
  local a = vim.fn.line "'<"
  local b = vim.fn.line "'>"
  if a > b then
    a, b = b, a
  end
  local s = build_url(a, b)
  vim.fn.setreg('+', s)
  print(s)
end, { desc = 'Copy remote:file#Lstart-Lend (commit)' })

return {}
