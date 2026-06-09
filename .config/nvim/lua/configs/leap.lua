local M = {}

M.keys = {
  { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
  { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
  { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
}

M.opts = {
  safe_labels = {},
}

function M.setup(opts)
  local leap = require("leap")
  local options = opts or M.opts

  for k, v in pairs(options) do
    leap.opts[k] = v
  end

  vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap-forward)", { desc = "Leap forward to" })
  vim.keymap.set({ "n", "x", "o" }, "S", "<Plug>(leap-backward)", { desc = "Leap backward to" })
  vim.keymap.set({ "n", "x", "o" }, "gs", "<Plug>(leap-from-window)", { desc = "Leap from windows" })
end

return M
