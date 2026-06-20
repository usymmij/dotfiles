-- table mode
vim.keymap.set('n', '<leader>mt', ':TableModeToggle<Enter>', {})

-- rendering
--vim.keymap.set('n', 'mp', ':MarkdownPreview<Enter>', {})
vim.keymap.set('n', '<leader>mp', ':Markview splitToggle<Enter>', {})
vim.keymap.set('n', '<leader>mm', ':Markview Toggle<Enter>', {})

-- render images
vim.keymap.set('n', 'mi', function()
    image_nvim = require 'image'
    if image_nvim.is_enabled() then
        image_nvim.disable()
    else
        image_nvim.enable()
    end
end, {})

-- paste image
vim.keymap.set('n', '<leader>i', function()
    local filepath = vim.fn.expand '%'
    local path = string.match(filepath, '(.-)([^\\/]-%.?([^%.\\/]*))$')
    local filename = string.match(filepath, '[^\\/]-$')
    os.execute('~/.scripts/cpshot.sh ' .. path .. '.imgs/' .. filename .. '/')
    local cpshotwrite = io.open('/tmp/cpshot_last_write_path', 'r')
    if cpshotwrite ~= nil then
        local imagepath = cpshotwrite:read '*l'
        local imagename = cpshotwrite:read '*l'
        cpshotwrite:close()

        local linenum, _ = unpack(vim.api.nvim_win_get_cursor(0))

        print(imagepath .. imagename)
        vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), linenum, linenum, false,
            { '![](.imgs/' .. filename .. '/' .. imagename .. ')', '' })
        vim.cmd 'normal jj'
    else
        print 'cpshot last write path not found in /tmp'
    end
end, {})

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
