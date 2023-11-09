-- vim:fileencoding=utf-8:foldmethod=marker
-- =============================================================================
-- nvim-orgmode setup and config. This is an org-mode clone written specifically
-- for Neovim.
--
-- See https://github.com/nvim-orgmode/orgmode
-- =============================================================================
-- {{{ Aliases
-- =============================================================================
local org = require("orgmode")
local tsconf = 
-- }}}
-- =============================================================================
-- {{{ Setup
-- =============================================================================
org.setup_ts_grammar()

-- NOTE: this assumes treesitter has already been configured to include org 
-- files under the `additional_vim_regex_highlighting` section.
-- The setup is included here for reference:
--
--    require("nvim-treesitter.configs").setup({
--      highlight = {
--        enable = true,
--        additional_vim_regex_highlighting = { "org" },
--      },
--      ensure_installed = "org",
--    })

-- NOTE: this assumes that for completions, `orgmode` has been added to sources.
-- The setup is included here for reference:
--
--    require("cmp").setup({ sources = { name = 'orgmode' }})

org.setup({
    org_agenda_files = {"~/Dropbox/Orgfiles/*"},
    org_default_notes_file = {"~/Dropbox/Orgfiles/refile.org"},
})

-- }}}
-- =============================================================================
