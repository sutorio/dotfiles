-- vim:foldmethod=marker
-- =============================================================================
-- Telescope settings
--
-- For reference, see https://github.com/nvim-telescope/telescope.nvim
-- =============================================================================
-- {{{ Aliases
-- =============================================================================
local telescope = require("telescope")
local builtin = require("telescope.builtin")
local helpers = require("sutorio.helpers")
-- }}}
-- =============================================================================
-- {{{ Setup & extension loading
-- =============================================================================
telescope.setup({
    pickers = {
        find_files = {
            -- FIXME: I need a way to find files that are not hidden. Problem is that
            --        if I set this to true, then telescope will index everything including
            --        including gitignored stuff. Which is slooooow.
            --        But I don't see how I can have another keybinding that triggers find files,
            --        the exact same thing but with this set to true: it seems to be one or t'other.
            -- hidden = false,
        },
    },
    extensions = {
        file_browser = {
            hidden = true,
            grouped = true,
            mappings = {
                -- TODO: Need to note down what's annoying in current mappings and adjust accordingly here!
            },
        },
        projects = {
            display_type = "full",
        },
    },
})

telescope.load_extension("noice")
telescope.load_extension("project")
telescope.load_extension("file_browser")
-- }}}
-- =============================================================================
-- {{{ Keymaps
-- =============================================================================
helpers.lmap({
    ["fb"] = { mode = "n", rhs = builtin.buffers, desc = "open buffers" },
    ["fd"] = { mode = "n", rhs = builtin.diagnostics, desc = "diagnostics" },
    ["ff"] = { mode = "n", rhs = builtin.find_files, desc = "files in cdr" },
    ["fh"] = { mode = "n", rhs = builtin.help_tags, desc = "help tags" },
    ["fn"] = { mode = "n", rhs = function() require("noice").cmd("history") end, desc = "notification messages" },
    ["fp"] = { mode = "n", rhs = telescope.extensions.project.project, desc = "project picker" },
    ["fx"] = { mode = "n", rhs = telescope.extensions.file_browser.file_browser, desc = "file browser" },
})
-- }}}
