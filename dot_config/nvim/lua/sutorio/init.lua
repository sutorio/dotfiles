-- General settings (NOT plugin-specific, put those in the relevant file in `<root>/after/`)
require("sutorio.settings")
-- General remaps (NOT plugin-specific, put those in the relevant file in `<root>/after/`)
require("sutorio.remaps")
-- Init logic for the lazy.nvim plugin manager.
-- IMPORTANT: Plugins have their own config files in the ./plugins/ directory.
-- IMPORTANT: Nvim will hang on a cold start; this is expected as Lazy will be bootstrapping; subsequent starts will be quick.
-- See: https://github.com/folke/lazy.nvim
require("sutorio.lazy")
