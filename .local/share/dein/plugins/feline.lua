local fmt = string.format
local vi_mode_utils = require('feline.providers.vi_mode')

----------------------------------------------------------------------------------------------------
-- Colors

---Convert color number to hex string
---@param n number
---@return string
local hex = function(n)
  if n then
    return fmt("#%06x", n)
  end
end

---Parse `style` string into nvim_set_hl options
---@param style string
---@return table
local function parse_style(style)
  if not style or style == "NONE" then
    return {}
  end

  local result = {}
  for token in string.gmatch(style, "([^,]+)") do
    result[token] = true
  end

  return result
end

---Get highlight opts for a given highlight group name
---@param name string
---@return table
local function get_highlight(name)
  local hl = vim.api.nvim_get_hl_by_name(name, true)
  if hl.link then
    return get_highlight(hl.link)
  end

  local result = parse_style(hl.style)
  result.fg = hl.foreground and hex(hl.foreground)
  result.bg = hl.background and hex(hl.background)
  result.sp = hl.special and hex(hl.special)

  return result
end

---Set highlight group from provided table
---@param groups table
local function set_highlights(groups)
  for group, opts in pairs(groups) do
    vim.api.nvim_set_hl(0, group, opts)
  end
end

---Generate a color palette from the current applied colorscheme
---@return table
local function generate_pallet_from_colorscheme()
  -- stylua: ignore
  local color_map = {
    black   = { index = 0, default = "#393b44" },
    red     = { index = 1, default = "#c94f6d" },
    green   = { index = 2, default = "#81b29a" },
    yellow  = { index = 3, default = "#dbc074" },
    blue    = { index = 4, default = "#719cd6" },
    magenta = { index = 5, default = "#9d79d6" },
    cyan    = { index = 6, default = "#63cdcf" },
    white   = { index = 7, default = "#dfdfe0" },
  }

  local diagnostic_map = {
    hint = { hl = "DiagnosticHint", default = color_map.green.default },
    info = { hl = "DiagnosticInfo", default = color_map.blue.default },
    warn = { hl = "DiagnosticWarn", default = color_map.yellow.default },
    error = { hl = "DiagnosticError", default = color_map.red.default },
  }

  local pallet = {}
  for name, value in pairs(color_map) do
    local global_name = "terminal_color_" .. value.index
    pallet[name] = vim.g[global_name] and vim.g[global_name] or value.default
  end

  for name, value in pairs(diagnostic_map) do
    pallet[name] = get_highlight(value.hl).fg or value.default
  end

  pallet.sl = get_highlight("StatusLine")
  pallet.sel = get_highlight("TabLineSel")

  return pallet
end

---Generate user highlight groups based on the curent applied colorscheme
---
---NOTE: This is a global because I dont known where this file will be in your config
---and it is needed for the autocmd below
_G._generate_user_statusline_highlights = function()
  local pal = generate_pallet_from_colorscheme()

  -- stylua: ignore
  local sl_colors = {
    Black   = { fg = pal.black,   bg = pal.white },
    Red     = { fg = pal.red,     bg = pal.sl.bg },
    Green   = { fg = pal.green,   bg = pal.sl.bg },
    Yellow  = { fg = pal.yellow,  bg = pal.sl.bg },
    Blue    = { fg = pal.blue,    bg = pal.sl.bg },
    Magenta = { fg = pal.magenta, bg = pal.sl.bg },
    Cyan    = { fg = pal.cyan,    bg = pal.sl.bg },
    White   = { fg = pal.white,   bg = pal.black },
  }

  local colors = {}
  for name, value in pairs(sl_colors) do
    colors["User" .. name] = { fg = value.fg, bg = value.bg, bold = true }
    colors["UserRv" .. name] = { fg = value.bg, bg = value.fg, bold = true }
  end

  local status = vim.o.background == "dark" and { fg = pal.black, bg = pal.white } or { fg = pal.white, bg = pal.black }

  local groups = {
    -- statusline
    UserSLHint = { fg = pal.sl.bg, bg = pal.hint, bold = true },
    UserSLInfo = { fg = pal.sl.bg, bg = pal.info, bold = true },
    UserSLWarn = { fg = pal.sl.bg, bg = pal.warn, bold = true },
    UserSLError = { fg = pal.sl.bg, bg = pal.error, bold = true },
    UserSLStatus = { fg = status.fg, bg = status.bg, bold = true },

    UserSLFtHint = { fg = pal.sel.bg, bg = pal.hint },
    UserSLHintInfo = { fg = pal.hint, bg = pal.info },
    UserSLInfoWarn = { fg = pal.info, bg = pal.warn },
    UserSLWarnError = { fg = pal.warn, bg = pal.error },
    UserSLErrorStatus = { fg = pal.error, bg = status.bg },
    UserSLStatusBg = { fg = status.bg, bg = pal.sl.bg },

    UserSLAlt = pal.sel,
    UserSLAltSep = { fg = pal.sl.bg, bg = pal.sel.bg },
    UserSLGitBranch = { fg = pal.yellow, bg = pal.sl.bg },
  }

  set_highlights(vim.tbl_extend("force", colors, groups))
