local wk = require("which-key")

wk.register({
  ["<leader>c"] = { name = "code" },
  ["<leader>ct"] = { name = "competitest" },
  ["<leader>d"] = { name = "debug" },
  ["<leader>l"] = { name = "leetcode" },
  ["<leader>p"] = { name = "clipboard" },
  ["<leader>t"] = { name = "ui" },
}, { mode = "n" })
