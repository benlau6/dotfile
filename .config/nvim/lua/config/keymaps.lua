-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "jj", "<ESC>", { silent = true })
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")

vim.keymap.set("n", "<c-p>", "<Plug>(YankyPreviousEntry)")
vim.keymap.set("n", "<c-n>", "<Plug>(YankyNextEntry)")
vim.keymap.set("n", "]p", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[p", "<Plug>(YankyPutIndentBeforeLinewise)")
vim.keymap.set("n", "]P", "<Plug>(YankyPutIndentAfterLinewise)")
vim.keymap.set("n", "[P", "<Plug>(YankyPutIndentBeforeLinewise)")

vim.keymap.set("n", ">p", "<Plug>(YankyPutIndentAfterShiftRight)")
vim.keymap.set("n", "<p", "<Plug>(YankyPutIndentAfterShiftLeft)")
vim.keymap.set("n", ">P", "<Plug>(YankyPutIndentBeforeShiftRight)")
vim.keymap.set("n", "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)")

vim.keymap.set("n", "=p", "<Plug>(YankyPutAfterFilter)")
vim.keymap.set("n", "=P", "<Plug>(YankyPutBeforeFilter)")

vim.keymap.set("n", "<leader>9m", function()
  require("99.extensions.fzf_lua").select_model()
end)

vim.keymap.set("n", "<leader>9p", function()
  require("99.extensions.fzf_lua").select_provider()
end)

vim.keymap.set("n", "<leader>rr", ":RunFile<CR>", { noremap = true, silent = false })
vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false })

-- https://www.lazyvim.org/configuration/general#keymaps
vim.keymap.set("n", "<leader>'", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })

-- copy current path
vim.keymap.set("n", "<leader>cp", '<cmd>let @+ = expand("%")<cr>', { desc = "Copy relative path" })
vim.keymap.set("n", "<leader>cP", '<cmd>let @+ = expand("%:p")<cr>', { desc = "Copy absolute path" })

local function current_file()
  local file = vim.api.nvim_buf_get_name(0)

  if file == "" then
    vim.notify("No file opened in current buffer", vim.log.levels.WARN)
    return nil
  end

  return file
end

local function run_in_float(cmd, opts)
  opts = opts or {}

  local width = math.floor(vim.o.columns * 0.9)
  local height = math.floor(vim.o.lines * 0.9)

  local buf = vim.api.nvim_create_buf(false, true)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    style = "minimal",
    border = "rounded",
  })

  local runner = require("config.runner")
  runner.start()
  vim.fn.jobstart({ "sh", "-c", cmd }, {
    term = true,

    on_exit = function()
      runner.stop()
      if opts.auto_close then
        vim.schedule(function()
          if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
          end
        end)
      end
    end,
  })

  -- Escape terminal mode
  vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], {
    buffer = buf,
  })

  -- Close popup
  vim.keymap.set("n", "q", function()
    if vim.api.nvim_win_is_valid(win) then
      vim.api.nvim_win_close(win, true)
    end
  end, {
    buffer = buf,
  })

  vim.cmd("startinsert")
end

local function run_in_buffer(cmd)
  local runner = require("config.runner")
  runner.start()

  vim.system(cmd, { text = true }, function(result)
    runner.stop()

    vim.schedule(function()
      local buf = vim.api.nvim_create_buf(false, true)

      local output = result.stdout or ""

      if result.stderr and result.stderr ~= "" then
        output = output .. "\n" .. result.stderr
      end

      vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(output, "\n", { plain = true }))

      vim.cmd("botright new")
      vim.api.nvim_win_set_buf(0, buf)

      vim.bo[buf].buftype = "nofile"
      vim.bo[buf].bufhidden = "wipe"
      vim.bo[buf].swapfile = false
      vim.bo[buf].modifiable = false
    end)
  end)
end

vim.keymap.set("n", "<leader>re", function()
  local file = current_file()
  if not file then
    return
  end

  local escaped_file = vim.fn.shellescape(file)

  vim.notify("Running: " .. vim.fn.fnamemodify(file, ":t") .. " in csvlens", vim.log.levels.INFO)
  run_in_float("uv run python " .. escaped_file .. " | csvlens", { auto_close = true })
end, { desc = "Pipe output to csvlens in tmux popup" })

vim.keymap.set("n", "<leader>rr", function()
  local file = current_file()
  if not file then
    return
  end

  local escaped_file = vim.fn.shellescape(file)
  local cmd
  if file:match("%.py$") then
    cmd = "uv run python " .. escaped_file
  elseif file:match("%.sh$") then
    cmd = "bash " .. escaped_file
  elseif file:match("%.js$") then
    cmd = "node " .. escaped_file
  elseif file:match("%.go$") then
    cmd = "go run " .. escaped_file
  else
    cmd = escaped_file
  end

  vim.notify("Running: " .. vim.fn.fnamemodify(file, ":t"), vim.log.levels.INFO)
  run_in_float(cmd, { auto_close = false })
end, { desc = "Run current file in popup" })

vim.keymap.set("n", "<leader>rb", function()
  local file = current_file()

  if not file then
    return
  end

  -- Shell command string → escape dynamic values
  -- "uv run python " .. vim.fn.shellescape(file)
  --
  -- argv table → don't shellescape
  -- { "uv", "run", "python", file }
  run_in_buffer({
    "uv",
    "run",
    "python",
    file,
  })
end, { desc = "Run file into buffer" })

vim.keymap.set("n", "<leader>sv", function()
  require("fzf-lua").lsp_document_symbols({
    regex_filter = function(item)
      return item.kind == "Variable" or item.kind == "Constant"
    end,
  })
end, { desc = "Find variables in buffer" })

vim.keymap.set("n", "<leader>sV", function()
  require("fzf-lua").lsp_live_workspace_symbols({
    regex_filter = function(item)
      return item.kind == "Variable" or item.kind == "Constant"
    end,
  })
end, { desc = "Find variables in workspace" })

vim.keymap.set("n", "<leader>sa", function()
  require("fzf-lua").lsp_document_symbols({})
end, { desc = "Find all symbols in buffer" })

vim.keymap.set("n", "<leader>sA", function()
  require("fzf-lua").lsp_live_workspace_symbols({})
end, { desc = "Find all symbols in workspace" })
