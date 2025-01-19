-- lua_add {{{
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if vim.bo.filetype == 'ddu-ff' or vim.bo.filetype == nil then
      return
    end

    local path = vim.fn.expand('%:p:h')
    if path ~= '' and path:find('ddu%-ff:') == nil then
      vim.t.ddu_ui_filer_path = path
    end
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'ddu-filer',
  callback = function()
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<CR>',
      [[ddu#ui#get_item()->get('isTree', v:false) ? "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>" : "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"]],
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'o',
      [[ddu#ui#get_item()->get('isTree', v:false) ? "<Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>" : "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"]],
      { noremap = true, silent = true, expr = true }
    )

    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      's',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      't',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<Space>',
      "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      '<Esc>',
      "<Cmd>call ddu#ui#do_action('quit')<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'u',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'c',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'p',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'd',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'r',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'mv',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'n',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'mk',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_buf_set_keymap(
      0,
      'n',
      'yy',
      "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>",
      { noremap = true, silent = true }
    )
  end,
})
-- }}}
