hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@240",
    position = "0x0",
    scale    = 1,
})
hl.monitor({
    output    = "HDMI-A-1",
    mode      = "1920x1080@60",
    position  = "-1080x0",
    scale     = 1,
    transform = 1,
})
hl.workspace_rule({ workspace = "1", monitor = "DP-1" })
hl.workspace_rule({ workspace = "2", monitor = "DP-1" })
hl.workspace_rule({ workspace = "3", monitor = "DP-1" })
hl.workspace_rule({ workspace = "4", monitor = "DP-1" })
hl.workspace_rule({ workspace = "5", monitor = "DP-1" })
hl.workspace_rule({ workspace = "6", monitor = "DP-1" })
hl.workspace_rule({ workspace = "7", monitor = "DP-1" })
hl.workspace_rule({ workspace = "8", monitor = "DP-1" })
hl.workspace_rule({ workspace = "9", monitor = "DP-1" })

hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "11", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "12", monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = "13", monitor = "HDMI-A-1" })

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("GBM_BACKEND", "nvidia-drm")
hl.env("NVD_BACKEND", "direct")
