--- Helper functions
-- @module helpers

local M = {}

--- Leader mapping.
-- Accepts a table mapping the binding to a table of the command (rhs),
-- description, modes/s it applies to + any additional options. The table
-- is of the form:
--
-- {
--   ["binding"] = {
--     rhs = "mapping (string/function)",
--     desc = "some description (string)",
--     mode = "mode or modes (string/list of strings)",
--     opts = "any additional options (table, optional)"
--  }
-- }
--
-- All bindings will then be set using the nvim `keymap.set` function.
--
-- @param leader_mappings
-- @return void
M.lmap = function(leader_mappings)
  for lhs, config in pairs(leader_mappings) do
    -- All of these map to the <Leader>, so prefix every lhs
    local lmap = "<Leader>" .. lhs
    -- `desc` is part of the `opts` table passed to `keymap.set`
    local options = { noremap = true, desc = config.desc }

    if config.opts then
      options = vim.tbl_extend("force", options, config.opts)
    end

    vim.keymap.set(config.mode, lmap, config.rhs, options)
  end
end

return M
