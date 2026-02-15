require "nvchad.mappings"

local unpack = table.unpack or unpack

-- Mapping helper function
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.silent = opts.silent ~= false
  vim.keymap.set(mode, lhs, rhs, opts)
end

local M = {}

-- Organize mappings by category
M.general = {
  { "n", ";",          ":",                       { desc = "CMD enter command mode" } },
  { "n", "<leader>n",  "<cmd> set nu! <CR>",      { desc = "Toggle line number" } },
  { "n", "<leader>b",  "<cmd> enew <CR>",         { desc = "New buffer" } },
  { "n", "<leader>ch", "<cmd>WhichKey <leader><CR>", { desc = "Cheatsheet (WhichKey)" } },
  { "n", "<C-c>",      "<cmd> %y+ <CR>",          { desc = "Copy whole file" } },
  { "i", "jk",         "<ESC>",                   { desc = "Exit insert mode" } },
}

M.clipboard = {
  { "n", "y",  '"+y',  { desc = "Yank to clipboard" } },
  { "n", "Y",  '"+Y',  { desc = "Yank line to clipboard" } },
  { "n", "yy", '"+yy', { desc = "Yank line to clipboard" } },
}

M.editing = {
  { "i", "{",     "{}<Left>",         { desc = "Auto-close braces" } },
  { "i", "{<CR>", "{<CR>}<ESC>O",     { desc = "Auto-close braces with newline" } },
  { "i", "{{",    "{",                { desc = "Insert literal {" } },
  { "i", "{}",    "{}",               { desc = "Insert {}" } },
  { "i", "[",     "[]<Left>",         { desc = "Auto-close brackets" } },
  { "i", "[]",    "[]",               { desc = "Insert []" } },
  { "i", "(",     "()<Left>",         { desc = "Auto-close parens" } },
  { "i", "()",    "()",               { desc = "Insert ()" } },
  { "n", "c(",    "di(",              { desc = "Change inside ()" } },
  { "n", "c{",    "di{",              { desc = "Change inside {}" } },
  { "n", "c[",    "di[",              { desc = "Change inside []" } },
  { "n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlights" } },
}

-- LSP related mappings
M.lsp = require("configs.lsp_keymaps").global

-- Competitive Programming mappings (CompetiTest plugin)
M.competitive = {
  { "n", "<leader>cta", ":CompetiTest add_testcase<Space><CR>",      { desc = "Add Testcase" } },
  { "n", "<leader>cte", ":CompetiTest edit_testcase<Space><CR>",     { desc = "Edit Testcase" } },
  { "n", "<leader>ctr", ":CompetiTest run<Space><CR>",               { desc = "Run Testcases" } },
  { "n", "<leader>ctc", ":CompetiTest receive contest<Space><CR>",   { desc = "Receive Contest" } },
  { "n", "<leader>ctp", ":CompetiTest receive problem<Space><CR>",   { desc = "Receive Problem" } },
  { "n", "<leader>ctg", ":CompetiTest receive testcases<Space><CR>", { desc = "Receive Testcases" } },
  { "n", "<leader>cf",  ":lua CopyCurrentFileName()<CR>",            { desc = "Copy File Name" } },
}

-- LeetCode mappings (Leet.nvim plugin)
M.leetcode = {
  { "n", "<leader>leet", "<cmd>Leet<CR>",                          { desc = "Leet Dashboard" } },
  { "n", "<leader>lq",   "<cmd>Leet exit<CR>",                     { desc = "Close Leet" } },
  { "n", "<leader>lrq",  "<cmd>Leet random<CR>",                   { desc = "Random Question" } },
  { "n", "<leader>lre",  "<cmd>Leet random difficulty=easy<CR>",   { desc = "Random Easy Question" } },
  { "n", "<leader>lrm",  "<cmd>Leet random difficulty=medium<CR>", { desc = "Random Medium Question" } },
  { "n", "<leader>lrh",  "<cmd>Leet random difficulty=hard<CR>",   { desc = "Random Hard Question" } },
  { "n", "<leader>lx",   "<cmd>Leet reset<CR>",                    { desc = "Reset Question" } },
  { "n", "<leader>ld",   "<cmd>Leet desc<CR>",                     { desc = "Toggle Description" } },
}

-- Utility mappings
M.utils = {
  { "n", "<leader>dn", ":lua require('notify').dismiss()<CR>", { desc = "Dismiss Notifications" } },
  {
    "n",
    "<leader>tt",
    function()
      require("base46").toggle_transparency()
    end,
    { desc = "Toggle transparency" },
  },
}

-- YankBank mappings
M.yankbank = {
  { "n", "<leader>pp", "<cmd>:YankBank<CR>",        { desc = "Yank Clipboard" } },
  { "n", "<leader>pc", "<cmd>:YankBankClearDB<CR>", { desc = "Clear YankBank History" } },
}

-- DAP (debugging)
M.dap = {
  { "n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle Breakpoint" } },
  { "n", "<leader>dc", function() require("dap").continue() end, { desc = "DAP Continue" } },
  { "n", "<leader>dl", function() require("dap").run_last() end, { desc = "DAP Run Last" } },
  { "n", "<leader>do", function() require("dap").step_over() end, { desc = "DAP Step Over" } },
  { "n", "<leader>di", function() require("dap").step_into() end, { desc = "DAP Step Into" } },
  { "n", "<leader>dO", function() require("dap").step_out() end, { desc = "DAP Step Out" } },
  { "n", "<leader>dr", function() require("dap").repl.open() end, { desc = "DAP REPL" } },
  { "n", "<leader>dx", function() require("dap").terminate() end, { desc = "DAP Terminate" } },
  {
    "n",
    "<leader>du",
    function()
      local ok, dapui = pcall(require, "dapui")
      if ok then
        dapui.toggle({ reset = true })
      else
        vim.notify("DAP UI not available. Run :Lazy sync", vim.log.levels.WARN)
      end
    end,
    { desc = "DAP UI Toggle" },
  },
}

-- Apply all mappings
local function load_mappings()
  for _, category in pairs(M) do
    for _, mapping in ipairs(category) do
      local mode, lhs, rhs, opts = unpack(mapping)       -- Use table.unpack() here
      map(mode, lhs, rhs, opts)
    end
  end
end

-- Initialize mappings
load_mappings()

-- Export mappings table for potential external use
return M
