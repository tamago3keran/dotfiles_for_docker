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

local function open_filer()
  local path = vim.t.ddu_ui_filer_path or vim.fn.getcwd()

  vim.fn['ddu#start']({
    name = "filer",
    sources = { {
      name = "file",
      options = { path = path }
    } }
  })
end
vim.api.nvim_create_user_command("OpenFiler", open_filer, {})
vim.api.nvim_set_keymap("n", "[ddu]f", "<Cmd>OpenFiler<CR>", { noremap = true, silent = true })
-- }}}
