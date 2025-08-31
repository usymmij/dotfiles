vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = '*.typ', command = 'setfiletype typst' })
