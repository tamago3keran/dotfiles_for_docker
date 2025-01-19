-- lua_source {{{
local filename = require("tabby.filename")

local cwd = function()
  return " 󰚌 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
end

local excluded_files = { "ddu-filer-filer" }
local function is_excluded(winid)
  local bufid = vim.api.nvim_win_get_buf(winid)
  local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufid), ":t")
  return vim.tbl_contains(excluded_files, fname)
end

local line = {
  hl = "UserCLFill",
  layout = "active_wins_at_tail",
  head = {
    { cwd, hl = "UserTLHead" },
  },
  active_tab = {
    label = function(tabid)
      return {
        "  " .. tabid .. " ",
        hl = "UserTLActive",
      }
    end,
  },
  inactive_tab = {
    label = function(tabid)
      return {
        "  " .. tabid .. " ",
        hl = "UserTLBoldLine",
      }
    end,
  },
  top_win = {
    label = function(winid)
      if is_excluded(winid) then
        return { "" }
      end
      return {
        "  " .. filename.unique(winid) .. " ",
        hl = "TabLine",
      }
    end,
  },
  win = {
    label = function(winid)
      if is_excluded(winid) then
        return { "" }
      end
      return {
        "  " .. filename.unique(winid) .. " ",
        hl = "TabLine",
      }
    end,
  },
  tail = {
    { "  ", hl = "UserTLHead" },
  },
}

require("tabby").setup {
  tabline = line,
}
-- }}}
