-- lua_add {{{
vim.opt.completeopt:remove('preview')

vim.fn['ddc#custom#patch_global']('ui', 'pum')
vim.fn['ddc#custom#patch_global']('sources', { 'around', 'copilot' })
vim.fn['ddc#custom#patch_global']('sourceOptions', {
  _ = {
    matchers = { 'matcher_head' },
    sorters = { 'sorter_rank' },
  },
  around = {
    mark = '[A]',
  },
  copilot = {
    mark = '[C]',
  },
})

vim.fn['ddc#enable']()
-- }}}
