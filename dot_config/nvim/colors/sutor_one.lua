-- vim:foldmethod=marker
-- =============================================================================
-- Vim Colour File
-- Name:       sutor_one.lua
-- Maintainer: https://github.com/DanCouper
-- License:    The MIT License (MIT)
-- Based On:   https://github.com/olivercederborg/poimandres.nvim
--             https://github.com/kyazdani42/nvim-palenight.lua/blob/master/lua/palenight.lua
-- =============================================================================
-- {{{ Colour palette + utils
-- =============================================================================
-- Convert an entry in the big lua table of hgroups to something vim commandish
local function highlight(group, styles)
  local gui = styles.gui and "gui=" .. styles.gui or "gui=NONE"
  local sp = styles.sp and "guisp=" .. styles.sp or "guisp=NONE"
  local fg = styles.fg and "guifg=" .. styles.fg or "guifg=NONE"
  local bg = styles.bg and "guibg=" .. styles.bg or "guibg=NONE"
  vim.cmd(
    "highlight " .. group .. " " .. gui .. " " .. sp .. " " .. fg .. " " .. bg
  )
end

-- Palette. aliased to "p", going to use it a lot.
local p = {
  yellow = "#FFFAC2",
  teal1 = "#5DE4C7",
  teal2 = "#5FB3A1",
  teal3 = "#42675A",
  blue1 = "#89DDFF",
  blue2 = "#ADD7FF",
  blue3 = "#91B4D5",
  blue4 = "#7390AA",
  pink1 = "#FAE4FC",
  pink2 = "#FCC5E9",
  pink3 = "#D0679D",
  purple1 = "#dad4f7",
  purple2 = "#B5A9EF",
  purple3 = "#8C7AE6",
  blueGray1 = "#A6ACCD",
  blueGray2 = "#767C9D",
  blueGray3 = "#506477",
  background1 = "#303340",
  background2 = "#1B1E28",
  background3 = "#171922",
  text = "#E4F0FB",
  white = "#FFFFFF",
  none = "NONE",
}

-- Semantic naming for palette colours.
local groups = {
  primary = p.teal3,

  background = p.background2,
  panel = p.background3,
  border = p.background3,
  comment = p.blueGray2,
  link = p.blue3,
  punctuation = p.blueGray2,

  error = p.pink3,
  hint = p.blue1,
  info = p.blue3,
  warn = p.yellow,
}
-- }}}
-- =============================================================================
-- Editor Highlight Groups {{{
-- =============================================================================
-- stylua: ignore start
local editor_syntax = {
    ColorColumn          = { bg = p.background1 },
    -- Cursor         = {},
    CursorLine           = { bg = p.background1 },
    CursorLineNr         = { fg = p.text },
    DarkenedPanel        = { bg = groups.panel },
    DarkenedStatusline   = { bg = groups.panel },
    Directory            = { fg = p.blue3, bg = p.none },
    -- DiffAdd        = {},
    -- DiffChange     = {},
    -- DiffDelete     = {},
    -- DiffText       = {},
    -- EndOfBuffer    = {},
    ErrorMsg             = { fg = p.pink3, gui = "bold" },
    Folded               = { fg = p.text, bg = p.none, gui = "italic" },
    FoldColumn           = { fg = p.blueGray3 },
    IncSearch            = { fg = groups.background, bg = p.blue2 },
    LineNr               = { fg = p.blueGray3 },
    MatchParen           = { bg = p.blueGray3, fg = p.background3 },
    Normal               = { fg = p.text, bg = groups.background },
    NormalFloat          = { fg = p.text, bg = groups.panel },
    NormalNC             = { fg = p.text, bg = groups.panel },
    Pmenu                = { fg = p.blueGray1, bg = groups.panel },
    PmenuSbar            = { bg = p.blueGray2 },
    PmenuSel             = { fg = p.text, bg = p.background1 },
    PmenuThumb           = { bg = p.blueGray3 },
    -- RedrawDebugNormal    = {}
    RedrawDebugClear     = { fg = "#ffffff", bg = p.yellow },
    RedrawDebugComposed  = { fg = "#ffffff", bg = p.teal2 },
    RedrawDebugRecompose = { fg = "#ffffff", bg = p.pink3 },
    Search               = { fg = p.white, bg = p.blueGray3 },
    SignColumn           = { fg = p.text, bg = p.none },
    SpecialKey           = { fg = p.teal1 },
    SpellBad             = { gui = "underline", sp = p.pink3 },
    SpellCap             = { gui = "underline", sp = p.blue1 },
    SpellLocal           = { gui = "underline", sp = p.yellow },
    SpellRare            = { gui = "underline", sp = p.blue1 },
    -- Substitute           = {},
    TabLine              = { fg = p.blue3, bg = groups.panel },
    TabLineFill          = { bg = groups.panel },
    TabLineSel           = { fg = p.text, bg = p.background1, gui = 'bold' },
    Title                = { fg = p.text },
    VertSplit            = { fg = groups.border, bg = groups.border },
    Visual               = { fg = groups.background, bg = p.blue2 },
    VisualNOS            = { fg = p.text, bg = groups.border },
    WarningMsg           = { fg = p.yellow },
    Whitespace           = { fg = p.blueGray3 },

    Conceal              = {},
    ModeMsg              = { fg = p.blue3 },
    MsgArea              = {},
    MsgSeparator         = {},
    MoreMsg              = { fg = p.blue3 },
    NonText              = { fg = p.blueGray3 },
    Question             = { fg = p.yellow },
    QuickFixLine         = {},
    StatusLine           = { fg = p.blue3, bg = groups.panel },
    StatusLineNC         = { fg = p.blue3, bg = groups.background },
    StatusLineTerm       = { fg = p.blue3, bg = groups.panel },
    StatusLineTermNC     = { fg = p.blue3, bg = groups.background },
    WildMenu             = { fg = p.background3, bg = p.blue2 },
}

for group, styles in pairs(editor_syntax) do
    highlight(group, styles)
end
-- stylua: ignore end
-- }}}
-- =============================================================================
-- Default Vim Syntax Highlight Groups {{{
-- =============================================================================
-- These groups are not listed as default vim groups,
-- but they are defacto standard group names for syntax highlighting.
-- commented out groups should chain up to their "preferred" group by
-- default,

-- stylua: ignore start
local default_code_syntax = {
    Constant       = { fg = p.text },           -- (preferred) any constant
    String         = { fg = p.teal1 },          --   a string constant: "this is a string"
    Character      = { fg = p.pink3 },          --  a character constant: 'c', '\n'
    Number         = { fg = p.teal1 },          --   a number constant: 234, 0xff
    Boolean        = { fg = p.teal1 },          --  a boolean constant: TRUE, false
    Float          = { fg = p.teal1 },          --    a floating point constant: 2.3e10

    Identifier     = { fg = p.blueGray1 },      -- (preferred) any variable name
    Function       = { fg = p.teal1 },          -- function name (also: methods for classes)

    Statement      = { fg = p.text },           -- (preferred) any statement
    Conditional    = { fg = p.blue3 },          --  if, then, else, endif, switch, etc.
    Repeat         = { fg = p.blue3 },          --   for, do, while, etc.
    Label          = { fg = p.text },           --    case, default, etc.
    Operator       = { fg = p.blue2 },          -- "sizeof", "+", "*", etc.
    Keyword        = { fg = p.blue2 },          --  any other keyword
    Exception      = { fg = p.blue3 },          --  try, catch, throw

    PreProc        = { fg = p.text },           -- (preferred) generic Preprocessor
    -- Include               = { }, --  preprocessor #include
    -- Define                = { }, --   preprocessor #define
    -- Macro                 = { }, --    same as Define
    -- PreCondit             = { }, --  preprocessor #if, #else, #endif, etc.

    Type           = { fg = p.blueGray1 },      -- (preferred) int, long, char, etc.
    Structure      = { fg = p.blueGray1 },      --  struct, union, enum, etc. ]]
    -- StorageClass          = { }, -- static, register, volatile, etc.
    -- Typedef               = { fg = p.blueGray1 }, --  A typedef

    Special        = { fg = p.blueGray2 },       -- (preferred) any special symbol
    -- SpecialChar            = { }, --  special character in a constant
    Tag            = { fg = p.text },            --    you can use CTRL-] on this
    Delimiter      = { fg = p.blueGray1 },       --  character that needs attention
    SpecialComment = { fg = p.blueGray1 },       -- special things inside a comment
    -- Debug                 = { }, --    debugging statements

    Comment        = { fg = p.blue3, gui = "italic" },       -- (preferred) any special symbol

    Underlined     = { gui = "underline" },                  -- (preferred) text that stands out, HTML links
    Bold           = { gui = "bold" },
    Italic         = { gui = "italic" },

    -- Ignore = { }, -- (preferred) left blank, hidden  |hl-Ignore|
    Error          = { fg = p.pink3 },                            -- (preferred) any erroneous construct
    Todo           = { bg = p.yellow, fg = p.background3 },       -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX
}

