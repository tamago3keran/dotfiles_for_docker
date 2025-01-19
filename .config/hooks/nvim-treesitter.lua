-- lua_source {{{
require('nvim-treesitter.configs').setup({
  ensure_installed = { 'typescript', 'javascript', 'tsx' },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
-- }}}
