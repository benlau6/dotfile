local M = {}

local state = {
  started_at = nil,
  elapsed = 0,
  timer = nil,
  running = false,
}

function M.start()
  -- stop an old timer if needed
  if state.timer then
    state.timer:stop()
    state.timer:close()
  end

  state.started_at = vim.uv.hrtime()
  state.elapsed = 0
  state.running = true

  state.timer = vim.uv.new_timer()

  state.timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      state.elapsed = (vim.uv.hrtime() - state.started_at) / 1e9
      vim.cmd("redrawstatus")
    end)
  )
end

function M.stop()
  if state.started_at then
    state.elapsed = (vim.uv.hrtime() - state.started_at) / 1e9
  end

  if state.timer then
    state.timer:stop()
    state.timer:close()
    state.timer = nil
  end

  state.started_at = nil
  state.running = false

  vim.schedule(function()
    vim.cmd("redrawstatus")
  end)
end

function M.status()
  if state.running then
    return string.format("󰔟 %.1fs", state.elapsed)
  end

  if state.elapsed > 0 then
    return string.format("󰄬 %.2fs", state.elapsed)
  end

  return ""
end

return M
