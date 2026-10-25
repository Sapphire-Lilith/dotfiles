local wezterm = require("wezterm")

local platform = {}

function platform.setup(config)
    if wezterm.target_triple:match("darwin$") then
        config.macos_window_background_blur = 50
    end
end

return platform
