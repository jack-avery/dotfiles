vim.api.nvim_set_keymap("n", ",", ":NvimTreeOpen<cr>", {noremap=true})

vim.api.nvim_set_keymap("n", ".", ":Trouble diagnostics toggle<cr>", {noremap=true})

vim.api.nvim_set_keymap("n", "<leader>f", ":Telescope find_files<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>g", ":Telescope live_grep<cr>", {noremap=true})
vim.api.nvim_set_keymap("n", "<leader>b", ":Telescope buffers<cr>", {noremap=true})
