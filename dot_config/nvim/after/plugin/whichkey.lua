    -- TODO: base mappings
    require("which-key").setup({})
    -- NOTE: using native keymaps. However, doing that prevents naming the
    -- keymap groups: which-key just prints `+prefix`.
    -- Therefore, names *only* are specified in the register.
    require("which-key").register({
        f = { name = "Find stuff" },
        l = {
            name = "LSP-related",
            c = { name = "LSP code actions" },
            g = { name = "LSP goto" },
            w = { name = "LSP workspace" },
        },
        n = { name = "NVim-related" },
        t = { name = "Toggle" },
    }, { prefix = "<Leader>" })
