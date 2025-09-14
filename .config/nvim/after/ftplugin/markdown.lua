-- table mode
vim.keymap.set('n', 'tm', ':TableModeToggle<Enter>', {})
-- rendering
vim.keymap.set('n', 'mp', ':MarkdownPreview<Enter>', {})
vim.keymap.set('n', 'mr', ':RenderMarkdown toggle<Enter>', {})

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

                vim.fn.deletebufline(1, entryline - deleteoffset, entryline + repcount - deleteoffset - 1)

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
    local filename = vim.fn.expand '%'
    if filename:sub(1, 1) == '.' then
        error 'in a dotfile'
    end
    local writefile = io.open('.' .. filename, 'r')
    if writefile == nil then
        writefile = io.open('.' .. filename, 'w+')
        writefile:close()
        writefile = io.open('.' .. filename, 'r')
    end
    local writelist = {}

    local line = writefile:read '*l'
    while line ~= nil do
        writelist[#writelist + 1] = line
        line = writefile:read '*l'
    end
    writefile:close()

    local readlistlen = vim.api.nvim_buf_line_count(0)
    local readlist = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)

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

    writefile = assert(io.open('.' .. filename, 'w+'))

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
end

vim.keymap.set('n', 'mcl', function()
    cleanlist()
    vim.cmd 'w'
    vim.cmd('vs .' .. vim.fn.expand '%')
end, {})

-- flip checkbox
vim.keymap.set('n', 'fc', function()
    local line = vim.api.nvim_get_current_line()
    local _, linenum = unpack(vim.api.nvim_win_get_cursor(0))
    local offset = 0
    while line:sub(1, 1) == ' ' or line:sub(1, 1) == '\t' do
        offset = offset + 1
        line = line:sub(2)
    end
    if line:sub(1, 2) == '- [' and line:sub(4, 4) == ']' then
        local replace = ' '
        if line:sub(3, 3) == ' ' then
            replace = 'x'
        end
        println(offset + 1)
        vim.api.nvim_buf_set_lines(1, offset + 1, offset + 1, false, { replace })
    end
end, {})
