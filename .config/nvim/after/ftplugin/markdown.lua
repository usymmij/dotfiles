-- table mode
vim.keymap.set('n', '<leader>mt', ':TableModeToggle<Enter>', {})

-- rendering
--vim.keymap.set('n', 'mp', ':MarkdownPreview<Enter>', {})
vim.keymap.set('n', '<leader>mp', ':Markview splitToggle<Enter>', {})

vim.keymap.set('n', '<leader>mm', ':Markview toggle<Enter>', {})

-- render markdown
-- vim.keymap.set('n', 'mr', function()
--     image_nvim = require 'image'
--     if image_nvim.is_enabled() then
--         image_nvim.disable()
--         vim.cmd 'RenderMarkdown disable'
--     else
--         image_nvim.enable()
--         vim.cmd 'RenderMarkdown enable'
--     end
-- end, {})

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
        vim.api.nvim_buf_set_lines(vim.api.nvim_get_current_buf(), linenum, linenum, false, { '![](.imgs/' .. filename .. '/' .. imagename .. ')', '' })
        vim.cmd 'normal jj'
    else
        print 'cpshot last write path not found in /tmp'
    end
end, {})

-- list moving
function println(str) -- print w newline
    print(str .. '\n')
end

-- not the greatest impl of a stack but good enough
Stack = {}
function Stack:new()
    local stack = {}
    stack._entries = {}

    function stack:pop()
        local ret = self._entries[#self._entries]
        self._entries[#self._entries] = nil
        return ret
    end
    function stack:get()
        return self._entries[#self._entries]
    end
    function stack:push(x)
        self._entries[#self._entries + 1] = x
    end
    function stack:len()
        return #self._entries
    end

    return stack
end

DEBUG = false
local function dumpFile(dump, file, linecount, allowunchecked, deletedumped)
    local hlevel = 0 -- level of the header while building tree
    local headerStack = Stack:new() -- stack holds the current position in tree
    headerStack:push(dump) -- root
    local entry = nil
    local entryline = 0
    local entryState = false
    local deleteoffset = 0

    local function logentry()
        if entry == nil then
            return
        end
        if entryState or allowunchecked then
            local headerentries = headerStack:get()
            if headerentries['entries'] == nil then
                headerentries['entries'] = ''
            end
            headerentries['entries'] = headerentries['entries'] .. entry

            if deletedumped then
                local _, repcount = entry:gsub('\n', '')

                vim.fn.deletebufline(vim.api.nvim_get_current_buf(), entryline - deleteoffset, entryline + repcount - deleteoffset - 1)

                deleteoffset = deleteoffset + repcount
            end
        end
    end

    for linenum = 1, linecount do -- for each line
        local line = file[linenum]
        local newhlevel = 0

        if line:len() > 5 and line:sub(1, 3) == '- [' and line:sub(5, 5) == ']' then -- new entry
            logentry()
            entryState = line:sub(4, 4) == 'x'
            entryline = linenum
            entry = line .. '\n'
        elseif line:len() > 6 and line:sub(1, 2) == '  ' then -- subportion of list
            entry = entry .. line .. '\n'
        else
            if entry ~= nil and line == '' then
                entry = entry .. '\n'
            end

            logentry()
            entry = nil
        end

        -- if the current line is a header
        if line:sub(1, 1) == '#' then
            -- count the header level
            while line:sub(newhlevel + 1, newhlevel + 1) == '#' do
                newhlevel = newhlevel + 1
            end

            -- orphaned headers not allowed
            if newhlevel > hlevel + 1 then
                error 'orphaned header'
            end

            -- put header in the stack
            local headername = line:sub(newhlevel + 2)
            local header = { name = headername } -- new node
            local parent = headerStack:get()
            while headerStack:len() > newhlevel do
                headerStack:pop()
                parent = headerStack:get()
            end
            if parent[headername] == nil then
                parent[#parent + 1] = header -- add node to tree
                parent[headername] = parent[#parent] -- add reference
            end
            headerStack:push(parent[headername])

            -- TODO
            hlevel = newhlevel
        end
    end
    logentry()

    return dump
end

local function cleanlist() -- removes checked 1st level boxes to hidden file
    local filename = (vim.fn.expand '%'):match '[^/]*.md$'
    local filepath = (vim.fn.expand '%'):match '^.*/'
    if filepath == nil then
        filepath = ''
    end
    local writepath = filepath .. '.' .. filename

    if filename:sub(1, 1) == '.' then
        error 'in a dotfile'
    end
    local writefile = io.open(writepath, 'r')
    if writefile == nil then
        writefile = io.open(writepath, 'w+')
        if writefile ~= nil then
            writefile:close()
        end
        writefile = io.open(writepath, 'r')
    end
    local writelist = {}

    if writefile ~= nil then
        local line = writefile:read '*l'
        while line ~= nil do
            writelist[#writelist + 1] = line
            line = writefile:read '*l'
        end
        writefile:close()
    end

    local readlistlen = vim.api.nvim_buf_line_count(0)
    local readlist = vim.api.nvim_buf_get_lines(vim.api.nvim_get_current_buf(), 0, vim.api.nvim_buf_line_count(0), false)

    -- dump the markdown headers into a tree
    local dump = { name = 'root' }

    dumpFile(dump, readlist, readlistlen, false, true)
    dumpFile(dump, writelist, #writelist, true, false)

    -- debugging: print out dump contents
    if DEBUG then
        local function check(d, nest)
            local tab = ('    '):rep(nest)
            println(tab .. d['name'])
            for r, v in pairs(d) do
                if type(v) == 'string' then
                    if r ~= 'name' then
                        println(tab .. r)
                        println ''
                        println(v)
                        println ''
                    end
                elseif type(v) == 'table' then
                    check(v, nest + 1)
                else
                    println(tab .. 'unexpected type')
                    println(tab .. type(v))
                end
            end
        end
        check(dump, 0)

        println 'done'
        println '\n\n\n'
    end

    writefile = assert(io.open(writepath, 'w+'))

    local function writesubtree(d, level)
        local tab = ('#'):rep(level)
        if level > 0 then
            writefile:write(tab .. ' ' .. d['name'] .. '\n')
        end
        if d.entries ~= nil then
            writefile:write(d.entries .. '\n')
        end
        for _, v in ipairs(d) do
            if type(v) == 'table' then
                writesubtree(v, level + 1)
            end
        end
    end
    writesubtree(dump, 0)
    writefile:close()
    return writepath
end

vim.keymap.set('n', '<leader>l', function()
    local path = cleanlist()
    vim.cmd 'w'
    vim.cmd('vs ' .. path)
end, { desc = 'move checked boxes to dotfile of same name' })

-- flip checkbox
vim.keymap.set('n', '<leader>c', function()
    local line = vim.api.nvim_get_current_line()
    local linenum, _ = unpack(vim.api.nvim_win_get_cursor(0))
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
        vim.api.nvim_buf_set_text(vim.api.nvim_get_current_buf(), linenum - 1, offset + 3, linenum - 1, offset + 4, { replace })
    end
end, { desc = 'flip checkbox' })
