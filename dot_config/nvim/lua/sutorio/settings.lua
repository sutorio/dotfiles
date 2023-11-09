-- Leader key is set prior to anything else.
vim.g.mapleader = " "
-- Add filetypes that are not currently being recognised
vim.filetype.add({
  extension = {
    -- Nunjucks templates
    njk = "html",
    -- .aliases and .profiles files
    aliases = "bash",
    profiles = "bash",
  },
  pattern = {
    ["bash"] = "bash",
    ["justfile/i"] = "just",
  },
})
-- I want line numbers and relative line numbers.
vim.opt.nu = true
vim.opt.relativenumber = true
-- Defaults for tabs/spaces. NOTE: I like using Editorconfig, so this all gets overwritten most of the time
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
-- Absolutely not a fan of wrapping.
-- TODO: However, prose is the one place I do want wrapping, so need to edit that.
vim.opt.wrap = false
-- YOLO. Swapfile/backup file stuff always ends up pissing me off more than helping me.
vim.opt.swapfile = false
vim.opt.backup = false
-- I very much want persistent undos, and I want them stored in a central location
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- Don't keep searches highlighted because it's just annoying.
vim.opt.hlsearch = false
-- Do use incremental search because it's class.
vim.opt.incsearch = true
-- I like nice colours.
vim.opt.termguicolors = true
-- At least 8 lines visible at top & bottom of screen unless at start/end.
-- Keeps the cursor in a more sensible position, can see what's above/below.
vim.opt.scrolloff = 8
-- Same for horizontal scrolling (albeit that is much less important)
vim.opt.sidescrolloff = 8
-- Show autocomplete menu on <tab>
vim.opt.wildmenu = true
-- Yes, I absolutely do want some space next to the line numbers for signs
-- an stuff.
vim.opt.signcolumn = "yes"
-- Adds character space to left of screen. leave this in regradless because I
-- like a bit of padding and padding is quite difficult to get with vim so i'll
-- take it where i can
vim.opt.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.modelines = 2
vim.bo.modeline = true
-- REVIEW: copypasta
vim.opt.isfname:append("@-@")
-- Show non-visible characters
vim.opt.list = true
-- Define characters used to represent each of those non-visible characters
vim.opt.listchars =
  "eol:↴,extends:…,nbsp:▴,precedes:…,space:⋅,tab:> ,trail:-"
-- Speeeeeed up.
vim.opt.updatetime = 50
-- Yes, I absolutely want an indicator of my ideal line length
vim.opt.colorcolumn = "80"
-- Hate them characters used to fill statusline/vertical space; just setting blank spaces instead.
vim.opt.fillchars = "vert: ,fold: ,diff: ,stl: ,stlnc: "
