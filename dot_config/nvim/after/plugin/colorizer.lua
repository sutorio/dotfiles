-- vim:foldmethod=marker
-- =============================================================================
-- Colorizer settings
--
-- Colorizer will highlight anything it detects as a color declaration (eg hex 
-- colours, CSS rgb colours, etc) in that colour.
-- =============================================================================
-- {{{ Aliases
-- =============================================================================
local colorizer = require("colorizer")
local helpers = require("sutorio.helpers")
-- }}}
-- =============================================================================
-- {{{ Setup
-- =============================================================================
colorizer.setup({
    -- Specify filetypes to attach to. Can customise here per-filetype.
    "*";
}, {
    -- Defaults
    RGB      = true;         -- #RGB hex codes
	RRGGBB   = true;         -- #RRGGBB hex codes
	names    = true;         -- "Name" codes like Blue
	RRGGBBAA = true;         -- #RRGGBBAA hex codes
	rgb_fn   = true;         -- CSS rgb() and rgba() functions
	hsl_fn   = true;         -- CSS hsl() and hsla() functions
	css      = true;         -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
	css_fn   = true;         -- Enable all CSS *functions*: rgb_fn, hsl_fn
	-- Available modes: foreground, background
	mode     = 'background'; -- Set the display mode.
})
-- }}}
-- =============================================================================
-- {{{ Mappings
-- =============================================================================
helpers.lmap({
    ["tc"] = { mode = "n", rhs = "<Cmd>ColorizerToggle<Cr>", desc = "toggle color highlights" },
})
-- }}}
-- =============================================================================
