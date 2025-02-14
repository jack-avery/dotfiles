-- General
vim.opt.number=true
vim.opt.relativenumber=true
vim.opt.autoread=true
vim.opt.smartcase=true
vim.opt.ignorecase=true
vim.opt.hlsearch=true
vim.opt.incsearch=true
vim.opt.fileencoding="ascii"
vim.opt.belloff="all"
vim.opt.paste=false
vim.opt.modifiable=true

-- Indentation
vim.opt.shiftwidth=4
vim.opt.softtabstop=2
vim.opt.tabstop=2
vim.opt.expandtab=true
vim.opt.smartindent=true
vim.opt.autoindent=true

-- Disable swap
vim.opt.swapfile=false
vim.opt.backup=false
vim.opt.wb=false

vim.g.mapleader = " "

-- Fast save & quit
vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>q", ":q<CR>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>Q", ":qa!<CR>", {noremap=true})

-- Indentation binds
vim.api.nvim_set_keymap("x", "<tab>", ">gv", {noremap=true})
vim.api.nvim_set_keymap("x", "<s-tab>", "<gv", {noremap=true})
vim.api.nvim_set_keymap("n", "<tab>", ">>", {noremap=true})
vim.api.nvim_set_keymap("n", "<s-tab>", "<<", {noremap=true})
vim.api.nvim_set_keymap("i", "<s-tab>", "<esc><<A", {noremap=true})

-- Whitespace handling
vim.opt.list=true
local space = "·"
vim.opt.listchars:append {
  tab = "│ ",
  multispace = space,
  lead = space,
  trail = space,
  nbsp = space
}
vim.cmd([[match TrailingWhitespace /\s\+$/]])
vim.api.nvim_set_hl(0, "TrailingWhitespace", { link = "Error" })

require("plugins")
require("binds")
require("lsp")
