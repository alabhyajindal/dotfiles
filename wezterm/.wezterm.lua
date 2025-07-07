-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- Change theme based on current appearance
function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'tokyonight_moon'
  else
    return 'tokyonight_day'
  end
end

wezterm.on('window-config-reloaded', function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)


-- This will hold the configuration
local config = wezterm.config_builder()

-- Config choices
-- config.font_size = 14
config.font = wezterm.font 'JetBrains Mono NL'
config.hide_tab_bar_if_only_one_tab = true

return config
