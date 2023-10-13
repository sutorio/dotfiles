-- vim:fileencoding=utf-8:foldmethod=marker
-- =============================================================================
-- Key mappings and remappings that *dont* depend on a specific plugin.
-- =============================================================================
-- {{{ Adjustments to existing builtin mappings
-- =============================================================================
-- Adjust the behaviour of `J` in normal mode: instead of moving the cursor to the join position, keep it where it is.
vim.keymap.set("n", "J", "mzJ`z")

-- Adjust behaviour of Ctrl-d/u (page up/down): keep cursor in same place on screen.
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Adjust behaviour of search: keep focus (and cursor) in centre of screen when paging through results.
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
-- }}}
-- =============================================================================
-- {{{ Non-leader mappings
-- =============================================================================
-- In visual mode, `J` will move the highlighted area *up*, `K` will move it *down*
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
-- }}}
-- =============================================================================
-- {{{ Leader mappings
-- =============================================================================
require("sutorio.helpers").lmap({
    -- -------------------------------------------------------------------------
    -- Text-editing-related tasks
    -- -------------------------------------------------------------------------
    -- When you paste *over* other text, Vim replaces the buffer with the replaced text.
    -- This is really annoying most of the time! So `<leader>p` will do what is expected (keep original text in-buffer).
    ["ep"]  = { mode = "x", rhs = [["_dP]], desc = "paste but keep original text in buffer"},
    ["ef"]  = { mode = "n", rhs = vim.lsp.buf.format, desc = "format current file" },
    -- Search based on the word under the cursor. Note that this seeds the search, can modify the search once the command is ran.
    ["es"]  = { mode = "n", rhs = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], desc = "start search based on word under cursor" },
    ["ey"]  = { mode = { "n", "v" }, rhs = [["+y]], desc = "yank to system clipboard" },
    ["eY"]  = { mode = "n", rhs = [["+Y]], desc = "yank line to system clipboard" },
    -- -------------------------------------------------------------------------
    -- Neovim-specific/inbuilt system-related tasks
    -- -------------------------------------------------------------------------
    ["n/"] = { mode = "n", rhs = vim.cmd.Ex, desc = "open netrw" },
    ["ns"] = { mode = "n", rhs = "<Cmd>so<Cr>", desc = "source current file" },
    ["nx"] = { mode = "n", rhs = "<cmd>!chmod +x %<CR>", desc = "chmod +x the current file", opts = { silent = true }},
})


-- Move up and down a quickfix list.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "move up quickfixlist" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "move up quickfixlist" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "move up loclist" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "move down loclist" })
-- }}}
-- =============================================================================

