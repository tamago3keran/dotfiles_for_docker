require('osc52').setup {}

local function copy(lines, _)
    require('osc52').copy(table.concat(lines, '\n'))
end

vim.g.clipboard = {
    name = 'osc52',
    copy = {['+'] = copy, ['*'] = copy},
    paste = {['+'] = '', ['*'] = ''},
}

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('Yank', {clear = true}),
    pattern = '*',
    callback = function()
        if vim.v.event.operator == 'y' and vim.v.event.regname == '' then
            require('osc52').copy_register ''
        end
    end,
})
