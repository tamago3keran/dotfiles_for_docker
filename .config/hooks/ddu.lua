local floating_window_config = {
  margin_left = math.floor(vim.o.columns * 0.1),
  margin_top = math.floor(vim.o.lines * 0.1),
  width = math.floor(vim.o.columns * 0.4),
  height = math.floor(vim.o.lines * 0.8)
}

vim.fn['ddu#custom#patch_global']({
  ui = 'ff',
  uiParams = {
    ff = {
      startAutoAction = true,
      autoAction = { name = 'preview' },
      prompt = '> ',
      split = 'floating',
      floatingBorder = 'rounded',
      floatingTitle = ' Fuzzy Finder ',
      floatingTitlePos = 'center',
      filterFloatingTitle = ' Filter ',
      filterFloatingTitlePos = 'center',
      filterFloatingPosition = 'bottom',
      winCol = floating_window_config.margin_left - 1,
      winRow = floating_window_config.margin_top,
      winWidth = floating_window_config.width,
      winHeight = floating_window_config.height,
      previewFloating = true,
      previewFloatingZindex = 2,
      previewFloatingBorder = 'rounded',
      previewFloatingTitle = ' Preview ',
      previewFloatingTitlePos = 'center',
      previewCol = floating_window_config.margin_left + floating_window_config.width + 1, 
      previewRow = floating_window_config.margin_top + floating_window_config.height + 2,
      previewWidth = floating_window_config.width,
      previewHeight = floating_window_config.height,
    }
  },
  sourceOptions = {
    _ = { sorters = { 'sorter_alpha' } }
  },
  filterParams = {
    matcher_substring = { highlightMatched = 'Title' },
    matcher_ignore_files = { ignoreGlobs = { '.git', 'vendor' } }
  },
  kindOptions = {
    file = { defaultAction = 'open' }
  }
})

vim.fn['ddu#custom#patch_local']('buffer', {
  sourceOptions = {
    buffer = { matchers = { 'matcher_substring' } }
  }
})

vim.fn['ddu#custom#patch_local']('filer', {
  ui = 'filer',
  sourceOptions = {
    _ = {
      columns = { 'devicon_filename' },
      matchers = { 'matcher_ignore_files' }
    }
  },
  columnParams = {
    devicon_filename = { indentationWidth = 2 }
  },
  uiParams = {
    filer = { splitDirection = 'botright' }
  }
})

vim.fn['ddu#custom#patch_local']('grep', {
  sourceOptions = {
    rg = { matchers = { 'converter_display_word', 'matcher_substring' } }
  },
  sourceParams = {
    rg = { args = { '--hidden', '--column' } }
  }
})

vim.fn['ddu#custom#patch_local']('file_rec', {
  sourceOptions = {
    file_rec = { matchers = { 'matcher_substring' } }
  },
  sourceParams = {
    file_rec = { ignoredDirectories = { '.git' } }
  }
})

vim.api.nvim_set_keymap("n", "[ddu]", "<Nop>", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-d>", "[ddu]", { noremap = false })
vim.api.nvim_set_keymap("n", "[ddu]b", "<Cmd>call ddu#start({'name': 'buffer', 'sources': [{'name': 'buffer'}]})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[ddu]f", "<Cmd>call ddu#start({'name': 'filer', 'sources': [{'name': 'file', 'params': {}}]})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[ddu]g", "<Cmd>call ddu#start({'name': 'grep', 'sources': [{'name': 'rg', 'params': {'input': input('Pattern: ')}}]})<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "[ddu]p", "<Cmd>call ddu#start({'name': 'file_rec', 'sources': [{'name': 'file_rec'}]})<CR>", { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "TabEnter", "CursorHold", "FocusGained" }, {
  buffer = 0,
  callback = function()
    vim.fn['ddu#ui#do_action']('checkItems')
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-filer",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>",
      [[ddu#ui#get_item()->get('isTree', v:false) ? "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow'})<CR>" : "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"]],
      { noremap = true, silent = true, expr = true }
    )
    vim.api.nvim_buf_set_keymap(0, "n", "o",
      [[ddu#ui#get_item()->get('isTree', v:false) ? "<Cmd>call ddu#ui#do_action('expandItem', {'mode': 'toggle'})<CR>" : "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open'})<CR>"]],
      { noremap = true, silent = true, expr = true }
    )

    vim.api.nvim_buf_set_keymap(0, "n", "s", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "t", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<Cmd>call ddu#ui#do_action('quit')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "u", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'narrow', 'params': {'path': '..'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "c", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'copy'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "p", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'paste'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "d", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'delete'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "r", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'rename'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "mv", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'move'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "n", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newFile'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "mk", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'newDirectory'})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "yy", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'yank'})<CR>", { noremap = true, silent = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-ff",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<Cmd>call ddu#ui#do_action('itemAction')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "o", "<Cmd>call ddu#ui#do_action('itemAction')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "s", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'vsplit'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "t", "<Cmd>call ddu#ui#do_action('itemAction', {'name': 'open', 'params': {'command': 'tabnew'}})<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "i", "<Cmd>call ddu#ui#do_action('openFilterWindow')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Space>", "<Cmd>call ddu#ui#do_action('toggleSelectItem')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "n", "<Esc>", "<Cmd>call ddu#ui#do_action('quit')<CR>", { noremap = true, silent = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "ddu-ff-filter",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, "i", "<CR>", "<Esc><Cmd>call ddu#ui#do_action('leaveFilterWindow')<CR>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(0, "i", "<Esc>", "<Esc><Cmd>call ddu#ui#do_action('quit')<CR>", { noremap = true, silent = true })
  end
})
