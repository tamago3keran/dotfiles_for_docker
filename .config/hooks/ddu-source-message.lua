-- lua_add {{{
vim.fn['ddu#custom#patch_local']('message', {
  ui = 'ff',
  uiParams = {
    ff = {
      prompt = '> ',
      split = 'floating',
      floatingBorder = 'rounded',
      floatingTitle = ' Messages ',
      floatingTitlePos = 'center',
      winCol = vim.g.floating_window_config.margin_left,
      winRow = vim.g.floating_window_config.margin_top,
      winWidth = vim.g.floating_window_config.width,
      winHeight = vim.g.floating_window_config.height,
    },
  },
  sourceOptions = {
    message = {
      matchers = { 'matcher_substring' },
    },
  },
  kindOptions = {
    word = {
      defaultAction = 'yank',
    },
  },
})

vim.api.nvim_set_keymap(
  'n',
  '[ddu]m',
  "<Cmd>call ddu#start({'name': 'message', 'sources': [{'name': 'message'}]})<CR>",
  { noremap = true, silent = true }
)
-- }}}
