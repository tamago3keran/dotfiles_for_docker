require('gitsigns').setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', '<C-h>n', function()
      if vim.wo.diff then return '<C-h>n' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '<C-h>p', function()
      if vim.wo.diff then return '<C-h>p' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<C-h>b', function() gs.blame_line{full=true} end)
    map('n', '<C-h>d', gs.preview_hunk)
  end
}
