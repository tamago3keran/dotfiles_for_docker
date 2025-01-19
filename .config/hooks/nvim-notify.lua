-- lua_add {{{
local notify = require('notify')
vim.notify = notify

notify.setup({
  stages = 'fade_in_slide_out',
  timeout = 3000,
})
-- }}}
