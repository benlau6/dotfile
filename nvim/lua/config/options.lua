-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- to fix lazyvim lazygit worktree weird detection of root directory
vim.g.lazyvim_python_lsp = "pyrefly"
vim.g.root_spec = { ".git", "lsp", "lua", "cwd" }
local opt = vim.opt
opt.shiftwidth = 4
vim.lsp.inlay_hint.enable(true)
