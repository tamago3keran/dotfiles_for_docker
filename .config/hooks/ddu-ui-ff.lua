-- lua_add {{{
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-ff",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<Cmd>call ddu#ui#do_action('itemAction')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "o", "<Cmd>call ddu#ui#do_action('itemAction')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "s", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "t", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "i", "<Cmd>call ddu#ui#do_action('openFilterWindow')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<Cmd>call ddu#ui#do_action('quit')<CR>", { noremap = true, silent = true })
  end
})
-- }}}
