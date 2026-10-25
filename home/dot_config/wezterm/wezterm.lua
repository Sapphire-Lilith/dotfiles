local wezterm = require("wezterm")

local config = wezterm.config_builder()

local function load_module(file)
    local module = require(file)

    if module.setup then
        module.setup(config)
    end

    if module.init then
        module.init()
    end

    for k, v in pairs(module) do
        if not (k == "setup" or k == "init") then
            config[k] = v
        end
    end
end

load_module("platform")
load_module("appearance")
load_module("tabs")
load_module("statusbar")

return config
