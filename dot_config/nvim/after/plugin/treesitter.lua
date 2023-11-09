require("nvim-treesitter.configs").setup({
  -- This takes a a list of parser names or "all".
  -- Latter is used. but note this makes an inial cold startup (rare) slow,
  -- and makes `:checkhealth` (common) hang while each parser is checked.
  ensure_installed = "all",

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  highlight = {
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = { "org" },
  },
  indent = {
    enable = true,
  },
})

-- Add an additional grammar for Justfiles
require("tree-sitter-just").setup({})

require("treesitter-context").setup({})
