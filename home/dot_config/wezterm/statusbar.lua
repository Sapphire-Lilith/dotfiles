local wezterm = require("wezterm")

local statusbar = {}

local battery_icons = {
    charging = {
        { min = 100, icon = wezterm.nerdfonts.md_battery_charging_100,     color = "#98c379" },
        { min = 90,  icon = wezterm.nerdfonts.md_battery_charging_90,      color = "#98c379" },
        { min = 80,  icon = wezterm.nerdfonts.md_battery_charging_80,      color = "#98c379" },
        { min = 70,  icon = wezterm.nerdfonts.md_battery_charging_70,      color = "#98c379" },
        { min = 60,  icon = wezterm.nerdfonts.md_battery_charging_60,      color = "#98c379" },
        { min = 50,  icon = wezterm.nerdfonts.md_battery_charging_50,      color = "#98c379" },
        { min = 40,  icon = wezterm.nerdfonts.md_battery_charging_40,      color = "#e5c07b" },
        { min = 30,  icon = wezterm.nerdfonts.md_battery_charging_30,      color = "#e5c07b" },
        { min = 20,  icon = wezterm.nerdfonts.md_battery_charging_20,      color = "#e06c75" },
        { min = 10,  icon = wezterm.nerdfonts.md_battery_charging_10,      color = "#e06c75" },
        { min = 0,   icon = wezterm.nerdfonts.md_battery_charging_outline, color = "#e06c75" },
    },
    discharging = {
        { min = 100, icon = wezterm.nerdfonts.md_battery,       color = "#98c379" },
        { min = 90,  icon = wezterm.nerdfonts.md_battery_90,    color = "#98c379" },
        { min = 80,  icon = wezterm.nerdfonts.md_battery_80,    color = "#98c379" },
        { min = 70,  icon = wezterm.nerdfonts.md_battery_70,    color = "#98c379" },
        { min = 60,  icon = wezterm.nerdfonts.md_battery_60,    color = "#98c379" },
        { min = 50,  icon = wezterm.nerdfonts.md_battery_50,    color = "#98c379" },
        { min = 40,  icon = wezterm.nerdfonts.md_battery_40,    color = "#e5c07b" },
        { min = 30,  icon = wezterm.nerdfonts.md_battery_30,    color = "#e5c07b" },
        { min = 20,  icon = wezterm.nerdfonts.md_battery_20,    color = "#e06c75" },
        { min = 10,  icon = wezterm.nerdfonts.md_battery_10,    color = "#e06c75" },
        { min = 0,   icon = wezterm.nerdfonts.md_battery_alert, color = "#e06c75" },
    }
}

local clock_icons = {
    wezterm.nerdfonts.md_clock_time_one_outline,
    wezterm.nerdfonts.md_clock_time_two_outline,
    wezterm.nerdfonts.md_clock_time_three_outline,
    wezterm.nerdfonts.md_clock_time_four_outline,
    wezterm.nerdfonts.md_clock_time_five_outline,
    wezterm.nerdfonts.md_clock_time_six_outline,
    wezterm.nerdfonts.md_clock_time_seven_outline,
    wezterm.nerdfonts.md_clock_time_eight_outline,
    wezterm.nerdfonts.md_clock_time_nine_outline,
    wezterm.nerdfonts.md_clock_time_ten_outline,
    wezterm.nerdfonts.md_clock_time_eleven_outline,
    wezterm.nerdfonts.md_clock_time_twelve_outline,
}

function statusbar.init()
    wezterm.on("update-right-status", function(window, pane)
        -- battery
        local bat_icon = ""
        local bat_txt = ""
        local bat_color = "white"

        for _, b in ipairs(wezterm.battery_info()) do
            local charge = b.state_of_charge * 100
            local is_charging = b.state == "Charging"
            local icon_set = is_charging and battery_icons.charging or battery_icons.discharging

            for _, e in ipairs(icon_set) do
                if charge >= e.min then
                    bat_icon = e.icon
                    bat_color = e.color
                    break
                end
            end

            bat_txt = string.format("%.0f%%", charge)
        end

        -- date
        local date_icon = wezterm.nerdfonts.md_calendar
        local date_txt = wezterm.strftime("%Y-%m-%d")

        -- time
        local hour = tonumber(wezterm.strftime("%I"))
        local time_icon = clock_icons[hour == 0 and 12 or hour]
        local time_txt = wezterm.strftime("%H:%M")

        -- assemble status
        local LEFT_DIVIDER = wezterm.nerdfonts.pl_right_hard_divider
        local status_bg = "#3e4451"
        local edge_bg = "none"

        window:set_right_status(wezterm.format({
            { Background = { Color = edge_bg } },
            { Foreground = { Color = status_bg } },
            { Text = LEFT_DIVIDER },

            { Background = { Color = status_bg } },
            { Foreground = { Color = bat_color } },
            { Text = " " .. bat_icon .. " " .. bat_txt .. " " },

            { Background = { Color = status_bg } },

            { Foreground = { Color = "#abb2bf" } },
            { Text = " " .. date_icon .. " " .. date_txt .. " " },

            { Background = { Color = status_bg } },
            { Foreground = { Color = "#abb2bf" } },
            { Text = " " .. time_icon .. " " .. time_txt .. " " },
        }))
    end)
end

return statusbar
