require "nvchad.options"

local opt = vim.opt
local g = vim.g
local fn = vim.fn

-- Paths
g.lua_snippets_path = fn.stdpath "config" .. "/lua/lua_snippets"

-- UI / editor behavior
opt.cursorline = true
opt.cursorlineopt = "both"
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.showmode = false
opt.fillchars = { eob = "~" }
opt.hidden = true
opt.updatetime = 100
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.incsearch = true
opt.hlsearch = true
opt.autoindent = true
opt.smartindent = true
opt.cindent = true
opt.showmatch = true
opt.ruler = true
opt.wrap = true

-- Indentation
opt.tabstop = 2
opt.shiftwidth = 2

-- Backspace behavior and other settings
opt.backspace = { "indent", "eol", "start" }
opt.ttimeout = true
opt.ttimeoutlen = 1
opt.ttyfast = true
opt.encoding = "utf-8"

-- Filetypes
vim.filetype.add({
  extension = {
    zsh = "zsh",
  },
})
