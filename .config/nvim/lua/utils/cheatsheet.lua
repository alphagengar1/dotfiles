local M = {}

local state = { win = nil, buf = nil }

local function collect_lines()
  local modes = { "n", "i", "v", "x", "s", "o", "t", "c" }
  local entries = {}
  local seen = {}

  for _, mode in ipairs(modes) do
    for _, map in ipairs(vim.keymap.get(mode)) do
      local lhs = map.lhs or ""
      local desc = map.desc or ""
      if desc ~= "" and lhs ~= "" and not lhs:match("^<Plug>") then
        local key = mode .. "|" .. lhs .. "|" .. desc
        if not seen[key] then
          seen[key] = true
          table.insert(entries, { mode = mode, lhs = lhs, desc = desc })
        end
      end
    end
  end

  table.sort(entries, function(a, b)
    if a.mode == b.mode then
      return a.lhs < b.lhs
    end
    return a.mode < b.mode
  end)

  local lines = {
    "Keybinds",
    "========",
    "",
  }

  local current_mode = nil
  for _, e in ipairs(entries) do
    if e.mode ~= current_mode then
      current_mode = e.mode
      table.insert(lines, string.format("[%s]", current_mode))
    end
    table.insert(lines, string.format("  %-20s %s", e.lhs, e.desc))
  end

  return lines
end

function M.toggle()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    vim.api.nvim_win_close(state.win, true)
    state.win = nil
    state.buf = nil
    return
  end

  local buf = vim.api.nvim_create_buf(false, true)
  local lines = collect_lines()
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.bo[buf].bufhidden = "wipe"
  vim.bo[buf].modifiable = false
  vim.bo[buf].filetype = "cheatsheet"

  local width = math.floor(vim.o.columns * 0.7)
  local height = math.floor(vim.o.lines * 0.7)
  local row = math.floor((vim.o.lines - height) / 2 - 1)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
  })

  state.win = win
  state.buf = buf
end

return M
