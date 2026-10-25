local wezterm = require("wezterm")

local appearance = {}

function appearance.setup(config)
    config.window_decorations = "INTEGRATED_BUTTONS"

    config.window_frame = {
        active_titlebar_bg = "none",
        inactive_titlebar_bg = "none",
        font = wezterm.font("PlemolJP Console NF", { weight = "Regular" }),
    }

    config.window_padding = {
        left = 10,
        right = 10,
        top = 10,
        bottom = 10,
    }

    config.window_background_opacity = 0.75

    config.window_background_gradient = {
        colors = { "rgba(40,44,52,0.9)", "rgba(40,44,52,0.9)" },
    }

    config.inactive_pane_hsb = {
        saturation = 1.0,
        brightness = 0.75,
    }


    config.initial_cols = 100
    config.initial_rows = 40

    config.font = wezterm.font("PlemolJP Console NF", { weight = "Regular" })

    config.colors = {
        tab_bar = {
            inactive_tab_edge = "none",
            background = "none",
        },
        background = "#282c34",
    }

    config.color_scheme = "OneDark (base16)"
end

return appearance
