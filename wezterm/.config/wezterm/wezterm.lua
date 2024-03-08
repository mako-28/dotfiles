local wezterm = require 'wezterm';
local mux = wezterm.mux

return {
  font = wezterm.font_with_fallback({
    "UDEV Gothic 35NF",
  }),
  font_size = 14.5,
  line_height = 1.2,
  --  color_scheme = "OneHalfDark", -- 自分の好きなテーマ探す https://wezfurlong.org/wezterm/colorschemes/index.html
  --  color_scheme = "Japanesque",
  color_scheme = "Ayu Mirage",
  hide_tab_bar_if_only_one_tab = true,
  adjust_window_size_when_changing_font_size = false,
  macos_forward_to_ime_modifier_mask = "SHIFT|CTRL",
  scrollback_lines = 10000,


  wezterm.on("gui-startup", function()
    local tab, pane, window = mux.spawn_window{}
    window:gui_window():maximize()
  end),

  -- timeout_milliseconds defaults to 1000 and can be omitted
  leader = { key = 'a', mods = 'CMD', timeout_milliseconds = 1000 },
  keys = {
    {
      key = '|',
      mods = 'LEADER|SHIFT',
      action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
    },
    {
      key = '=',
      mods = 'LEADER',
      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
    },
    {
      key = 'g',
      mods = 'LEADER',
      action = wezterm.action.PaneSelect,
    },
    {
      key = 'n',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Next',
    },
    {
      key = 'p',
      mods = 'LEADER',
      action = wezterm.action.ActivatePaneDirection 'Prev',
    },
    {
      key = 'h',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Left', 5 },
    },
    {
      key = 'H',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Left', 30 },
    },
    {
      key = 'j',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Down', 5 },
    },
    {
      key = 'J',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Down', 10 },
    },
    {
      key = 'k',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Up', 5 },
    },
    {
      key = 'K',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Up', 10 },
    },
    {
      key = 'l',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Right', 5 },
    },
    {
      key = 'L',
      mods = 'LEADER',
      action = wezterm.action.AdjustPaneSize { 'Right', 30 },
    },
  },
}

