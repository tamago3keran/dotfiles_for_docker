local filename = require("tabby.filename")

local cwd = function()
  return " 󰚌 " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
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
      return {
        "  " .. filename.unique(winid) .. " ",
        hl = "TabLine",
      }
    end,
  },
  win = {
    label = function(winid)
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
