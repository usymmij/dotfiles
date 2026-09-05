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
    hl.exec_cmd("waybar")
    -- wayland magic for screen sharing
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd(
        "systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
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
    opacity = 0.8,
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

-- window rule for screen sharing video bridge
hl.window_rule({
    match = {
        class = "xwaylandvideobridge"
    },
    opacity = 0.0,
    no_anim = true,
    max_size = { 1.0, 1.0 },
    no_initial_focus = true,
    no_blur = true,
    no_focus = true,
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
hl.bind(mainMod .. " + CTRL + T", hl.dsp.exec_cmd("kitty"))                 -- open the terminal
hl.bind(mainMod .. " + F4", hl.dsp.window.close())                          -- close the active window
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd("wofi"))                     -- Show the graphical app launcher
hl.bind(workspaceMod .. " + S", hl.dsp.window.float({ action = "toggle" })) -- Allow a window to float
hl.bind(workspaceMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))        -- Lock the screen

-- Screenshots
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("hyprshot -m region -z"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("hyprshot -m output"))

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

-- env vars
-- XDG stuff
-- env = XDG_MENU_PREFIX, arch-
-- env = XDG_SESSION_TYPE,wayland
-- env = XDG_CURRENT_DESKTOP,Hyprland
-- env = XDG_SESSION_DESKTOP,Hyprland
hl.env("XDG_CONFIG_HOME", "/home/jimmy/.config")

-- idk electron stuff check hyprland docs
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- qt6 stuff
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland") -- sometimes the value xcb is required for matplotlib
hl.env("QT_STYLE_OVERRIDE", "qt6ct")

-- hyprshot save dir
hl.env("HYPRSHOT_DIR", "screenshots")

-- default editor
hl.env("VISUAL", "nvim")
hl.env("EDITOR", "nvim")
