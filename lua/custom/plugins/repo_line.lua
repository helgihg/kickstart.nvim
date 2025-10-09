local function git_root()
  local dir = vim.fn.expand("%:p:h")
  local out = vim.fn.systemlist({ "git", "-C", dir, "rev-parse", "--show-toplevel" })
  if vim.v.shell_error == 0 and out[1] and out[1] ~= "" then
    return vim.fs.normalize(out[1])
  end
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

vim.keymap.set("n", "<leader>l", function()
  local s = repo_relpath() .. ":" .. vim.fn.line(".")
  vim.fn.setreg("+", s)
  print(s)
end, { desc = "Copy repo-relative file:line" })

return {}
