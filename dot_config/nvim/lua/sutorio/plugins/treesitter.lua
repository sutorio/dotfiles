return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      local ts_update =
        require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  },
  "nvim-treesitter/nvim-treesitter-context",
  -- NOTE: justfile syntax is not included as an "official" treesiter grammar,
  -- so must be added manually
  "IndianBoy42/tree-sitter-just",
}
