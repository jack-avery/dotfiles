-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  -- tree
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  -- lsp
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip",
  -- diagnostics
  "folke/trouble.nvim",
  -- fuzzy search
  "nvim-lua/plenary.nvim",
  "nvim-telescope/telescope.nvim",
})

vim.cmd.colorscheme "catppuccin"

require("nvim-tree").setup()
require("trouble").setup()
