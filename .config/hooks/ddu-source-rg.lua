-- lua_add {{{
vim.fn['ddu#custom#patch_local']('grep', {
  ui = 'ff',
  uiParams = {
    ff = {
      startAutoAction = true,
      autoAction = { name = 'preview' },
      prompt = '> ',
      split = 'floating',
      floatingBorder = 'rounded',
      floatingTitle = ' Results ',
      floatingTitlePos = 'center',
      winCol = vim.g.floating_window_with_preview_config.margin_left - 1,
      winRow = vim.g.floating_window_with_preview_config.margin_top,
      winWidth = vim.g.floating_window_with_preview_config.width,
      winHeight = vim.g.floating_window_with_preview_config.height,
      previewFloating = true,
      previewFloatingZindex = 2,
      previewFloatingBorder = 'rounded',
      previewFloatingTitle = ' Preview ',
      previewFloatingTitlePos = 'center',
      previewCol = vim.g.floating_window_with_preview_config.margin_left
        + vim.g.floating_window_with_preview_config.width
        + 1,
      previewRow = vim.g.floating_window_with_preview_config.margin_top
        + vim.g.floating_window_with_preview_config.height
        + 2,
      previewWidth = vim.g.floating_window_with_preview_config.width,
      previewHeight = vim.g.floating_window_with_preview_config.height,
    },
  },
  sourceOptions = {
    rg = {
      matchers = { 'converter_display_word', 'matcher_substring' },
    },
  },
  sourceParams = {
    rg = {
      args = { '--hidden', '--column' },
    },
  },
  filterParams = {
    matcher_substring = {
      highlightMatched = 'Title',
    },
  },
  kindOptions = {
    file = {
      defaultAction = 'open',
    },
  },
})

vim.api.nvim_set_keymap(
  'n',
  '[ddu]g',
  "<Cmd>call ddu#start({'name': 'grep', 'sources': [{'name': 'rg'}], 'sourceParams': {'rg': {'input': input('Pattern: ')}}})<CR>",
  { noremap = true, silent = true }
)
-- }}}