for group, styles in pairs(default_code_syntax) do
    highlight(group, styles)
end
-- stylua: ignore end
-- }}}
-- =============================================================================
-- Diagnostic Highlight Groups {{{
-- =============================================================================
local diagnostic_groups = {
  DiagnosticError = { fg = groups.error },
  DiagnosticHint = { fg = groups.hint },
  DiagnosticInfo = { fg = groups.info },
  DiagnosticWarn = { fg = groups.warn },
  DiagnosticDefaultError = { fg = groups.error },
  DiagnosticDefaultHint = { fg = groups.hint },
  DiagnosticDefaultInfo = { fg = groups.info },
  DiagnosticDefaultWarn = { fg = groups.warn },
  DiagnosticFloatingError = { fg = groups.error },
  DiagnosticFloatingHint = { fg = groups.hint },
  DiagnosticFloatingInfo = { fg = groups.info },
  DiagnosticFloatingWarn = { fg = groups.warn },
  DiagnosticSignError = { fg = groups.error },
  DiagnosticSignHint = { fg = groups.hint },
  DiagnosticSignInfo = { fg = groups.info },
  DiagnosticSignWarn = { fg = groups.warn },
  DiagnosticStatusLineError = { fg = groups.error, bg = groups.panel },
  DiagnosticStatusLineHint = { fg = groups.hint, bg = groups.panel },
  DiagnosticStatusLineInfo = { fg = groups.info, bg = groups.panel },
  DiagnosticStatusLineWarn = { fg = groups.warn, bg = groups.panel },
  DiagnosticUnderlineError = { sp = groups.error, gui = "undercurl" },
  DiagnosticUnderlineHint = { sp = groups.hint, gui = "undercurl" },
  DiagnosticUnderlineInfo = { sp = groups.info, gui = "undercurl" },
  DiagnosticUnderlineWarn = { sp = groups.warn, gui = "undercurl" },
  DiagnosticVirtualTextError = { fg = groups.error },
  DiagnosticVirtualTextHint = { fg = groups.hint },
  DiagnosticVirtualTextInfo = { fg = groups.info },
  DiagnosticVirtualTextWarn = { fg = groups.warn },
}

for group, styles in pairs(diagnostic_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- Treesitter Syntax Highlight Groups {{{
-- =============================================================================
local treesitter_groups = {
  -- ["@annotation"] = {},
  -- ["@attribute"] = {},
  ["@boolean"] = default_code_syntax.Boolean,
  -- ["@character"] = { link = 'Character' },
  -- ["@character.special"] = { link = 'Character' },
  ["@comment"] = default_code_syntax.Comment,
  ["@conditional"] = default_code_syntax.Conditional,
  -- ["@constant"] = { fg = p.text },
  ["@constant.builtin"] = { fg = p.blue2 },
  -- ["@constant.macro"] = {},
  ["@constructor"] = { fg = p.teal1 },
  -- ["@debug"] = {},
  -- ["@define"] = {},
  -- ["@emphasis"] = {},
  -- ["@error"] = {},
  -- ["@exception"] = {},
  ["@field"] = { fg = p.text },
  -- ["@float"] = {},
  ["@function"] = default_code_syntax.Function,
  ["@function.builtin"] = { fg = p.blue2 },
  -- ["@function.macro"] = {},
  ["@include"] = { fg = p.blue2 },
  ["@keyword"] = { fg = p.blue2 },
  ["@keyword.function"] = { fg = p.blue2 },
  ["@keyword.operator"] = { fg = p.teal1 },
  -- ["@keyword.return"] = { fg = p.teal2 },
  ["@label"] = { fg = p.blue3 },
  -- ["@literal"] = {},
  ["@method"] = { fg = p.teal1 },
  -- ["@method.call"] = { fg = p.teal1 },
  -- ["@namespace"] = {},
  -- ["@none"] = {},
  ["@number"] = default_code_syntax.Number,
  ["@operator"] = default_code_syntax.Operator,
  ["@parameter"] = { fg = p.text },
  -- ["@parameter.reference"] = {},
  -- ["@preproc"] = {},
  ["@property"] = { fg = p.text },
  ["@punctuation.bracket"] = { fg = groups.punctuation },
  ["@punctuation.delimiter"] = { fg = groups.punctuation },
  ["@punctuation.special"] = { fg = groups.punctuation },
  -- ["@repeat"] = {},
  -- ["@storageclass"] = {},
  -- ["@strike"] = {},
  ["@string"] = default_code_syntax.String,
  ["@string.escape"] = { fg = p.pink3 },
  -- ["@string.regex"] = {},
  -- ["@string.special"] = { fg = p.teal1 },
  -- ["@symbol"] = {},
  ["@tag"] = { fg = p.text },
  ["@tag.attribute"] = { fg = p.blue2, gui = "italic" },
  ["@tag.delimiter"] = { fg = p.text },
  ["@text"] = { fg = p.text },
  -- ["@text.strong"] = {}
  -- ["@text.emphasis"] = {}
  -- ["@text.underline"] = {}
  -- ["@text.strike"] = {}
  -- ["@text.title"] = {}
  -- ["@text.literal"] = {}
  ["@text.uri"] = { fg = groups.link },
  -- ["@text.math"] = {}
  -- ["@text.reference"] = {}
  -- ["@text.environment"] = {}
  -- ["@text.environment.name"] = {}
  -- ["@text.note"] = {}
  -- ["@text.warning"] = {}
  -- ["@text.danger"] = {}
  ["@title"] = { fg = p.text, gui = "bold" },
  -- ["@todo"] = {}
  ["@type"] = default_code_syntax.Type,
  ["@type.builtin"] = default_code_syntax.Type,
  ["@type.qualifier"] = default_code_syntax.Type,
  ["@type.definition"] = default_code_syntax.Type,
  ["@variable"] = { fg = p.text },
  ["@variable.builtin"] = { fg = p.blue2 },
}

for group, styles in pairs(treesitter_groups) do
  highlight(group, styles)
end
-- stylua: ignore end
-- }}}
-- =============================================================================
-- Treesitter Language-specific Syntax Highlight Groups {{{
-- =============================================================================
local treesitter_language_groups = {
  -- Make Elixir stuff Elixir-coloured!
  ["@float.elixir"] = { fg = p.purple3 },
  ["@function.elixir"] = { fg = p.purple2 },
  ["@function.call.elixir"] = { fg = p.purple2 },
  ["@keyword.operator.elixir"] = { fg = p.purple3 },
  ["@string.elixir"] = { fg = p.purple1 },
  -- This is a hack, should write a custom query, but for embedded code:
  ["@text.literal.elixir"] = { fg = p.purple3, gui = p.none },
}

for group, styles in pairs(treesitter_language_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- LSP-specific Highlight Groups {{{
-- =============================================================================
local lsp_groups = {
  LspReferenceText = { fg = p.background2, bg = p.blue2 },
  LspReferenceRead = { fg = p.background2, bg = p.blue2 },
  LspReferenceWrite = { fg = p.background2, bg = p.blue2 },
}

for group, styles in pairs(lsp_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- Gitsigns Highlight goups {{{
-- =============================================================================
local gitsigns_groups = {
  GitSignsAdd = { fg = p.teal3, bg = p.none, gui = "bold" },
  -- GitSignsAddLn ={},
  GitSignsAddNr = { fg = p.teal3, gui = "bold" },
  GitSignsChange = { fg = p.blue3, bg = p.none, gui = "bold" },
  -- GitSignsChangeLn = {},
  GitSignsChangeNr = { fg = p.blue3, gui = "bold" },
  GitSignsDelete = { fg = p.pink3, bg = p.none, gui = "bold" },
  -- GitSignsDeleteLn = {},
  GitSignsDeleteNr = { fg = p.pink3, gui = "bold" },
}
for group, styles in pairs(gitsigns_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- Noice UI Highlight Groups {{{
-- =============================================================================
-- see: https://github.com/folke/noice.nvim#-highlight-groups
local noice_groups = {
  -- NoiceCmdline = {}, -- (Normal for the classic cmdline area at the bottom"; defaults to NoiceCmdline)
  -- NoiceCmdlineIcon = {}, -- (Cmdline icon; defaults to NoiceCmdlineIcon)
  -- NoiceCmdlineIconCmdline = {}, -- (defaults to NoiceCmdlineIconCmdline)
  -- NoiceCmdlineIconFilter = {}, -- (defaults to NoiceCmdlineIconFilter)
  -- NoiceCmdlineIconHelp = {}, -- (defaults to NoiceCmdlineIconHelp)
  -- NoiceCmdlineIconIncRename = {}, -- (defaults to NoiceCmdlineIconIncRename)
  -- NoiceCmdlineIconInput = {}, -- (defaults to NoiceCmdlineIconInput)
  -- NoiceCmdlineIconLua = {}, -- (defaults to NoiceCmdlineIconLua)
  -- NoiceCmdlineIconSearch = {}, -- (Cmdline search icon (/ and ?); defaults to NoiceCmdlineIconSearch)
  -- NoiceCmdlinePopup = {}, -- (Normal for the cmdline popup; defaults to NoiceCmdlinePopup)
  -- NoiceCmdlinePopupBorder = {}, -- (Cmdline popup border; defaults to NoiceCmdlinePopupBorder)
  -- NoiceCmdlinePopupBorderCmdline = {}, -- (defaults to NoiceCmdlinePopupBorderCmdline)
  -- NoiceCmdlinePopupBorderFilter = {}, -- (defaults to NoiceCmdlinePopupBorderFilter)
  -- NoiceCmdlinePopupBorderHelp = {}, -- (defaults to NoiceCmdlinePopupBorderHelp)
  -- NoiceCmdlinePopupBorderIncRename = {}, -- (defaults to NoiceCmdlinePopupBorderIncRename)
  -- NoiceCmdlinePopupBorderInput = {}, -- (defaults to NoiceCmdlinePopupBorderInput)
  -- NoiceCmdlinePopupBorderLua = {}, -- (defaults to NoiceCmdlinePopupBorderLua)
  -- NoiceCmdlinePopupBorderSearch = {}, -- (Cmdline popup border for search; defaults to NoiceCmdlinePopupBorderSearch)
  -- NoiceCmdlinePrompt = {}, -- (prompt for input(); defaults to NoiceCmdlinePrompt)
  -- NoiceCompletionItemKindClass = {}, -- (defaults to NoiceCompletionItemKindClass)
  -- NoiceCompletionItemKindColor = {}, -- (defaults to NoiceCompletionItemKindColor)
  -- NoiceCompletionItemKindConstant = {}, -- (defaults to NoiceCompletionItemKindConstant)
  -- NoiceCompletionItemKindConstructor = {}, -- (defaults to NoiceCompletionItemKindConstructor)
  -- NoiceCompletionItemKindDefault = {}, -- (defaults to NoiceCompletionItemKindDefault)
  -- NoiceCompletionItemKindEnum = {}, -- (defaults to NoiceCompletionItemKindEnum)
  -- NoiceCompletionItemKindEnumMember = {}, -- (defaults to NoiceCompletionItemKindEnumMember)
  -- NoiceCompletionItemKindField = {}, -- (defaults to NoiceCompletionItemKindField)
  -- NoiceCompletionItemKindFile = {}, -- (defaults to NoiceCompletionItemKindFile)
  -- NoiceCompletionItemKindFolder = {}, -- (defaults to NoiceCompletionItemKindFolder)
  -- NoiceCompletionItemKindFunction = {}, -- (defaults to NoiceCompletionItemKindFunction)
  -- NoiceCompletionItemKindInterface = {}, -- (defaults to NoiceCompletionItemKindInterface)
  -- NoiceCompletionItemKindKeyword = {}, -- (defaults to NoiceCompletionItemKindKeyword)
  -- NoiceCompletionItemKindMethod = {}, -- (defaults to NoiceCompletionItemKindMethod)
  -- NoiceCompletionItemKindModule = {}, -- (defaults to NoiceCompletionItemKindModule)
  -- NoiceCompletionItemKindProperty = {}, -- (defaults to NoiceCompletionItemKindProperty)
  -- NoiceCompletionItemKindSnippet = {}, -- (defaults to NoiceCompletionItemKindSnippet)
  -- NoiceCompletionItemKindStruct = {}, -- (defaults to NoiceCompletionItemKindStruct)
  -- NoiceCompletionItemKindText = {}, -- (defaults to NoiceCompletionItemKindText)
  -- NoiceCompletionItemKindUnit = {}, -- (defaults to NoiceCompletionItemKindUnit)
  -- NoiceCompletionItemKindValue = {}, -- (defaults to NoiceCompletionItemKindValue)
  -- NoiceCompletionItemKindVariable = {}, -- (defaults to NoiceCompletionItemKindVariable)
  -- NoiceCompletionItemMenu = {}, -- (Normal for the popupmenu; defaults to NoiceCompletionItemMenu)
  -- NoiceCompletionItemWord = {}, -- (Normal for the popupmenu; defaults to NoiceCompletionItemWord)
  -- NoiceConfirm = {}, -- (Normal for the confirm view; defaults to NoiceConfirm)
  -- NoiceConfirmBorder = {}, -- (Border for the confirm view; defaults to NoiceConfirmBorder)
  -- NoiceCursor = {}, -- (Fake Cursor; defaults to NoiceCursor)
  -- NoiceFormatConfirm = {}, -- (defaults to NoiceFormatConfirm)
  -- NoiceFormatConfirmDefault = {}, -- (defaults to NoiceFormatConfirmDefault)
  -- NoiceFormatDate = {}, -- (defaults to NoiceFormatDate)
  -- NoiceFormatEvent = {}, -- (defaults to NoiceFormatEvent)
  -- NoiceFormatKind = {}, -- (defaults to NoiceFormatKind)
  -- NoiceFormatLevelDebug = {}, -- (defaults to NoiceFormatLevelDebug)
  -- NoiceFormatLevelError = {}, -- (defaults to NoiceFormatLevelError)
  -- NoiceFormatLevelInfo = {}, -- (defaults to NoiceFormatLevelInfo)
  -- NoiceFormatLevelOff = {}, -- (defaults to NoiceFormatLevelOff)
  -- NoiceFormatLevelTrace = {}, -- (defaults to NoiceFormatLevelTrace)
  -- NoiceFormatLevelWarn = {}, -- (defaults to NoiceFormatLevelWarn)
  -- NoiceFormatProgressDone = {}, -- (Progress bar done; defaults to NoiceFormatProgressDone)
  -- NoiceFormatProgressTodo = {}, -- (progress bar todo; defaults to NoiceFormatProgressTodo)
  -- NoiceFormatTitle = {}, -- (defaults to NoiceFormatTitle)
  -- NoiceLspProgressClient = {}, -- (Lsp progress client name; defaults to NoiceLspProgressClient)
  -- NoiceLspProgressSpinner = {}, -- (Lsp progress spinner; defaults to NoiceLspProgressSpinner)
  -- NoiceLspProgressTitle = {}, -- (Lsp progress title; defaults to NoiceLspProgressTitle)
  -- NoiceMini = {}, -- (Normal for mini view; defaults to NoiceMini)
  -- NoicePopup = {}, -- (Normal for popup views; defaults to NoicePopup)
  -- NoicePopupBorder = {}, -- (Border for popup views; defaults to NoicePopupBorder)
  -- NoicePopupmenu = {}, -- (Normal for the popupmenu; defaults to NoicePopupmenu)
  -- NoicePopupmenuBorder = {}, -- (Popupmenu border; defaults to NoicePopupmenuBorder)
  -- NoicePopupmenuMatch = {}, -- (Part of the item that matches the input; defaults to NoicePopupmenuMatch)
  -- NoicePopupmenuSelected = {}, -- (Selected item in the popupmenu; defaults to NoicePopupmenuSelected)
  -- NoiceScrollbar = {}, -- (Normal for scrollbar; defaults to NoiceScrollbar)
  -- NoiceScrollbarThumb = {}, -- (Scrollbar thumb; defaults to NoiceScrollbarThumb)
  -- NoiceSplit = {}, -- (Normal for split views; defaults to NoiceSplit)
  -- NoiceSplitBorder = {}, -- (Border for split views; defaults to NoiceSplitBorder)
  -- NoiceVirtualText = {}, -- (Default hl group for virtualtext views}; defaults to NoiceVirtualText)
}

for group, styles in pairs(noice_groups) do
  highlight(group, styles)
end
-- stylua: ignore end
-- }}}
-- =============================================================================
-- Which-key Highlight Groups {{{
-- =============================================================================
local which_key_groups = {
  -- WhichKey = { fg = p.text },
  -- WhichKeyGroup = { fg = p.text },
  -- WhichKeySeparator = { fg = p.text },
  -- WhichKeyDesc = { fg = p.text },
  -- WhichKeyFloat = { bg = groups.panel },
  -- WhichKeyValue = { fg = p.text },
}

for group, styles in pairs(which_key_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- Telescope Highlight Groups {{{
-- =============================================================================
local telescope_groups = {
  TelescopeBorder = { fg = p.blue1 },
  TelescopeMatching = { fg = p.teal1 },
  TelescopeNormal = { fg = p.text },
  TelescopePromptNormal = { fg = p.text },
  TelescopePromptPrefix = { fg = p.blueGray1 },
  TelescopeSelection = { fg = p.text, bg = p.blueGray1 },
  TelescopeSelectionCaret = { fg = p.pink2, bg = p.blueGray1 },
  TelescopeTitle = { fg = p.blueGray2 },
}

for group, styles in pairs(telescope_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- Mini.nvim Highlight Groups {{{
-- =============================================================================
-- see
local mini_groups = {
  MiniStatuslineModeNormal = { bg = p.blue2, fg = p.background3 },
  MiniStatuslineModeInsert = { bg = p.teal1, fg = p.background3 },
  MiniStatuslineModeVisual = { bg = p.purple1, fg = p.background3 },
  MiniStatuslineModeReplace = { bg = p.pink2, fg = p.background3 },
  MiniStatuslineModeCommand = { bg = p.pink3, fg = p.background3 },
  MiniStatuslineModeOther = { bg = p.yellow, fg = p.background3 },
}

for group, styles in pairs(mini_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
-- Notify.nvim (used bvy Noice for notification messages) Highlight Groups {{{
-- =============================================================================
-- see
local notify_groups = {
  NotifyBackground = { bg = groups.panel },
  -- NotifyERRORBorder = { fg = "#8A1F1F" },
  -- NotifyWARNBorder = { fg = "#79491D" },
  -- NotifyINFOBorder = { fg = "#4F6752" },
  -- NotifyDEBUGBorder = { fg = "#8B8B8B" },
  -- NotifyTRACEBorder = { fg = "#4F3552" },
  -- NotifyERRORIcon = { fg = "#F70067" },
  -- NotifyWARNIcon = { fg = "#F79000" },
  -- NotifyINFOIcon = { fg = "#A9FF68" },
  -- NotifyDEBUGIcon = { fg = "#8B8B8B" },
  -- NotifyTRACEIcon = { fg = "#D484FF" },
  -- NotifyERRORTitle = { fg = "#F70067" },
  -- NotifyWARNTitle = { fg = "#F79000" },
  -- NotifyINFOTitle = { fg = "#A9FF68" },
  -- NotifyDEBUGTitle = { fg = "#8B8B8B" },
  -- NotifyTRACETitle = { fg = "#D484FF" },
  -- NotifyERRORBody = { bg = groups.background },
  -- NotifyWARNBody = { bg = groups.background },
  -- NotifyINFOBody = { bg = groups.background },
  -- NotifyDEBUGBody = { bg = groups.background },
  -- NotifyTRACEBody = { bg = groups.background },
}

for group, styles in pairs(notify_groups) do
  highlight(group, styles)
end
-- }}}
-- =============================================================================
