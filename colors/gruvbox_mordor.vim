" Original
" -----------------------------------------------------------------------------
" File: gruvbox.vim
" Description: Retro groove color scheme for Vim
" Author: morhetz <morhetz@gmail.com>
" Source: https://github.com/morhetz/gruvbox
" Last Modified: 12 Aug 2017
" -----------------------------------------------------------------------------
"
" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='gruvbox_mordor'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:gruvbox_bold')
  let g:gruvbox_bold=1
endif
if !exists('g:gruvbox_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:gruvbox_italic=1
  else
    let g:gruvbox_italic=0
  endif
endif
if !exists('g:gruvbox_undercurl')
  let g:gruvbox_undercurl=1
endif
if !exists('g:gruvbox_underline')
  let g:gruvbox_underline=1
endif
if !exists('g:gruvbox_inverse')
  let g:gruvbox_inverse=1
endif

if !exists('g:gruvbox_guisp_fallback') || index(['fg', 'bg'], g:gruvbox_guisp_fallback) == -1
  let g:gruvbox_guisp_fallback='NONE'
endif

if !exists('g:gruvbox_improved_strings')
  let g:gruvbox_improved_strings=0
endif

if !exists('g:gruvbox_improved_warnings')
  let g:gruvbox_improved_warnings=0
endif

if !exists('g:gruvbox_termcolors')
  let g:gruvbox_termcolors=256
endif

if !exists('g:gruvbox_invert_indent_guides')
  let g:gruvbox_invert_indent_guides=0
endif

if exists('g:gruvbox_contrast')
  echo 'g:gruvbox_contrast is deprecated; use g:gruvbox_contrast_light and g:gruvbox_contrast_dark instead'
endif

if !exists('g:gruvbox_contrast_dark')
  let g:gruvbox_contrast_dark='medium'
endif

if !exists('g:gruvbox_contrast_light')
  let g:gruvbox_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#001219', 234]     " 29-32-33
let s:gb.dark0       = ['#001219', 234]     " 40-40-40
let s:gb.dark0_soft  = ['#021821', 235]     " 50-48-47
let s:gb.dark1       = ['#062735', 237]     " 60-56-54
let s:gb.dark2       = ['#0C3040', 239]     " 80-73-69
let s:gb.dark3       = ['#04374D', 241]     " 102-92-84
let s:gb.dark4       = ['#0B3F55', 243]     " 124-111-100
let s:gb.dark4_256   = ['#11445A', 243]     " 124-111-100
let s:gb.dark5       = ['#0b090a', 243]     " 124-111-100
let s:gb.darkf       = ['#293241', 234]     " 29-32-33

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

" let s:ha.bright_red     = ['#fb4934', 167]     " 251-73-52
" let s:ha.bright_red    = ['#FF3838', 196]     " 204-36-29
let s:gb.bright_red    = ['#f96e46', 196]     " 204-36-29
let s:gb.bright_green   = ['#1BBC9B', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#FFDC00', 214]     " 250-189-47
let s:gb.bright_gray    = ['#BFBFBF', 109]     " 131-165-152
let s:gb.bright_orange_light  = ['#FA9600', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#607D8B', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:gruvbox_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:gruvbox_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:gruvbox_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:gruvbox_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:gruvbox_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:gruvbox_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:gruvbox_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4
  let s:bg5  = s:gb.dark5
  let s:bgf  = s:gb.darkf

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:gray_light   = s:gb.bright_gray
  let s:orange_light = s:gb.bright_orange_light
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:gruvbox_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:gruvbox_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:gray_light   = s:gb.faded_blue
  let s:orange_light = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:gruvbox_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:gray_light[1]   = 12
  let s:orange_light[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4
let s:gb.bg5 = s:bg5
let s:gb.bgf = s:bgf

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.gray_light   = s:gray_light
let s:gb.orange_light = s:orange_light
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:gray_light[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:orange_light[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:gruvbox_hls_cursor')
  let s:hls_cursor = get(s:gb, g:gruvbox_hls_cursor)
endif

let s:number_column = s:none
if exists('g:gruvbox_number_column')
  let s:number_column = get(s:gb, g:gruvbox_number_column)
endif

let s:sign_column = s:bg0

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:gruvbox_sign_column')
    let s:sign_column = get(s:gb, g:gruvbox_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:gruvbox_color_column')
  let s:color_column = get(s:gb, g:gruvbox_color_column)
endif

let s:vert_split = s:bg0
if exists('g:gruvbox_vert_split')
  let s:vert_split = get(s:gb, g:gruvbox_vert_split)
endif

let s:invert_signs = ''
if exists('g:gruvbox_invert_signs')
  if g:gruvbox_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:gruvbox_invert_selection')
  if g:gruvbox_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:gruvbox_invert_tabline')
  if g:gruvbox_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:gruvbox_italicize_comments')
  if g:gruvbox_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:gruvbox_italicize_strings')
  if g:gruvbox_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Gruvbox Hi Groups: {{{

" memoize common hi groups
call s:HL('GruvboxFg0', s:fg0)
call s:HL('GruvboxFg1', s:fg1)
call s:HL('GruvboxFg2', s:fg2)
call s:HL('GruvboxFg3', s:fg3)
call s:HL('GruvboxFg4', s:fg4)
call s:HL('GruvboxGray', s:gray)
call s:HL('GruvboxBg0', s:bg0)
call s:HL('GruvboxBg1', s:bg1)
call s:HL('GruvboxBg2', s:bg2)
call s:HL('GruvboxBg3', s:bg3)
call s:HL('GruvboxBg4', s:bg4)
call s:HL('GruvboxBg5', s:bg5)

call s:HL('GruvboxRed', s:red)
call s:HL('GruvboxRedBold', s:red, s:none, s:bold)
call s:HL('GruvboxGreen', s:green)
call s:HL('GruvboxGreenBold', s:green, s:none, s:bold)
call s:HL('GruvboxYellow', s:yellow)
call s:HL('GruvboxYellowBold', s:yellow, s:none, s:bold)
call s:HL('GruvboxGrayLight', s:gray_light)
call s:HL('GruvboxGrayLightBold', s:gray_light, s:none, s:bold)
call s:HL('GruvboxOrangeLight', s:orange_light)
call s:HL('GruvboxOrangeLightBold', s:orange_light, s:none, s:bold)
call s:HL('GruvboxAqua', s:aqua)
call s:HL('GruvboxAquaBold', s:aqua, s:none, s:bold)
call s:HL('GruvboxOrange', s:orange)
call s:HL('GruvboxOrangeBold', s:orange, s:none, s:bold)

call s:HL('GruvboxRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('GruvboxGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('GruvboxYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('GruvboxGrayLightSign', s:gray_light, s:sign_column, s:invert_signs)
call s:HL('GruvboxOrangeLightSign', s:orange_light, s:sign_column, s:invert_signs)
call s:HL('GruvboxAquaSign', s:aqua, s:sign_column, s:invert_signs)
call s:HL('GruvboxOrangeSign', s:orange, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:gray_light, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/gruvbox/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:bg1)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:gray_light, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg0)
endif

hi! link NonText GruvboxBg2
hi! link SpecialKey GruvboxBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:gray_light, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:gray_light, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory GruvboxGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title GruvboxGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg GruvboxYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg GruvboxYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question GruvboxOrangeBold
" Warning messages
hi! link WarningMsg GruvboxRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:bg0)

" Column where signs are displayed
call s:HL('SignColumn', s:bg0, s:none)

" Line used for closed folds
call s:HL('Folded', s:gray_light, s:bgf, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg0)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:gruvbox_improved_strings == 0
  hi! link Special GruvboxOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement GruvboxRed
" if, then, else, endif, swicth, etc.
hi! link Conditional GruvboxRed
" for, do, while, etc.
hi! link Repeat GruvboxRed
" case, default, etc.
hi! link Label GruvboxRed
" try, catch, throw
hi! link Exception GruvboxRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword GruvboxRed

" Variable name
hi! link Identifier GruvboxGrayLight
" Function name
hi! link Function GruvboxAqua

" Generic preprocessor
hi! link PreProc GruvboxAqua
" Preprocessor #include
hi! link Include GruvboxAqua
" Preprocessor #define
hi! link Define GruvboxAqua
" Same as Define
hi! link Macro GruvboxAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit GruvboxAqua

" Generic constant
hi! link Constant GruvboxOrangeLight
" Character constant: 'c', '/n'
hi! link Character GruvboxOrangeLight
" String constant: "this is a string"
if g:gruvbox_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean GruvboxOrangeLight
" Number constant: 234, 0xff
hi! link Number GruvboxOrangeLight
" Floating point constant: 2.3e10
hi! link Float GruvboxOrangeLight

" Generic type
hi! link Type GruvboxYellow
" static, register, volatile, etc
hi! link StorageClass GruvboxOrange
" struct, union, enum, etc.
hi! link Structure GruvboxAqua
" typedef
hi! link Typedef GruvboxYellow

" }}}
" Completion Menu: {{{
if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg5)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg1, s:gray_light, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif
" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:gray_light)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:gruvbox_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:gray_light)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:orange_light)
endif

" }}}
" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

hi! link Sneak Search
hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:gruvbox_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['gray_light', '#BFBFBF'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'gray_light' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd GruvboxGreenSign
hi! link GitGutterChange GruvboxAquaSign
hi! link GitGutterDelete GruvboxRedSign
hi! link GitGutterChangeDelete GruvboxAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile GruvboxGreen
hi! link gitcommitDiscardedFile GruvboxRed

" }}}
" Signify: {{{

hi! link SignifySignAdd GruvboxGreenSign
hi! link SignifySignChange GruvboxAquaSign
hi! link SignifySignDelete GruvboxRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign GruvboxRedSign
hi! link SyntasticWarningSign GruvboxYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   GruvboxGrayLightSign
hi! link SignatureMarkerText GruvboxOrangeLightSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl GruvboxGrayLightSign
hi! link ShowMarksHLu GruvboxGrayLightSign
hi! link ShowMarksHLo GruvboxGrayLightSign
hi! link ShowMarksHLm GruvboxGrayLightSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch GruvboxYellow
hi! link CtrlPNoEntries GruvboxRed
hi! link CtrlPPrtBase GruvboxBg2
hi! link CtrlPPrtCursor GruvboxGrayLight
hi! link CtrlPLinePre GruvboxBg2

call s:HL('CtrlPMode1', s:gray_light, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:gray_light, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket GruvboxFg3
hi! link StartifyFile GruvboxFg1
hi! link StartifyNumber GruvboxGrayLight
hi! link StartifyPath GruvboxGray
hi! link StartifySlash GruvboxGray
hi! link StartifySection GruvboxYellow
hi! link StartifySpecial GruvboxBg2
hi! link StartifyHeader GruvboxOrange
hi! link StartifyFooter GruvboxBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:gray_light[0], s:orange_light[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:gray_light[0], s:orange_light[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:gray_light)

hi! link ALEErrorSign GruvboxRedSign
hi! link ALEWarningSign GruvboxYellowSign
hi! link ALEInfoSign GruvboxGrayLightSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail GruvboxAqua
hi! link DirvishArg GruvboxYellow

" }}}
" Netrw: {{{

hi! link netrwDir GruvboxAqua
hi! link netrwClassify GruvboxAqua
hi! link netrwLink GruvboxGray
hi! link netrwSymLink GruvboxFg1
hi! link netrwExe GruvboxYellow
hi! link netrwComment GruvboxGray
hi! link netrwList GruvboxGrayLight
hi! link netrwHelpCmd GruvboxAqua
hi! link netrwCmdSep GruvboxFg3
hi! link netrwVersion GruvboxGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir GruvboxAqua
hi! link NERDTreeDirSlash GruvboxRed

hi! link NERDTreeOpenable GruvboxOrange
hi! link NERDTreeClosable GruvboxOrange

hi! link NERDTreeFile GruvboxFg1
hi! link NERDTreeExecFile GruvboxYellow

hi! link NERDTreeUp GruvboxGray
hi! link NERDTreeCWD GruvboxGreen
hi! link NERDTreeHelp GruvboxFg1

hi! link NERDTreeToggleOn GruvboxGreen
hi! link NERDTreeToggleOff GruvboxRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}
" coc.nvim: {{{

hi! link CocErrorSign GruvboxRedSign
hi! link CocWarningSign GruvboxOrangeSign
hi! link CocInfoSign GruvboxYellowSign
hi! link CocHintSign GruvboxGrayLightSign
hi! link CocErrorFloat GruvboxRed
hi! link CocWarningFloat GruvboxOrange
hi! link CocInfoFloat GruvboxYellow
hi! link CocHintFloat GruvboxGrayLight
hi! link CocDiagnosticsError GruvboxRed
hi! link CocDiagnosticsWarning GruvboxOrange
hi! link CocDiagnosticsInfo GruvboxYellow
hi! link CocDiagnosticsHint GruvboxGrayLight

hi! link CocSelectedText GruvboxRed
hi! link CocCodeLens GruvboxGray

call s:HL('CocErrorHighlight', s:none, s:none, s:undercurl, s:red)
call s:HL('CocWarningHighlight', s:none, s:none, s:undercurl, s:orange)
call s:HL('CocInfoHighlight', s:none, s:none, s:undercurl, s:yellow)
call s:HL('CocHintHighlight', s:none, s:none, s:undercurl, s:gray_light)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded GruvboxGreen
hi! link diffRemoved GruvboxRed
hi! link diffChanged GruvboxAqua

hi! link diffFile GruvboxOrange
hi! link diffNewFile GruvboxYellow

hi! link diffLine GruvboxGrayLight

" }}}
" Html: {{{

hi! link htmlTag GruvboxGrayLight
hi! link htmlEndTag GruvboxGrayLight

hi! link htmlTagName GruvboxAquaBold
hi! link htmlArg GruvboxAqua

hi! link htmlScriptTag GruvboxOrangeLight
hi! link htmlTagN GruvboxFg1
hi! link htmlSpecialTagName GruvboxAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar GruvboxOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag GruvboxGrayLight
hi! link xmlEndTag GruvboxGrayLight
hi! link xmlTagName GruvboxGrayLight
hi! link xmlEqual GruvboxGrayLight
hi! link docbkKeyword GruvboxAquaBold

hi! link xmlDocTypeDecl GruvboxGray
hi! link xmlDocTypeKeyword GruvboxOrangeLight
hi! link xmlCdataStart GruvboxGray
hi! link xmlCdataCdata GruvboxOrangeLight
hi! link dtdFunction GruvboxGray
hi! link dtdTagName GruvboxOrangeLight

hi! link xmlAttrib GruvboxAqua
hi! link xmlProcessingDelim GruvboxGray
hi! link dtdParamEntityPunct GruvboxGray
hi! link dtdParamEntityDPunct GruvboxGray
hi! link xmlAttribPunct GruvboxGray

hi! link xmlEntity GruvboxOrange
hi! link xmlEntityPunct GruvboxOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation GruvboxOrange
hi! link vimBracket GruvboxOrange
hi! link vimMapModKey GruvboxOrange
hi! link vimFuncSID GruvboxFg3
hi! link vimSetSep GruvboxFg3
hi! link vimSep GruvboxFg3
hi! link vimContinue GruvboxFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword GruvboxGrayLight
hi! link clojureCond GruvboxOrange
hi! link clojureSpecial GruvboxOrange
hi! link clojureDefine GruvboxOrange

hi! link clojureFunc GruvboxYellow
hi! link clojureRepeat GruvboxYellow
hi! link clojureCharacter GruvboxAqua
hi! link clojureStringEscape GruvboxAqua
hi! link clojureException GruvboxRed

hi! link clojureRegexp GruvboxAqua
hi! link clojureRegexpEscape GruvboxAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen GruvboxFg3
hi! link clojureAnonArg GruvboxYellow
hi! link clojureVariable GruvboxGrayLight
hi! link clojureMacro GruvboxOrange

hi! link clojureMeta GruvboxYellow
hi! link clojureDeref GruvboxYellow
hi! link clojureQuote GruvboxYellow
hi! link clojureUnquote GruvboxYellow

" }}}
" C: {{{

hi! link cOperator GruvboxOrangeLight
hi! link cStructure GruvboxOrange

" }}}
" Python: {{{

hi! link pythonBuiltin GruvboxOrange
hi! link pythonBuiltinObj GruvboxOrange
hi! link pythonBuiltinFunc GruvboxOrange
hi! link pythonFunction GruvboxOrangeLight
hi! link pythonDecorator GruvboxRed
hi! link pythonInclude GruvboxGrayLight
hi! link pythonClass GruvboxYellow
hi! link pythonClassVar GruvboxYellow
hi! link pythonStatement GruvboxRed
hi! link pythonImport GruvboxRed
hi! link pythonRun GruvboxGrayLight
hi! link pythonCoding GruvboxGrayLight
hi! link pythonOperator GruvboxRed
hi! link pythonException GruvboxRed
hi! link pythonExceptions GruvboxOrangeLight
hi! link pythonBoolean GruvboxFg1
hi! link pythonComment GruvboxFg4
hi! link pythonString GruvboxGreenBold
hi! link pythonDot GruvboxFg3
hi! link pythonConditional GruvboxRed
hi! link pythonRepeat GruvboxRed
hi! link pythonDottedName GruvboxAquaBold

" }}}
" CSS: {{{

hi! link cssBraces GruvboxGrayLight
hi! link cssFunctionName GruvboxYellow
hi! link cssIdentifier GruvboxOrange
hi! link cssClassName GruvboxGreen
hi! link cssColor GruvboxGrayLight
hi! link cssSelectorOp GruvboxGrayLight
hi! link cssSelectorOp2 GruvboxGrayLight
hi! link cssImportant GruvboxGreen
hi! link cssVendor GruvboxFg1

hi! link cssTextProp GruvboxAqua
hi! link cssAnimationProp GruvboxAqua
hi! link cssUIProp GruvboxYellow
hi! link cssTransformProp GruvboxAqua
hi! link cssTransitionProp GruvboxAqua
hi! link cssPrintProp GruvboxAqua
hi! link cssPositioningProp GruvboxYellow
hi! link cssBoxProp GruvboxAqua
hi! link cssFontDescriptorProp GruvboxAqua
hi! link cssFlexibleBoxProp GruvboxAqua
hi! link cssBorderOutlineProp GruvboxAqua
hi! link cssBackgroundProp GruvboxAqua
hi! link cssMarginProp GruvboxAqua
hi! link cssListProp GruvboxAqua
hi! link cssTableProp GruvboxAqua
hi! link cssFontProp GruvboxAqua
hi! link cssPaddingProp GruvboxAqua
hi! link cssDimensionProp GruvboxAqua
hi! link cssRenderProp GruvboxAqua
hi! link cssColorProp GruvboxAqua
hi! link cssGeneratedContentProp GruvboxAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces GruvboxFg1
hi! link javaScriptFunction GruvboxOrangeLight
hi! link javaScriptIdentifier GruvboxRed
hi! link javaScriptMember GruvboxGrayLight
hi! link javaScriptNumber GruvboxOrangeLight
hi! link javaScriptNull GruvboxOrangeLight
hi! link javaScriptParens GruvboxFg3

" }}}
" YAJS: {{{

hi! link javascriptImport GruvboxRed
hi! link javascriptFrom GruvboxRed
hi! link javascriptExport GruvboxRed
hi! link javascriptClassKeyword GruvboxAqua
hi! link javascriptClassExtends GruvboxAqua
hi! link javascriptDefault GruvboxRed

hi! link javascriptClassName GruvboxYellow
hi! link javascriptClassSuperName GruvboxYellow
hi! link javascriptGlobal GruvboxYellow

hi! link javascriptEndColons GruvboxFg1
hi! link javascriptFuncArg GruvboxFg1
hi! link javascriptGlobalMethod GruvboxFg1
hi! link javascriptNodeGlobal GruvboxFg1
hi! link javascriptBOMWindowProp GruvboxFg1
hi! link javascriptArrayMethod GruvboxFg1
hi! link javascriptArrayStaticMethod GruvboxFg1
hi! link javascriptCacheMethod GruvboxFg1
hi! link javascriptDateMethod GruvboxFg1
hi! link javascriptMathStaticMethod GruvboxFg1

" hi! link javascriptProp GruvboxFg1
hi! link javascriptURLUtilsProp GruvboxFg1
hi! link javascriptBOMNavigatorProp GruvboxFg1
hi! link javascriptDOMDocMethod GruvboxFg1
hi! link javascriptDOMDocProp GruvboxFg1
hi! link javascriptBOMLocationMethod GruvboxFg1
hi! link javascriptBOMWindowMethod GruvboxFg1
hi! link javascriptStringMethod GruvboxFg1

hi! link javascriptVariable GruvboxOrange
" hi! link javascriptVariable GruvboxRed
" hi! link javascriptIdentifier GruvboxOrange
" hi! link javascriptClassSuper GruvboxOrange
hi! link javascriptIdentifier GruvboxOrange
hi! link javascriptClassSuper GruvboxOrange

" hi! link javascriptFuncKeyword GruvboxOrange
" hi! link javascriptAsyncFunc GruvboxOrange
hi! link javascriptFuncKeyword GruvboxAqua
hi! link javascriptAsyncFunc GruvboxAqua
hi! link javascriptClassStatic GruvboxOrange

hi! link javascriptOperator GruvboxRed
hi! link javascriptForOperator GruvboxRed
hi! link javascriptYield GruvboxRed
hi! link javascriptExceptions GruvboxRed
hi! link javascriptMessage GruvboxRed

hi! link javascriptTemplateSB GruvboxAqua
hi! link javascriptTemplateSubstitution GruvboxFg1

" hi! link javascriptLabel GruvboxGrayLight
" hi! link javascriptObjectLabel GruvboxGrayLight
" hi! link javascriptPropertyName GruvboxGrayLight
hi! link javascriptLabel GruvboxFg1
hi! link javascriptObjectLabel GruvboxFg1
hi! link javascriptPropertyName GruvboxFg1

hi! link javascriptLogicSymbols GruvboxFg1
hi! link javascriptArrowFunc GruvboxYellow

hi! link javascriptDocParamName GruvboxFg4
hi! link javascriptDocTags GruvboxFg4
hi! link javascriptDocNotation GruvboxFg4
hi! link javascriptDocParamType GruvboxFg4
hi! link javascriptDocNamedParamType GruvboxFg4

hi! link javascriptBrackets GruvboxFg1
hi! link javascriptDOMElemAttrs GruvboxFg1
hi! link javascriptDOMEventMethod GruvboxFg1
hi! link javascriptDOMNodeMethod GruvboxFg1
hi! link javascriptDOMStorageMethod GruvboxFg1
hi! link javascriptHeadersMethod GruvboxFg1

hi! link javascriptAsyncFuncKeyword GruvboxRed
hi! link javascriptAwaitFuncKeyword GruvboxRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword GruvboxAqua
hi! link jsExtendsKeyword GruvboxAqua
hi! link jsExtendsKeyword GruvboxAqua
hi! link jsExportDefault GruvboxRed
hi! link jsExport GruvboxRed
hi! link jsImport GruvboxRed
hi! link jsFrom GruvboxRed
hi! link jsTemplateBraces GruvboxAqua
hi! link jsGlobalNodeObjects GruvboxFg1
hi! link jsGlobalObjects GruvboxRed
hi! link jsObjectKey GruvboxFg0
hi! link jsObject GruvboxFg2
hi! link jsBlock GruvboxFg2
hi! link jsBrackets GruvboxFg5
hi! link jsOperator GruvboxOrange
hi! link jsFunction GruvboxOrangeLight
hi! link jsString GruvboxAqua
hi! link jsComponent GruvboxFg2
hi! link jsFuncCall GruvboxOrange
hi! link jsArrowFunction GruvboxYellow
hi! link jsFuncParens GruvboxFg3
hi! link jsFuncArgs GruvboxYellow
hi! link jsFuncArgExpression GruvboxYellow
hi! link jsParens GruvboxFg3
hi! link jsNull GruvboxGrayLight
hi! link jsUndefined GruvboxGrayLight
hi! link jsClassDefinition GruvboxYellow
hi! link jsFuncName GruvboxYellowBold

" }}}
" TypeScript: {{{

hi! link typeScriptReserved GruvboxAqua
hi! link typeScriptLabel GruvboxAqua
hi! link typeScriptFuncKeyword GruvboxAqua
hi! link typeScriptIdentifier GruvboxOrange
hi! link typeScriptBraces GruvboxFg1
hi! link typeScriptEndColons GruvboxFg1
hi! link typeScriptDOMObjects GruvboxFg1
hi! link typeScriptAjaxMethods GruvboxFg1
hi! link typeScriptLogicSymbols GruvboxFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects GruvboxFg1
hi! link typeScriptParens GruvboxFg3
hi! link typeScriptOpSymbols GruvboxFg3
hi! link typeScriptHtmlElemProperties GruvboxFg1
hi! link typeScriptNull GruvboxOrangeLight
hi! link typeScriptInterpolationDelimiter GruvboxAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword GruvboxAqua
hi! link purescriptModuleName GruvboxFg1
hi! link purescriptWhere GruvboxAqua
hi! link purescriptDelimiter GruvboxFg4
hi! link purescriptType GruvboxFg1
hi! link purescriptImportKeyword GruvboxAqua
hi! link purescriptHidingKeyword GruvboxAqua
hi! link purescriptAsKeyword GruvboxAqua
hi! link purescriptStructure GruvboxAqua
hi! link purescriptOperator GruvboxGrayLight

hi! link purescriptTypeVar GruvboxFg1
hi! link purescriptConstructor GruvboxFg1
hi! link purescriptFunction GruvboxFg1
hi! link purescriptConditional GruvboxOrange
hi! link purescriptBacktick GruvboxOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp GruvboxFg3
hi! link coffeeSpecialOp GruvboxFg3
hi! link coffeeCurly GruvboxOrange
hi! link coffeeParen GruvboxFg3
hi! link coffeeBracket GruvboxOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter GruvboxGreen
hi! link rubyInterpolationDelimiter GruvboxAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier GruvboxRed
hi! link objcDirective GruvboxGrayLight

" }}}
" Go: {{{

hi! link goDirective GruvboxAqua
hi! link goConstants GruvboxOrangeLight
hi! link goDeclaration GruvboxRed
hi! link goDeclType GruvboxGrayLight
hi! link goBuiltins GruvboxOrange

" }}}
" Lua: {{{

hi! link luaIn GruvboxRed
hi! link luaFunction GruvboxAqua
hi! link luaTable GruvboxOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp GruvboxFg3
hi! link moonExtendedOp GruvboxFg3
hi! link moonFunction GruvboxFg3
hi! link moonObject GruvboxYellow

" }}}
" Java: {{{

hi! link javaAnnotation GruvboxGrayLight
hi! link javaDocTags GruvboxAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen GruvboxFg3
hi! link javaParen1 GruvboxFg3
hi! link javaParen2 GruvboxFg3
hi! link javaParen3 GruvboxFg3
hi! link javaParen4 GruvboxFg3
hi! link javaParen5 GruvboxFg3
hi! link javaOperator GruvboxOrange

hi! link javaVarArg GruvboxGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter GruvboxGreen
hi! link elixirInterpolationDelimiter GruvboxAqua

hi! link elixirModuleDeclaration GruvboxYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition GruvboxFg1
hi! link scalaCaseFollowing GruvboxFg1
hi! link scalaCapitalWord GruvboxFg1
hi! link scalaTypeExtension GruvboxFg1

hi! link scalaKeyword GruvboxRed
hi! link scalaKeywordModifier GruvboxRed

hi! link scalaSpecial GruvboxAqua
hi! link scalaOperator GruvboxFg1

hi! link scalaTypeDeclaration GruvboxYellow
hi! link scalaTypeTypePostDeclaration GruvboxYellow

hi! link scalaInstanceDeclaration GruvboxFg1
hi! link scalaInterpolation GruvboxAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 GruvboxGreenBold
hi! link markdownH2 GruvboxGreenBold
hi! link markdownH3 GruvboxYellowBold
hi! link markdownH4 GruvboxYellowBold
hi! link markdownH5 GruvboxYellow
hi! link markdownH6 GruvboxYellow

hi! link markdownCode GruvboxAqua
hi! link markdownCodeBlock GruvboxAqua
hi! link markdownCodeDelimiter GruvboxAqua

hi! link markdownBlockquote GruvboxGray
hi! link markdownListMarker GruvboxGray
hi! link markdownOrderedListMarker GruvboxGray
hi! link markdownRule GruvboxGray
hi! link markdownHeadingRule GruvboxGray

hi! link markdownUrlDelimiter GruvboxFg3
hi! link markdownLinkDelimiter GruvboxFg3
hi! link markdownLinkTextDelimiter GruvboxFg3

hi! link markdownHeadingDelimiter GruvboxOrange
hi! link markdownUrl GruvboxOrangeLight
hi! link markdownUrlTitleDelimiter GruvboxGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType GruvboxYellow
" hi! link haskellOperators GruvboxOrange
" hi! link haskellConditional GruvboxAqua
" hi! link haskellLet GruvboxOrange
"
hi! link haskellType GruvboxFg1
hi! link haskellIdentifier GruvboxFg1
hi! link haskellSeparator GruvboxFg1
hi! link haskellDelimiter GruvboxFg4
hi! link haskellOperators GruvboxGrayLight
"
hi! link haskellBacktick GruvboxOrange
hi! link haskellStatement GruvboxOrange
hi! link haskellConditional GruvboxOrange

hi! link haskellLet GruvboxAqua
hi! link haskellDefault GruvboxAqua
hi! link haskellWhere GruvboxAqua
hi! link haskellBottom GruvboxAqua
hi! link haskellBlockKeywords GruvboxAqua
hi! link haskellImportKeywords GruvboxAqua
hi! link haskellDeclKeyword GruvboxAqua
hi! link haskellDeriving GruvboxAqua
hi! link haskellAssocType GruvboxAqua

hi! link haskellNumber GruvboxOrangeLight
hi! link haskellPragma GruvboxOrangeLight

hi! link haskellString GruvboxGreen
hi! link haskellChar GruvboxGreen

" }}}
" Json: {{{

hi! link jsonKeyword GruvboxGreen
hi! link jsonQuote GruvboxGreen
hi! link jsonBraces GruvboxFg1
hi! link jsonString GruvboxFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! GruvboxHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! GruvboxHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
