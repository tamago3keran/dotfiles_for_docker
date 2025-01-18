-- lua_add {{{
vim.g.deol_options = {
  command = 'bash',
  split = 'floating',
  wincol = vim.g.floating_window_config.margin_left,
  winrow = vim.g.floating_window_config.margin_top,
  winwidth = vim.g.floating_window_config.width,
  winheight = vim.g.floating_window_config.height,
  floating_border = 'rounded',
  toggle = true,
}

vim.api.nvim_set_keymap("n", "<C-t>", "<Cmd>call deol#start(g:deol_options)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<C-t>", "<Cmd>call deol#start(g:deol_options)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
-- }}}
