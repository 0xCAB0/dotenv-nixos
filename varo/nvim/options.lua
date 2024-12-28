

local g = vim.g

g.mapleader = ' '


local o = vim.o

o.expandtab = true -- expand tab input with spaces characters
o.smartindent = true -- syntax aware indentations for newline inserts
o.number = true
-- vim.o.clipboard = 'unnamedplus'
-- vim.o.relativenumber = true

o.signcolumn = 'yes'

o.tabstop = 4 -- num of space characters per tab
o.shiftwidth = 4 -- spaces per indentation level

o.updatetime = 300

o.termguicolors = true

o.mouse = 'a'

o.clipboard = "unnamedplus"
