-- Typst render
vim.api.nvim_set_keymap("n", "<C-p>", ":!typst compile '" .. vim.fn.expand('%') .. "'<Enter>", {});

-- flip checkbox
vim.keymap.set('n', '<leader>c', function()
    local line = vim.api.nvim_get_current_line()              -- str w/ curr line
    local linenum, _ = unpack(vim.api.nvim_win_get_cursor(0)) -- linenum of cursor
    local offset = 0
    while line:sub(1, 1) == ' ' or line:sub(1, 1) == '\t' do
        offset = offset + 1
        line = line:sub(2)
    end
    if line:sub(1, 3) == '- [' and line:sub(5, 5) == ']' then
        local replace = ' '
        if line:sub(4, 4) == ' ' then
            replace = 'x'
        end
        vim.api.nvim_buf_set_text(vim.api.nvim_get_current_buf(), linenum - 1, offset + 3, linenum - 1, offset + 4,
            { replace })
    end
end, { desc = 'flip checkbox' })
