-- ~/.config/nvim/after/plugin/repo_line.lua

local function git_root()
  local dir = vim.fn.expand("%:p:h")
  local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return vim.fs.normalize(out[1])
  end
end

local function git_commit()
  local dir = vim.fn.expand("%:p:h")
  local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "HEAD" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return out[1]
  end
  return "HEAD"
end

local function repo_relpath()
  local abs = vim.fs.normalize(vim.fn.expand("%:p"))
  local root = git_root()
  if root and abs:sub(1, #root) == root then
    return abs:sub(#root + 2)
  else
    return vim.fn.expand("%:t")
  end
end

local function remote_prefix(commit)
  local dir = vim.fn.expand("%:p:h")
  local out = vim.fn.systemlist({ "git", "-C", dir, "config", "--get", "remote.origin.url" })
  local url = (out[1] or ""):gsub("/$", "")
  url = url:gsub("%.git$", "")
  if url:match("^git@") then
    local host, path = url:match("^git@([^:]+):(.+)$")
    if host and path then
      return ("https://%s/%s/src/commit/%s/"):format(host, path, commit)
    end
  elseif url:match("^https?://") then
    return ("%s/src/commit/%s/"):format(url, commit)
  end
  return ""
end

vim.keymap.set("n", "<leader>l", function()
  local commit = git_commit()
  local prefix = remote_prefix(commit)
  local s = ("%s%s#L%d"):format(prefix, repo_relpath(), vim.fn.line("."))
  vim.fn.setreg("+", s)
  print(s)
end, { desc = "Copy remote:file@commit#Lline" })

