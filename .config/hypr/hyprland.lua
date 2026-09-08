-- persistent settings across systems
-- keep system-specific settings in local.lua
require('/home/jimmy/.config/hypr/local.lua')

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "auto",
})

hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("lua .config/cyclebackground/bgscript.lua startup")

    hl.exec_cmd("waybar")

    -- start wayscriber for screen annotations
    hl.exec_cmd("systemctl --user enable --now wayscriber.service")

    -- wayland XDG magic
    -- https://wiki.archlinux.org/title/XDG_Desktop_Portal#Portal_does_not_start
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- wifi and bt status icon
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    -- password permissions stuff
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    -- discord status
    hl.exec_cmd("ln -sf $XDG_RUNTIME_DIR/{app/com.discordapp.Discord,}/discord-ipc-0")


    -- auto open apps
    hl.exec_cmd("thunderbird", { workspace = "7 silent" })
    hl.exec_cmd("discord --start-minimized", { workspace = "6" })
end)

hl.on("hyprland.shutdown", function()
    hl.exec_cmd("cp /tmp/current_background ~/.config/cyclebackground/current_background")
end)

hl.config({
    general = {
        gaps_in = 5,
        gaps_out = 10,
        border_size = 2,
        col = {
            active_border = "rgb(cdd6f4)",
            inactive_border = "rgba(595959aa)",
        },
        layout = "dwindle",
        allow_tearing = true,
    },

    dwindle = {
        preserve_split = true
    },

    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "",
        kb_rules      = "",

        follow_mouse  = 2,
        accel_profile = "flat",

        sensitivity   = -0.2, -- -1.0 - 1.0, 0 means no modification.

        touchpad      = {
            natural_scroll = false,
            scroll_factor = 0.5
        },
    },

    misc = {
        -- the default backgrounds
        disable_hyprland_logo = true,
    },

    xwayland = {
        force_zero_scaling = true
    },

    decoration = {
        blur = {
            enabled = true,
            size = 7,
            passes = 4,
        },
        rounding = 5,
    },

    animations = {
        enabled = true
    },

})

-- curves for animations
hl.curve("simpleBezier", { type = "bezier", points = { { 0.10, 0.9 }, { 0.1, 1.05 } } })

-- animations
hl.animation({
    leaf = "windows", enabled = true, speed = 10, bezier = "simpleBezier", style = "slide"
})
hl.animation({
    leaf = "windowsOut", enabled = true, speed = 7, bezier = "simpleBezier", style = "slide"
})
hl.animation({
    leaf = "border", enabled = true, speed = 10, bezier = "default"
})
hl.animation({
    leaf = "workspaces", enabled = true, speed = 6, bezier = "default"
})

-- layer rules
hl.layer_rule({
    name = "no_anim_for_sel",
    match = {
        namespace = "selection",
    },
    no_anim = true,
})

-- window rules
hl.window_rule({
    match = {
        class = "kitty"
    },
    opacity = 0.9,
})
hl.window_rule({
    match = {
        class = "pavucontrol-qt"
    },
    float = true,
})
hl.window_rule({
    match = {
        class = "blueman-manager"
    },
    float = true,
})
hl.window_rule({
    match = {
        class = "nm-connection-editor"
    },
    float = true,
})
hl.window_rule({
    match = {
        title = "^(Write:).*"
    },
    float = true,
})
hl.window_rule({
    match = {
        title = "^(Export Image as).*"
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "Friends List"
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "Open File"
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "zoom"
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "New Event",
        class = "org.mozilla.Thunderbird"
    },
    float = true,
})

hl.window_rule({
    match = {
        title = "Discord Updater"
    },
    workspace = "6 silent"
})

hl.window_rule({
    match = {
        title = "Discord"
    },
    workspace = "6 silent"
})

-- touchpad gestures: for laptop
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

local mainMod = "ALT"
local workspaceMod = "SUPER"

-- some shortcuts
hl.bind(mainMod .. " + SHIFT + T", hl.dsp.exec_cmd("kitty"))                                     -- open the terminal
hl.bind(mainMod .. " + T",
    hl.dsp.exec_cmd("kitty", { float = true, size = { "(monitor_w*0.5)", "(monitor_h*0.5)" } })) -- open the terminal
hl.bind(mainMod .. " + F4", hl.dsp.window.close())                                               -- close the active window
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("hyprlauncher"))                                  -- Show the graphical app launcher
hl.bind(workspaceMod .. " + S", hl.dsp.window.float({ action = "toggle" }))                      -- Allow a window to float
hl.bind(workspaceMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))                             -- Lock the screen

-- hyprland
-- NOTE: in the next update (0.57.0) hl.dsp.reload_config() will be added to make this easier
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + Q", hl.dsp.exit())

