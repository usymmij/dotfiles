-- from https://gist.github.com/Dregu/4c0dbb2582835e5d95e06c4bf7624e3b

--[[
Assuming you have configured a DP-1 you want to disable while streaming SUNSHINE-1, adjust to your liking.
Create a new "Headless" app in Sunshine, add a preparation command and set:
Do command:
sh -c "hyprctl eval \"sunshine(${SUNSHINE_CLIENT_WIDTH},${SUNSHINE_CLIENT_HEIGHT},${SUNSHINE_CLIENT_FPS},${SUNSHINE_CLIENT_HDR})\""
Undo command:
hyprctl eval "sunshine()"
Audio/Video - Display Id:
SUNSHINE-1
Advanced - Capture method:
wlroots
Stick this in ~/.config/hypr and add in hyprland.lua:
require('sunshine')
]]

-- Configures headless output to match stream parameters, disables real display
function sunshine(width, height, fps, hdr)
    if not width then
        -- Runs when stopping stream

        hl.monitor({ output = "DP-1", disabled = false })
        hl.monitor({ output = "HDMI-A-1", disabled = false })


        hl.exec_cmd('hyprctl output remove SUNSHINE-1')
        hl.dsp.focus({ monitor = 0 })
    else
        -- Runs when starting stream

        hl.exec_cmd('hyprctl output create headless SUNSHINE-1')

        hl.timer(function()
            hl.monitor {
                output = 'SUNSHINE-1',
                disabled = false,
                mode = string.format('%dx%d@%d', width, height, fps),
                -- These are just examples/what I use, set to what you wanna
                position = "2560x0", -- 'auto-left',
                scale = 1,
                bitdepth = hdr and 10 or 8,
                -- HDR probably doesn't work, but maybe one day
                supports_hdr = hdr and 1 or -1,
                supports_wide_color = hdr and 1 or -1,
                cm = hdr and 'hdr' or 'auto',
            }

            hl.dsp.focus({ monitor = "SUNSHINE-1" })

            hl.monitor({ output = "DP-1", disabled = true })
            hl.monitor({ output = "HDMI-A-1", disabled = true })
        end, { timeout = 100, type = "oneshot" })
    end
end
