local wezterm = require("wezterm")

local tabs = {}

function tabs.setup(config)
    config.tab_bar_at_bottom = false
    config.show_tabs_in_tab_bar = true
    config.show_new_tab_button_in_tab_bar = true
end

function tabs.init()
    wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
        local has_output = false
        for _, pane in ipairs(tab.panes) do
            if pane.has_unseen_output then
                has_output = true
                break
            end
        end

        local background = "#21252b"
        local foreground = "#5c6370"
        local edge_background = "none"

        if tab.is_active then
            background = "#8B71C7"
            foreground = "#282c34"
        elseif hover then
            background = "#3e4451"
            foreground = "#abb2bf"
        end

        local title = tab.tab_title

        if not title or #title == 0 then
            title = tab.active_pane.title
        end

        local output_icon = ""
        if has_output then
            output_icon = wezterm.nerdfonts.fa_bell .. " "
        end

        local max_title_len = max_width - 2

        if #title > max_title_len then
            title = wezterm.truncate_right(title, max_title_len)
        end

        local LEFT_DIVIDER = " "
        local RIGHT_DIVIDER = wezterm.nerdfonts.pl_left_hard_divider

        return {
            { Background = { Color = edge_background } },
            { Foreground = { Color = background } },
            { Text = LEFT_DIVIDER },
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = " " .. title .. " " },
            { Foreground = { Color = "#ffcc00" } },
            { Text = output_icon },
            { Background = { Color = edge_background } },
            { Foreground = { Color = background } },
            { Text = RIGHT_DIVIDER },
        }
    end)
end

return tabs
