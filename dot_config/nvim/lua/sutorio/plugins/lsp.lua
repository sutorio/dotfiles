return {
  -- Mason is a manager for LSP servers/formatters/linters,
  -- has a nice UI for [un]installing, updating, etc.
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  -- lspconfig bindings & utils for nvim
  { "neovim/nvim-lspconfig" },
  -- Completions plugin
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-cmdline" },
  { "hrsh7th/nvim-cmp" },
  -- Snippets plugin. Note that this only makes snippets work, it doesn't
  -- actually provide any snippets itself.
  { "L3MON4D3/LuaSnip" },
  -- JSON (primarily) schema support: this is going to provide autocomplete
  -- support for a huge variety of config files.
  { "b0o/schemastore.nvim" },
  -- Snippet collection, in this case used by Luasnip.
  { "rafamadriz/friendly-snippets" },
  -- Formatter plugin. This is used primarily because it defaults to LSP
  -- if no override is provided, makes it much easier to configure.
  { "stevearc/conform.nvim" },
  -- Copilot support. Note that the server does take time to start up,
  -- so it's important to lazy load it (in this case, on explicit command).
  { "zbirenbaum/copilot.lua", cmd = "Copilot", event = "InsertEnter" },
}
