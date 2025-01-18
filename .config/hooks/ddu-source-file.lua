-- lua_add {{{
vim.fn['ddu#custom#patch_local']('filer', {
  ui = 'filer',
  uiParams = {
    filer = { splitDirection = 'botright' },
  },
  sourceOptions = {
    file = {
      sorters = { 'sorter_alpha' },
      matchers = { 'matcher_ignore_files' },
      columns = { 'devicon_filename' },
    },
  },
  filterParams = {
    matcher_ignore_files = {
      ignoreGlobs = { '.git' },
    },
  },
  columnParams = {
    devicon_filename = {
      indentationWidth = 2,
    },
  },
})

vim.api.nvim_set_keymap("n", "[ddu]f", "<Cmd>call ddu#start({'name': 'filer', 'sources': [{'name': 'file'}]})<CR>", { noremap = true, silent = true })
-- }}}
