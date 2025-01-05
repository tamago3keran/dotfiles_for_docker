vim.opt.completeopt:remove("preview")

vim.fn['ddc#custom#patch_global']('ui', 'pum')
vim.fn['ddc#custom#patch_global']('sources', { 'around', 'copilot', 'lsp' })
vim.fn['ddc#custom#patch_global']('sourceOptions', {
  _ = {
    matchers = { 'matcher_head' },
    sorters = { 'sorter_rank' }
  },
  around = {
    mark = '[A]'
  },
  copilot = {
    mark = '[C]'
  },
  lsp = {
    mark = '[L]',
    forceCompletionPattern = [[\.\w*|:\w*|->\w*]]
  }
})

vim.fn['ddc#enable']()
