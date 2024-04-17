vim.opt.modifiable=true

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
  "nvim-tree/nvim-tree.lua",
  "nvim-tree/nvim-web-devicons",
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/nvim-cmp",
  "hrsh7th/cmp-vsnip",
  "hrsh7th/vim-vsnip"
})

vim.cmd.colorscheme "catppuccin"

require("nvim-tree").setup()
require("mason").setup()

-- LSP
local nvim_lsp = require('lspconfig')

local lsp_servers_list = {'pylsp', 'rust_analyzer'}

nvim_lsp.pylsp.setup({})
nvim_lsp.rust_analyzer.setup({})

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

-- Set up nvim-cmp.
local cmp = require("cmp")

cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
  }, {
    { name = 'buffer' },
  })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig.
local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')["pylsp"].setup {
  capabilities = capabilities
}
require('lspconfig')["rust_analyzer"].setup {
  capabilities = capabilities
}

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

-- Keybinds
vim.g.mapleader = " "
vim.api.nvim_set_keymap("n", ",", ":NvimTreeOpen<cr>", {noremap=true})

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

