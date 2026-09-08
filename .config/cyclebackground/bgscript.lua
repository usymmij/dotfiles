#!/usr/bin/env lua

local home = os.getenv("HOME")
local themepath = home .. "/.config/cyclebackground/backgrounds/"

local function error(message, fatal)
    io.stderr:write('\27[31m' .. message .. '\27[00m')

    if fatal then
        os.exit(1)
    end
end

-- check existence
local function file_exists(path)
    local f = io.open(path, "r")
    if f then
        f:close(); return true
    end
    return false
end

-- list themes in the directory
local function list_themes(path)
    local themes = {}
    local p = io.popen('ls "' .. path .. '"')
    if not p then
        error("could not access " .. path .. " to read themes\n", true)
        return themes
    end
    for line in p:lines() do
        table.insert(themes, line)
    end
    p:close()
    return themes
end

-- get enabled themes
local function filter_enabled_themes(themes, filepath)
    if file_exists(filepath) then
        local f = io.open(filepath)
        if not f then
            error("couldn't read " .. filepath, true)
        end
        local enabled_themes = {}
        print("enabled themes\n================")
        for line in f:lines() do
            if line ~= "" then -- ignore newlines
                local themeexists = false
                for _, theme in ipairs(themes) do
                    if theme == line then
                        themeexists = true
                        break
                    end
                end

                if themeexists then
                    print(line)
                    table.insert(enabled_themes, line)
                else
                    error('\27[31m' .. line .. " is enabled but does not exist\27[00m\n", false)
                end
            end
        end
        f:close()
        return enabled_themes
    else
        return themes -- all themes enabled
    end
end

-- Read first line of a file
local function read_first_line(path)
    local f = io.open(path, "r")
    if not f then return nil end
    local line = f:read("*l")
    f:close()
    return line
end

local themes = list_themes(themepath)
themes = filter_enabled_themes(themes, home .. "/.config/cyclebackground/enabled_backgrounds.conf")

local currtheme
if file_exists("/tmp/current_background") then
    currtheme = read_first_line("/tmp/current_background")
else
    currtheme = read_first_line(home .. "/.config/cyclebackground/current_background")
end
print("current theme is", currtheme)

local newtheme = nil
local found = 0

local arg = arg[1]

if arg == "startup" then
    newtheme = currtheme
else
    for _, theme in ipairs(themes) do
        if found == 2 then
            break
        end
        if found == 1 then
            newtheme = theme
            found = 2
        end
        if theme == currtheme then
            found = 1
        end
    end

    if found < 2 then
        newtheme = themes[1] or ""
    end
end

local f = io.open("/tmp/current_background", "w")
if not f then
    error("could not write to /tmp/current_background\n", true)
end
f:write(newtheme .. "\n")
f:close()

if arg == "startup" then
    local code = nil
    while not code do
        code = os.execute('hyprctl hyprpaper wallpaper ", ' .. themepath .. newtheme .. '"')
    end
else
    os.execute('hyprctl hyprpaper wallpaper ", ' .. themepath .. newtheme .. '"')
end


print("\nchanged background: " .. tostring(currtheme) .. " => " .. newtheme)