end

_generate_user_statusline_highlights()

vim.api.nvim_create_augroup("UserStatuslineHighlightGroups", { clear = true })
vim.api.nvim_create_autocmd({ "SessionLoadPost", "ColorScheme" }, {
  callback = function()
    _generate_user_statusline_highlights()
  end,
})

----------------------------------------------------------------------------------------------------
-- Feline

local components = {
  active = {},
  inactive = {}
}

local vi = {
  bg_colors = {
    ['NORMAL'] = 'UserRvCyan',
    ['INSERT'] = 'UserSLStatus',
    ['VISUAL'] = 'UserRvMagenta',
    ['V-LINE'] = 'UserRvMagenta',
    ['V-BLOCK'] = 'UserRvMagenta',
    ['REPLACE'] = 'UserRvRed',
    ['SELECT'] = 'UserRvMagenta',
    ['COMMAND'] = 'UserRvYellow',
    ['TERMINAL'] = 'UserRvBlue',
  },

  fg_colors = {
    ['NORMAL'] = 'UserCyan',
    ['INSERT'] = 'UserSLStatusBg',
    ['VISUAL'] = 'UserMagenta',
    ['V-LINE'] = 'UserMagenta',
    ['V-BLOCK'] = 'UserMagenta',
    ['REPLACE'] = 'UserRed',
    ['SELECT'] = 'UserMagenta',
    ['COMMAND'] = 'UserYellow',
    ['TERMINAL'] = 'UserBlue',
  }
}

local function vi_bg_hl()
  return vi.bg_colors[vi_mode_utils.get_vim_mode()] or "UserSLViBlack"
end

local function vi_fg_hl()
  return vi.fg_colors[vi_mode_utils.get_vim_mode()] or "UserSLBlack"
end

components.active[1] = {
  {
    provider = '▊ ',
    hl = vi_fg_hl,
  },
  {
    provider = 'vi_mode',
    hl = vi_fg_hl,
  },
  {
    provider = function() return fmt(" %s ", vi_mode_utils.get_vim_mode()) end,
    hl = vi_fg_hl,
  },
  {
    provider = "git_branch",
    hl = "UserSLGitBranch",
    left_sep = { str = " ", hl = "UserSLGitBranch" },
    right_sep = { str = " ", hl = "UserSLGitBranch" },
    enabled = function() return vim.b.gitsigns_status_dict ~= nil end,
  },
  {
    provider = { name = "file_info", opts = { type = "relative" } },
    hl = "UserSLAlt",
    left_sep = { str = " ", hl = "UserSLAlt" },
    right_sep = { str = " ", hl = "UserSLAlt" },
  },
  {
    provider = "",
    hl = "StatusLine",
  },
}

require('feline').setup {
  components = {
    active = components.active,
  }
}
