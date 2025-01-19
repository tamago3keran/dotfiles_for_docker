-- lua_add {{{
vim.api.nvim_set_keymap('n', '[ddu]', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-d>', '[ddu]', { noremap = false })

vim.api.nvim_create_autocmd({ 'TabEnter', 'CursorHold', 'FocusGained' }, {
  buffer = 0,
  callback = function()
    vim.fn['ddu#ui#do_action']('checkItems')
  end,
})
-- }}}
