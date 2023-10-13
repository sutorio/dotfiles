local M = {}

-- @class LeaderMappings
--

-- Leader mapping helper. The mappings are of the form
--
-- ["binding"] = { rhs = "mapping", desc = "some description", mode = "mode or modes", opts = "any additional options" }
--
-- Defined as a table.
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
