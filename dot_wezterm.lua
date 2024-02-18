-- Pull in the wezterm APIs
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- Spawn a fish shell in login mode
config.default_prog = { '/usr/local/bin/fish', '-l' }

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
--config.color_scheme = 'Solarized (light) (terminal.sexy)'
--config.color_scheme = 'Trim Yer Beard (terminal.sexy)'
--config.color_scheme = 'Monokai (light) (terminal.sexy)'
--config.color_scheme = 'Mocha (light) (terminal.sexy)'
--config.color_scheme = 'Gruvbox light, soft (base16)'
config.color_scheme = 'Catppuccin Latte'
--config.color_scheme = 'matrix'
--config.color_scheme = 'Mellow Purple (base16)'
--config.color_scheme = 'Morada (Gogh)'
--config.color_scheme = 'Monokai Pro Ristretto (Gogh)'

--colors, metadata = wezterm.color.load_terminal_sexy_scheme("/Users/james/Downloads/jzp-colour-scheme.json")
config.colors=colors
-- Set up fonts
-- and finally, return the configuration to wezterm


config.font_size = 16.0
config.font = wezterm.font('Liga Hasklug Nerd Font', {weight = 'Regular'})
-- config.font = wezterm.font('CaskaydiaCove Nerd Font Mono', {weight = 'DemiLight'})
-- config.font = wezterm.font {
--   family = 'Fira Code',
--   -- family = 'FiraCode Nerd Font Mono',
--   weight = 'Regular',
--   harfbuzz_features = {'ss01','zero'},
-- }


config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = false


return config




