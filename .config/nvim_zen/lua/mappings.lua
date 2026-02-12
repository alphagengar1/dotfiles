require "nvchad.mappings"

local unpack = table.unpack or unpack

local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local M = {}

M.general = {
  { "n", ";", ":", { desc = "CMD enter command mode" } },
  { "n", "<leader>n", "<cmd> set nu! <CR>", { desc = "Toggle line number" } },
  { "n", "<leader>b", "<cmd> enew <CR>", { desc = "New buffer" } },
  {
    "n",
    "<leader>ch",
    function()
      local builtin = require("telescope.builtin")
      local themes = require("telescope.themes")
      builtin.keymaps(themes.get_dropdown({ previewer = false, layout_config = { width = 0.7 } }))
    end,
    { desc = "Cheatsheet (Search)" },
  },
  { "n", "<C-c>", "<cmd> %y+ <CR>", { desc = "Copy whole file" } },
  { "i", "jk", "<ESC>", { desc = "Exit insert mode" } },
}

M.clipboard = {
  { "n", "y", "+y", { desc = "Yank to clipboard" } },
  { "n", "Y", "+Y", { desc = "Yank line to clipboard" } },
  { "n", "yy", "+yy", { desc = "Yank line to clipboard" } },
}

M.editing = {
  { "i", "{", "{}<Left>", { desc = "Auto-close braces" } },
  { "i", "{<CR>", "{<CR>}<ESC>O", { desc = "Auto-close braces with newline" } },
  { "i", "{{", "{", { desc = "Insert literal {" } },
  { "i", "{}", "{}", { desc = "Insert {}" } },
  { "i", "[", "[]<Left>", { desc = "Auto-close brackets" } },
  { "i", "[]", "[]", { desc = "Insert []" } },
  { "i", "(", "()<Left>", { desc = "Auto-close parens" } },
  { "i", "()", "()", { desc = "Insert ()" } },
  { "n", "c(", "di(", { desc = "Change inside ()" } },
  { "n", "c{", "di{", { desc = "Change inside {}" } },
  { "n", "c[", "di[", { desc = "Change inside []" } },
  { "n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" } },
}

local function load_mappings()
  for _, category in pairs(M) do
    for _, mapping in ipairs(category) do
      local mode, lhs, rhs, opts = unpack(mapping)
      map(mode, lhs, rhs, opts)
    end
  end
end

load_mappings()

return M