-- Move focus with mainMod + HJKL
hl.bind(workspaceMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(workspaceMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(workspaceMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(workspaceMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Switch workspaces / move active window to a workspace with mainMod + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(workspaceMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind(workspaceMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end
hl.bind(workspaceMod .. " + minus", hl.dsp.focus({ workspace = 11 }))
hl.bind(workspaceMod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = 11 }))
hl.bind(workspaceMod .. " + equal", hl.dsp.focus({ workspace = 12 }))
hl.bind(workspaceMod .. " + SHIFT + equal", hl.dsp.window.move({ workspace = 12 }))
hl.bind(workspaceMod .. " + backspace", hl.dsp.focus({ workspace = 13 }))
hl.bind(workspaceMod .. " + SHIFT + backspace", hl.dsp.window.move({ workspace = 13 }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(workspaceMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(workspaceMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Master Layout Commands
-- hl.bind(workspaceMod .. " + M", hl.dsp.layout("swapwithmaster master"))
-- hl.bind(workspaceMod .. " + F", hl.dsp.layout("focusmaster auto"))
-- hl.bind(workspaceMod .. " + L", hl.dsp.layout("cyclenext"))
-- hl.bind(workspaceMod .. " + H", hl.dsp.layout("cycleprev"))
-- swap layouts
-- hl.bind(workspaceMod .. " + D", hl.dsp.exec_cmd('hyprctl keyword general:layout "dwindle"'))
-- hl.bind(workspaceMod .. " + SHIFT + D", hl.dsp.exec_cmd('hyprctl keyword general:layout "master"'))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(workspaceMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(workspaceMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"),
    { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { repeating = true, locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })
-- Requires playerctl
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })

-- screenshotting
local screenshotDir = "screenshots"

local function path_join(dir, file)
    if dir:sub(-1) == "/" then
        return dir .. file
    else
        return dir .. "/" .. file
    end
end

local function takeScreenshot(edit, freeze)
    return function()
        local filepath = path_join(screenshotDir, os.date("%Y-%m-%d-%H%M%S"))
        local editedfilepath = filepath .. '_edited.png'
        local rawfilepath = filepath .. ".png"

        local editInSwappy = edit and ('swappy -f ' .. rawfilepath .. ' -o ' .. editedfilepath
                .. ' && wl-copy --type image/png < ' .. editedfilepath .. ';') -- copy clipboard
            or ''
        local freezeScreen = freeze and '(hyprpicker -r -z & ) & sleep 0.1 &&' or ''
        local unfreezeScreen = freeze and 'pkill hyprpicker;'
            or ''

        -- run as a single bash line to prevent blocking in this function
        hl.dispatch(hl.dsp.exec_cmd(''
            .. freezeScreen                                        -- freeze screen
            .. 'grim -g "$(slurp)" ' .. rawfilepath .. ';'         -- take screenshot
            .. unfreezeScreen                                      -- unfreeze screen
            .. 'wl-copy --type image/png < ' .. rawfilepath .. ';' -- copy clipboard
            .. editInSwappy                                        -- edit in swappy
        ))
    end
end

hl.bind(mainMod .. " + P", takeScreenshot(false, true))
hl.bind(mainMod .. " + SHIFT + P", takeScreenshot(true, true))
hl.bind(mainMod .. " + bracketleft", takeScreenshot(false, false))
hl.bind(mainMod .. " + SHIFT + bracketleft", takeScreenshot(true, false))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd("hyprpicker | wl-copy"))

-- wayscriber
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("wayscriber --daemon-toggle"))


-- moving across monitors
local function shiftfocus()
    local currmon = hl.get_monitor_at_cursor()
    if currmon == nil then
        return
    end

    if currmon.id == 0 then
        hl.dispatch(hl.dsp.focus({ monitor = 1 }))
    else
        hl.dispatch(hl.dsp.focus({ monitor = 0 }))
    end

    hl.dispatch(hl.dsp.exec_cmd("notify-send 'on monitor " .. hl.get_monitor_at_cursor().name .. "'"))
end

-- swap monitor focus
hl.bind("SUPER + SHIFT + TAB", shiftfocus)
-- swap monitor workspaces
hl.bind("SUPER + TAB",
    hl.dsp.workspace.swap_monitors({ monitor1 = 0, monitor2 = 1 }))


-- env vars
-- XDG stuff
hl.env("XDG_CONFIG_HOME", "/home/jimmy/.config")

-- qt6 stuff
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland") -- sometimes the value xcb is required for matplotlib
hl.env("QT_STYLE_OVERRIDE", "qt6ct")

-- default editor
hl.env("VISUAL", "nvim")
hl.env("EDITOR", "nvim")
