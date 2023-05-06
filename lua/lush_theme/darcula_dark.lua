local lush = require('lush')
local hsl = lush.hsl

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
  local sym = injected_functions.sym
  local bf, it, un = 'bold', 'italic', 'underline'

  -- Base colors
  local c0 = hsl("#1E1F22").da(9)
  local c1 = c0.lighten(5)
  local c2 = c1.lighten(2)
  local c22 = c2.lighten(8)
  local c3 = c2.lighten(20).sa(10)
  local c4 = c3.lighten(10)
  local c5 = c4.lighten(20)
  local c6 = c5.lighten(70)
  local c7 = c6.lighten(80)

  local bg = c0
  local d1 = bg.da(10)
  local d2 = bg.da(20)
  local d3 = bg.da(30)
  local d4 = bg.da(40)
  local d5 = bg.da(50)

  local overbg = c2
  local subtle = c22


  local fg = hsl("#BCBEC4")
  local mid = c2.lighten(10)
  local faded = fg.darken(45)

  return {
    Normal { bg = bg, fg = fg },                                         -- Normal text
    NormalFloat { bg = overbg, fg = fg },                                -- Normal text in floating windows.
    NormalNC { bg = d1, fg = fg },                                       -- normal text in non-current windows

    Comment { fg = hsl("#7A7E85") },                                     -- Any comment
    Whitespace { fg = hsl("#6F737A") },                                  -- "nbsp", "space", "tab" and "trail" in 'listchars'
    Conceal { fg = hsl(0, 0, 25) },                                      -- Placeholder characters substituted for concealed text (see 'conceallevel')
    NonText { fg = c5 },                                                 -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    SpecialKey { Whitespace },                                           -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|

    ColorColumn { bg = overbg },                                         -- Columns set with 'colorcolumn'
    Cursor { bg = hsl("#373B39"), fg = bg },                             -- Character under the cursor
    TermCursor { Cursor },                                               -- Cursor in a focused terminal
    CursorLine { bg = hsl("#26282E") },                                  -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    CursorColumn { CursorLine },                                         -- Screen-column at the cursor, when 'cursorcolumn' is set.
    MatchParen { bg = hsl("#43454A") },                                  -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|

    LineNr { fg = hsl("#4B5059") },                                      -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    SignColumn { LineNr },                                               -- Column where |signs| are displayed
    CursorLineNr { fg = hsl("#A1A3AB"), bg = hsl("#26282E") },           -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    FoldColumn { LineNr },                                               -- 'foldcolumn'
    Folded { bg = hsl("#2B2D30"), gui = "italic", fg = hsl("#B3AE60") }, -- Line used for closed folds

    Winseparator { bg = bg, fg = subtle },                               -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
    VertSplit { Winseparator },                                          -- Column separating vertically split windows

    Pmenu { bg = hsl("#2b2d3a") },                                       -- Popup menu: Normal item.
    PmenuSel { bg = hsl("#434549") },                                    -- Popup menu: Selected item.
    PmenuSbar { bg = hsl("#3f4043") },                                   -- Popup menu: Scrollbar.
    PmenuThumb { Pmenu },                                                -- Popup menu: Thumb of the scrollbar.
    WildMenu { Pmenu },                                                  -- Current match in 'wildmenu' completion
    QuickFixLine { fg = c7 },                                            -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.

    StatusLine { bg = subtle },                                          -- Status line of current window
    StatusLineNC { fg = faded, bg = overbg },                            -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.

    TabLine { bg = bg, fg = faded },                                     -- Tab pages line, not active tab page label
    TabLineFill { bg = d5 },                                             -- Tab pages line, where there are no labels
    TabLineSel { bg = bg, gui = un },                                    -- Tab pages line, active tab page label

    Search { bg = hsl("#114957") },
    IncSearch { Search },                          -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Substitute { Search },                         -- |:substitute| replacement text highlighting

    Visual { bg = hsl("#214283") },                -- Visual mode selection
    VisualNOS { bg = hsl("#214283").lighten(20) }, -- Visual mode selection when vim is "Not Owning the Selection".

    ModeMsg { fg = faded },                        -- 'showmode' message (e.g., "-- INSERT -- ")
    MsgArea { bg = bg },                           -- Area for messages and cmdline
    MsgSeparator { fg = hsl("#B06100") },          -- Separator for scrolled messages, `msgsep` flag of 'display'
    ErrorMsg { fg = hsl("#F75464") },              -- Error messages on the command line
    WarningMsg { fg = hsl("#E0BB65") },            -- Warning messages (stripe uses #C29E4A)
    Question { fg = hsl("#6AAB73") },              -- |hit-enter| prompt and yes/no questions
    MoreMsg { Question },                          -- |more-prompt|

    -- lCursor      { }, -- Character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- Like Cursor, but used when in IME mode |CursorIM|
    -- TermCursorNC { }, -- Cursor in an unfocused terminal

    Directory { fg = hsl("#467FF2") },                        -- Directory names (and other special names in listings)
    Title { fg = hsl("#B189F5") },                            -- Titles for output from ":set all", ":autocmd" etc.

    DiffAdd { fg = hsl("#294436").lighten(40), bg = bg },     -- Diff mode: Added line |diff.txt|
    DiffChange { fg = hsl("#385570").lighten(30) },           -- Diff mode: Changed line |diff.txt|
    DiffDelete { fg = hsl("#8F5247") },                       -- Diff mode: Deleted line |diff.txt|
    DiffText { DiffChange, gui = un },                        -- Diff mode: Changed text within a changed line |diff.txt|

    SpellBad { guisp = hsl("#7EC482"), gui = "undercurl" },   -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    SpellCap { guisp = hsl("#CF514E"), gui = "undercurl" },   -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    SpellLocal { guisp = hsl("#BA9752"), gui = "undercurl" }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    SpellRare { guisp = hsl("#F49810"), gui = "undercurl" },  -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.

    EndOfBuffer { fg = hsl("#B189F5") },                      -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.

    -- Common vim syntax groups used for all kinds of code and markup.
    -- Commented-out groups should chain up to their preferred (*) group
    -- by default.
    --
    -- See :h group-name
    --
    -- Uncomment and edit if you want more specific syntax highlighting.

    Constant { fg = hsl("#C77DBB") },               -- (*) Any constant
    String { fg = hsl("#6AAB73") },                 --   A string constant: "this is a string"
    Character { fg = hsl("#CF8E6D") },              --   A character constant: 'c', '\n'
    Number { fg = hsl("#2AACB8") },                 --   A number constant: 234, 0xff
    Boolean { Constant, gui = it },                 --   A boolean constant: TRUE, false
    Float { Number },                               --   A floating point constant: 2.3e10

    Identifier { fg = fg },                         -- (*) Any variable name
    Function { fg = hsl("#57AAF7") },               --   Function name (also: methods for classes)

    Statement { fg = hsl("#CF8E6D") },              -- (*) Any statement
    Keyword { Statement },                          --   any other keyword
    Conditional { Keyword },                        --   if, then, else, endif, switch, etc.
    Repeat { Keyword },                             --   for, do, while, etc.
    Label { Keyword },                              --   case, default, etc.
    Operator { fg = fg },                           --   "sizeof", "+", "*", etc.
    Exception { Keyword },                          --   try, catch, throw

    PreProc { fg = hsl("#CF8E6D") },                -- (*) Generic Preprocessor
    Include { PreProc },                            --   Preprocessor #include
    Define { PreProc },                             --   Preprocessor #define
    Macro { PreProc },                              --   Same as Define
    PreCondit { PreProc },                          --   Preprocessor #if, #else, #endif, etc.

    Type { Keyword },                               -- (*) int, long, char, etc.
    StorageClass { Keyword },                       --   static, register, volatile, etc.
    Structure { fg = hsl("#6FAFBD") },              --   struct, union, enum, etc.
    Typedef { Structure },                          --   A typedef

    Special { fg = hsl("#D5B778") },                -- (*) Any special symbol
    SpecialChar { Special },                        --   Special character in a constant
    Tag { fg = hsl("#67A37C"), gui = "underline" }, --   You can use CTRL-] on this
    Delimiter { Special },                          --   Character that needs attention
    SpecialComment { fg = hsl("#67A37C") },         --   Special things inside a comment (e.g. '\n')

    Underlined { gui = un },                        -- Text that stands out, HTML links
    Bold { gui = "bold" },
    Italic { gui = it },
    Ignore { fg = hsl("#6F737A") },         -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
    Error { fg = hsl("#F75464") },          -- Any erroneous construct
    Debug { fg = hsl("#299999") },          --   Debugging statements
    Todo { fg = hsl("#8BB33D"), gui = it }, -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- These groups are for the native LSP client and diagnostic system. Some
    -- other LSP clients may use these groups, or use their own. Consult your
    -- LSP client's documentation.

    -- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
    --
    LspReferenceText { bg = hsl("#373B39") },  -- Used for highlighting "text" references
    LspReferenceRead { bg = hsl("#373B39") },  -- Used for highlighting "read" references
    LspReferenceWrite { bg = hsl("#402F33") }, -- Used for highlighting "write" references
    -- LspCodeLens                 { } , -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
    -- LspCodeLensSeparator        { } , -- Used to color the seperator between two or more code lens.
    -- LspSignatureActiveParameter { } , -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

    -- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
    --
    DiagnosticError { fg = hsl("#F75464") }, -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticWarn { fg = hsl("#E0BB65") },  -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticInfo { fg = hsl("#56A8F5") },  -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    DiagnosticHint { fg = hsl("#299999") },  -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
    -- DiagnosticVirtualTextError { } , -- Used for "Error" diagnostic virtual text.
    -- DiagnosticVirtualTextWarn  { } , -- Used for "Warn" diagnostic virtual text.
    -- DiagnosticVirtualTextInfo  { } , -- Used for "Info" diagnostic virtual text.
    -- DiagnosticVirtualTextHint  { } , -- Used for "Hint" diagnostic virtual text.
    DiagnosticUnderlineError { DiagnosticError, gui = un }, -- Used to underline "Error" diagnostics.
    DiagnosticUnderlineWarn { DiagnosticWarn, gui = un },   -- Used to underline "Warn" diagnostics.
    DiagnosticUnderlineInfo { DiagnosticInfo, gui = un },   -- Used to underline "Info" diagnostics.
    DiagnosticUnderlineHint { DiagnosticHint, gui = un },   -- Used to underline "Hint" diagnostics.
    -- DiagnosticFloatingError    { } , -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
    -- DiagnosticFloatingWarn     { } , -- Used to color "Warn" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingInfo     { } , -- Used to color "Info" diagnostic messages in diagnostics float.
    -- DiagnosticFloatingHint     { } , -- Used to color "Hint" diagnostic messages in diagnostics float.
    -- DiagnosticSignError        { } , -- Used for "Error" signs in sign column.
    -- DiagnosticSignWarn         { } , -- Used for "Warn" signs in sign column.
    -- DiagnosticSignInfo         { } , -- Used for "Info" signs in sign column.
    -- DiagnosticSignHint         { } , -- Used for "Hint" signs in sign column.

    -- Tree-Sitter syntax groups.
    --
    -- See :h treesitter-highlight-groups, some groups may not be listed,
    -- submit a PR fix to lush-template!
    --
    -- Tree-Sitter groups are defined with an "@" symbol, which must be
    -- specially handled to be valid lua code, we do this via the special
    -- sym function. The following are all valid ways to call the sym function,
    -- for more details see https://www.lua.org/pil/5.html
    --
    -- sym("@text.literal")
    -- sym('@text.literal')
    -- sym"@text.literal"
    -- sym'@text.literal'
    --
    -- For more information see https://github.com/rktjmp/lush.nvim/issues/109

    sym "@constant" { Constant },                     -- Constant
    sym "@constant.builtin" { Constant, gui = it },   -- Special
    sym "@constant.macro" { Constant, gui = "bold" }, -- Define

    sym "@number" { Number },                         -- Number
    sym "@boolean" { Boolean },                       -- Boolean
    sym "@float" { Float },                           -- Float
    sym "@character" { Character },                   -- Character
    sym "@string" { String },                         -- String
    sym "@string.escape" { Character },               -- SpecialChar
    sym "@string.regex" { fg = hsl("#42C3D4") },
    sym "@character.special" { SpecialChar },         -- SpecialChar
    sym "@string.special" { SpecialChar },            -- SpecialChar
    sym "@symbol" { fg = hsl("#E8BF6A") },
    sym "@field" { fg = hsl("#C77DBB") },             -- Identifier
    sym "@property" { fg = hsl("#C77DBB") },          -- Identifier
    sym "@parameter" { Identifier },                  -- Identifier
    sym "@parameter.reference" { LspReferenceText },  -- Identifier
    sym "@variable" { Identifier },                   -- Identifier
    sym "@variable.builtin" { Constant },             -- Identifier
    sym "@function" { Function },                     -- Function
    sym "@function.builtin" { fg = hsl("#4EADE5") },  -- Special
    sym "@function.macro" { Function },               -- Macro
    sym "@method" { Function },                       -- Function
    sym "@constructor" { Function },                  -- Special

    sym "@keyword" { Keyword },                       -- Keyword
    sym "@keyword.function" { Keyword },              -- Keyword
    sym "@conditional" { Conditional },               -- Conditional
    sym "@repeat" { Repeat },                         -- Repeat
    sym "@label" { Label },                           -- Label
    sym "@operator" { Operator },                     -- Operator
    sym "@exception" { Exception },                   -- Exception
    sym "@storageclass" { Keyword },                  -- StorageClass

    sym "@namespace" { PreProc },                     -- Identifier
    sym "@annotation" { fg = hsl("#B3AE60") },
    sym "@include" { PreProc },                       -- Include
    sym "@preproc" { PreProc },                       -- PreProc
    sym "@attribute" { PreProc },                     -- PreProc
    sym "@define" { PreProc },                        -- Define
    sym "@macro" { PreProc },                         -- Macro

    sym "@type" { Structure },
    sym "@type.builtin" { fg = hsl("#CC7832") },
    sym "@type.definition" { Typedef },         -- Typedef
    sym "@structure" { Structure },             -- Structure

    sym "@punctuation" { Identifier },          -- Delimiter
    sym "@punctuation.delimiter" { Delimiter }, -- delimiters ie: `.`
    sym "@punctuation.bracket" { fg = fg },     -- brackets and parens.
    sym "@punctuation.special" { Delimiter },   -- special punctutation that does not fall in the catagories before.

    sym "@comment" { Comment },                 -- Comment
    sym "@tag" { Tag },                         -- Tag
    sym "@tag.delimiter" { Special },           -- Tag

    sym "@text" { fg = fg },
    sym "@text.literal" { String },                       -- Comment
    sym "@text.emphasis" { fg = fg, gui = "bold" },       -- Comment
    sym "@text.strong" { fg = fg, gui = "bold" },         -- Comment
    sym "@text.title" { Title },                          -- Title
    sym "@text.uri" { fg = hsl("#548AF7"), gui = un },    -- Underlined
    sym "@text.underline" { fg = fg, gui = un },          -- Underlined
    sym "@text.strike" { Comment, gui = un },             -- Underlined
    sym "@text.todo" { Todo },                            -- Todo

    sym "@text.reference" { bg = hsl("#5F826B").da(60) }, -- Identifier
    sym "@debug" { Debug },                               -- Debug
    sym "@error" { Error },

    IndentBlanklineChar { fg = hsl('#313438') },
    IndentBlanklineContextChar { fg = hsl('#313438') },
    MiniIndentscopeSymbol { fg = hsl('#313438').lighten(20) },
    TodoBgTODO { Todo, gui = it },
    TodoFgTODO { Todo, gui = it },

    -- Docker File specific highlight
    sym "@lsp.type.property.dockerfile" { Constant, gui = "italic" },
    sym "@lsp.type.parameter.dockerfile" {},
    sym "@lsp.type.variable.dockerfile" { Constant, gui = "italic" },

    -- go specific highlight
    sym "@constant.builtin.go" { Constant },
    sym "@namespace.go" { fg = hsl("#AFBF7E") },
    sym "@lsp.type.namespace.go" { fg = hsl("#AFBF7E") },
    sym "@type.go" { Structure },
    sym "@lsp.type.type.go" { Structure },
    sym "@method.call.go" { fg = hsl("#B09D79") },
    sym "@lsp.type.function.go" { fg = hsl("#B09D79") },
    sym "@lsp.typemod.function.definition.go" { Function },
    sym "@lsp.typemod.parameter.definition.go" { fg = fg.lighten(50) },
    sym "@lsp.type.parameter.go" { fg = fg.lighten(50) },
    sym "@lsp.typemod.variable.readonly.go" { Constant, gui = "italic" },
    sym "@lsp.mod.readonly.go" { Constant, gui = it },
    sym "@lsp.mod.defaultLibrary.go" { fg = hsl("#CC7832") },
    --sym"@lsp.typemod.variable.defaultLibrary.go" { fg=hsl("#CC7832") },
    sym "@string.regex.go" { bg = hsl("#2d3c3f") },
    sym "@lsp.typemod.type.definition.go" { Identifier },
    --sm"@type.definition.go" { Identifier },
    --   sym"@field.go" { Identifier },

    NeoTreeNormal { bg = hsl("#2b2d30") },
    NeoTreeNormalNC { NeoTreeNormal },
    NeoTreeCursorLine { bg = hsl("#32436b") },
    NeoTreeDirectoryName { fg = fg },
  }
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
