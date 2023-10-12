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
-- Open NetRW file manager. It will do!
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "open netrw"})

-- When you paste *over* other text, Vim replaces the buffer with the replaced text.
-- This is really annoying most of the time! So `<leader>p` will do what is expected (keep original text in-buffer).
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "paste but keep original text in buffer"})

-- Using `<leader>y` instead of `y` will yank to the *system* clipboard. Woohoo!
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "yank to system clipboard"})
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Do dat formatting.
vim.keymap.set("n", "<leader>/", function()
  vim.lsp.buf.format()
end, { desc = "apply formatting to current file" })

-- Move up and down a quickfix list.
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz", { desc = "move up quickfixlist" })
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz", { desc = "move up quickfixlist" })
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz", { desc = "move up loclist" })
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz", { desc = "move down loclist" })

-- Search based on the word under the cursor. Note that this basically seed the search, so can modify the search once the command is ran. Neat!
vim.keymap.set(
  "n",
  "<leader>s",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "start search based on word under cursor" }
)

-- chmod +x the current file.
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { desc = "chmod +x the current file", silent = true })
-- }}}
-- =============================================================================

