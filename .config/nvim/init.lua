vim.opt.compatible = false

vim.opt.number = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.winblend = 15

local dppBase = "~/.cache/dpp"
local dppSrc = "~/.cache/dpp/repos/github.com/Shougo/dpp.vim"
local dppLazy = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local dppInstaller = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer"
local dppToml = "~/.cache/dpp/repos/github.com/Shougo/dpp-ext-toml"
local dppGit = "~/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git"
local denopsSrc = "~/.cache/dpp/repos/github.com/vim-denops/denops.vim"
local dppConfig = "~/.config/dpp/dpp.ts"

vim.opt.runtimepath:prepend(dppSrc)
vim.opt.runtimepath:prepend(dppLazy)
vim.opt.runtimepath:prepend(dppInstaller)
vim.opt.runtimepath:prepend(dppToml)
vim.opt.runtimepath:prepend(dppGit)
vim.opt.runtimepath:prepend(denopsSrc)

local dpp = require("dpp")

if dpp.load_state(dppBase) then
  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function()
      vim.notify("dpp load_state() is failed")
      dpp.make_state(dppBase, dppConfig)
    end,
  })
else
  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = {"*.lua", "*.vim", "*.toml", "*.ts", "vimrc", ".vimrc"},
    callback = function()
      dpp.check_files()
    end,
  })

  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = {"*.toml"},
    callback = function()
      if 0 < #dpp.sync_ext_action('installer', 'getNotInstalled') then
        dpp.async_ext_action('installer', 'install')
      end
    end,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("dpp make_state() is done")
  end,
})

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
