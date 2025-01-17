vim.opt.compatible = false

vim.opt.number = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.splitright = true
vim.opt.winblend = 15

vim.env.CONFIG_DIR = "~/.config"
vim.env.HOOKS_DIR = "~/.config/hooks"
vim.env.TOMLS_DIR = "~/.config/tomls"
vim.env.CACHE_DIR = "~/.cache"

local dppBase = vim.env.CACHE_DIR .. "/dpp"
local dppSrc = vim.env.CACHE_DIR .. "/dpp/repos/github.com/Shougo/dpp.vim"
local dppLazy = vim.env.CACHE_DIR .. "/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local dppInstaller = vim.env.CACHE_DIR .. "/dpp/repos/github.com/Shougo/dpp-ext-installer"
local dppToml = vim.env.CACHE_DIR .. "/dpp/repos/github.com/Shougo/dpp-ext-toml"
local dppGit = vim.env.CACHE_DIR .. "/dpp/repos/github.com/Shougo/dpp-protocol-git"
local denopsSrc = vim.env.CACHE_DIR .. "/dpp/repos/github.com/vim-denops/denops.vim"
local dppConfig = vim.env.CONFIG_DIR .. "/dpp/dpp.ts"

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
      vim.notify("dpp load_state() is failed", "info", {title = "dpp.vim"})
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
    vim.notify("dpp make_state() is done", "info", {title = "dpp.vim"})
  end,
})

vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")
