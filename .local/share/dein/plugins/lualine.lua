local mode_utils = require('lualine.utils.mode')

local vi = {
  bg_colors = {
    ['NORMAL'] = 'UserRvCyan',
    ['INSERT'] = 'UserSLStatus',
    ['VISUAL'] = 'UserRvMagenta',
    ['V-LINE'] = 'UserRvMagenta',
    ['S-LINE'] = 'UserRvMagenta',
    ['BLOCK'] = 'UserRvMagenta',
    ['V-BLOCK'] = 'UserRvMagenta',
    ['S-BLOCK'] = 'UserRvMagenta',
    ['REPLACE'] = 'UserRvRed',
    ['V-REPLACE'] = 'UserRvRed',
    ['SELECT'] = 'UserRvMagenta',
    ['COMMAND'] = 'UserRvYellow',
    ['TERMINAL'] = 'UserRvBlue',
  },

  fg_colors = {
    ['NORMAL'] = 'UserCyan',
    ['INSERT'] = 'UserSLStatusBg',
    ['VISUAL'] = 'UserMagenta',
    ['V-LINE'] = 'UserMagenta',
    ['S-LINE'] = 'UserMagenta',
    ['BLOCK'] = 'UserMagenta',
    ['V-BLOCK'] = 'UserMagenta',
    ['S-BLOCK'] = 'UserMagenta',
    ['REPLACE'] = 'UserRed',
    ['V-REPLACE'] = 'UserRed',
    ['SELECT'] = 'UserMagenta',
    ['COMMAND'] = 'UserYellow',
    ['TERMINAL'] = 'UserBlue',
  },
}

local function vi_bg_hl()
  return vi.bg_colors[mode_utils.get_mode()] or "UserRvBlack"
end

local function vi_fg_hl()
  return vi.fg_colors[mode_utils.get_mode()] or 'UserBlack'
end

local function diff_source()
  local gitsigns = vim.b.gitsigns_status_dict
  if gitsigns then
    return {
      added = gitsigns.added,
      modified = gitsigns.changed,
      removed = gitsigns.removed
    }
  end
end

local lualine_a = {
  {
    function()
      return '▊ '
    end,
    color = vi_fg_hl,
    padding = { right = 0 },
  },
  {
    'mode',
    icon = '',
    color = vi_fg_hl,
    padding = { left = 0, right = 1 },
  }
}

local lualine_b = {
  {
    'branch',
    icon = '',
    color = 'UserSLGitBranch',
  },
  {
    'diff',
    colored = true,
    diff_color = {
      added    = 'UserGreen',
      modified = 'UserYellow',
      removed  = 'UserRed'
    },
    symbols = {
      added    = ' ',
      modified = ' ',
      removed = ' '
    },
    source = diff_source
  }
}

local lualine_c = {
  {
    'filetype',
    icon_only = true,
    padding = { left = 1 },
  },
  {
    'filename',
    path = 1,
    symbols = {
      modified = '●',
      readonly = '🔒'
    }
  }
}

local lualine_x = {
  {
    'filetype',
    icons_enabled = false,
    color = 'UserSLAlt'
  },
  {
    'fileformat',
    color = 'StatusLine'
  },
  {
    'encoding',
    color = 'StatusLine',
    padding = { right = 1 },
  }
}

local lualine_y = {
  {
    'location',
    color = 'UserRvBlack'
  }
}

local lualine_z = {
  {
    'progress',
    color = vi_bg_hl,
  }
}

local inactive_lualine_c = {
  {
    'filename',
    path = 1,
    symbols = {
      modified = '●',
      readonly = '🔒'
    },
  }
}

require('lualine').setup {
  options = {
    component_separators = '',
    section_separators = '',
    icons_enabled = true,
    theme = 'auto',
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = lualine_a,
    lualine_b = lualine_b,
    lualine_c = lualine_c,
    lualine_x = lualine_x,
    lualine_y = lualine_y,
    lualine_z = lualine_z
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = inactive_lualine_c,
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
