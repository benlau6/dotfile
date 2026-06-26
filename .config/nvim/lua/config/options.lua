-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- to fix lazyvim lazygit worktree weird detection of root directory
vim.g.root_spec = { ".git", "lsp", "lua", "cwd" }
vim.g.minipairs_disable = true
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
vim.opt.shiftwidth = 4
vim.lsp.config('ty', {
  settings = {
    ty = {
      -- ty language server settings go here
    }
  }
})
vim.lsp.enable("ty")
vim.g.lazyvim_python_lsp = "ty"
vim.lsp.inlay_hint.enable(true)
