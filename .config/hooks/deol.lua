local floating_window_config = {
  margin_left = math.floor(vim.o.columns * 0.05),
  margin_top = math.floor(vim.o.lines * 0.1),
  width = math.floor(vim.o.columns * 0.9),
  height = math.floor(vim.o.lines * 0.8),
}
vim.g.deol_options = {
  command = 'bash',
  split = 'floating',
  wincol = floating_window_config.margin_left,
  winrow = floating_window_config.margin_top,
  winwidth = floating_window_config.width,
  winheight = floating_window_config.height,
  floating_border = 'rounded',
  toggle = true,
}

vim.api.nvim_set_keymap("n", "<C-t>", "<Cmd>call deol#start(g:deol_options)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>call deol#start(g:deol_options)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
