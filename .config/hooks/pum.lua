-- lua_add {{{
vim.api.nvim_set_keymap("i", "<C-n>", "<Cmd>call pum#map#select_relative(+1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<C-p>", "<Cmd>call pum#map#select_relative(-1)<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "<TAB>", "<Cmd>call pum#map#confirm()<CR>", { noremap = true, silent = true })
-- }}}
