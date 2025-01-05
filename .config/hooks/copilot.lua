vim.g.copilot_no_maps = true
vim.g.copilot_filetypes = {
  ['*'] = false,
  ['lua'] = true,
  ['vim'] = true,
}

vim.api.nvim_set_keymap("n", "[copilot]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-c>", "[copilot]", { noremap = false })
vim.api.nvim_set_keymap("n", "[copilot]e", ":Copilot enable<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[copilot]d", ":Copilot disable<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[copilot]p", ":Copilot panel<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[copilot]s", ":Copilot status<CR>", { noremap = true, silent = true })
