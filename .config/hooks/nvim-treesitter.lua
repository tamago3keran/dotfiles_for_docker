-- lua_source {{{
require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'typescript',
    'tsx',
    'javascript',
    'python',
    'ruby',
    'lua',
    'bash',
    'vim',
    'vimdoc',
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
})
-- }}}
