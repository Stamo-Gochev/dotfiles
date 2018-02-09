" automatically reload vimrc when it's saved
au BufWritePost .vimrc so ~/.vimrc

" =============================================================================
" Plugins
" =============================================================================

" Vundle
" on Windows, install Vundle in ~/.vim/plugin/vundle instead of ~/.vim/bundle/Vundle
" as /bundle folder prevents running the :PluginInstall command
" git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/plugin/Vundle.vim

" do not try to be compatible with vi, required
set nocompatible

" install Vundle (should be done manually otherwise)
let home_dir = expand('$HOME')
if !isdirectory(expand(home_dir . '/.vim/bundle/vundle/.git', 1))
  " Windows workaround for /bundle folder
  "	execute "! git clone https://github.com/VundleVim/Vundle.vim " . home_dir . "/.vim/plugin/vundle"
  execute "! git clone https://github.com/VundleVim/Vundle.vim " . home_dir . "/.vim/bundle/vundle"

  if v:shell_error
    finish
  else
    silent ! vim +PluginInstall +qall
  endif
endif

" required for Vundle
filetype off

" set the runtime path to include Vundle and initialize on Windows
" set rtp+=~/.vim/plugin/Vundle.vim

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#rc('~/.vim/bundle')

" let Vundle manage Vundle, required
" For GitHub repos, you specify plugins using the 'user/repository' format
" When using plugins from the Vim site, refer them by 'name' only

Plugin 'VundleVim/Vundle.vim'

Plugin 'flazz/vim-colorschemes'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-colorscheme-switcher'

Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'

Plugin 'pangloss/vim-javascript'
Plugin 'leafgarland/typescript-vim'
" required for tsuquyomi (or Vim 8)
Plugin 'Shougo/vimproc.vim'
" cd ~/.vim/bundle/vimproc.vim && make
" required if vimproc is used with vundle https://github.com/Shougo/vimproc.vim#vundle
Plugin 'Quramy/tsuquyomi'

Plugin 'mattn/emmet-vim'

Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'
Plugin 'jtratner/vim-flavored-markdown'
Plugin 'airblade/vim-gitgutter'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Fix airline fonts https://github.com/vim-airline/vim-airline/issues/513
" Setting the font to Consolas, 16 pt
if has("gui_running")
  if has("gui_gtk2")
    set guifont=Consolas\ 16
  else
    set guifont=Consolas:h16
  endif
endif

" configure terminal colors
let os = substitute(system('uname -a'), "\n", "", "")
if os =~ "Msys" || has("win32") || has("win64")
  " using 256-color terminal with Cmder on Windows is too hacky
else
  set term=xterm
  set t_Co=256
  let &t_AB="\e[48;5;%dm"
  let &t_AF="\e[38;5;%dm"
  set term=xterm-256color
endif

" All of your Plugins must be added before the following line
call vundle#end()
" return back the filetype, required
filetype plugin indent on
" To ignore plugin indent changes, instead use:
"filetype plugin on

" =============================================================================
" Settings
" =============================================================================

let mapleader=" "

set encoding=utf-8
set backupdir=~/.vim/backup

" allow Vim to copy to system clipboard
set clipboard+=unnamed

" make backspace delete in normal mode
set backspace=indent,eol,start

" show line numbers
set number

" use relative line numbers instead of absolute for better navigation
" set relativenumber

" keep several lines at top or bottom of a file when scrolling
set scrolloff=10

" enable line wrapping
set wrap linebreak nolist

" expand commands
set wildmode=list:longest

" Highlight current line
set cursorline

" Fix cursor type in Cygwin terminal on Windows when in normal (block) and insert mode (thin line)
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

" Enable mouse support - even in tmux \o/
set mouse=a

" avoid swap, temp and backup files
set nobackup
set nowritebackup
set noswapfile

" show the cursor position all the time
set ruler

" show trailing whitespace
set list listchars=tab:>-,trail:.

" Spelling
autocmd FileType markdown setlocal spell spelllang=en_us

" tabs and spaces
set tabstop=4
" normal mode shift width
set shiftwidth=4
" tab width in insert mode
set softtabstop=4
" use spaces instead of tabs
set expandtab

" indent
set autoindent
set smartindent
set smarttab

" file types
autocmd BufRead,BufNewFile *.cshtml set filetype=html
autocmd BufRead,BufNewFile *.md     set filetype=markdown
autocmd BufRead,BufNewFile *.md     set foldlevel=2
autocmd BufRead,BufNewFile *.json   set filetype=json

autocmd FileType gitcommit          setlocal spell
autocmd FileType jsx                let b:syntastic_checkers = ["eslint"]
autocmd FileType typescript nmap <buffer> <Leader>t : <C-u>echo tsuquyomi#hint()<CR>

" ignores
set wildignore=*.o,*.obj,*.bin,*.dll,*.zip
set wildignore+=*/dist/*,*/node_modules/*,*.min.js,*.js.map
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*
set wildignore+=*\\.git\\*,*\\.hg\\*,*\\.svn\\*

syntax on

" fixes Vim colors in Cmder
" Set this after the plugins have been loaded
set background=dark

"automatically save the file when switching between buffers
set autowriteall

" disable highlighting of matching parenthesis
let g:loaded_matchparen=1

" =============================================================================
" Settings (Plugins)
" =============================================================================

"------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------

" show hidden files by default
let NERDTreeShowHidden=1

" auto open NERDTree when opening Vim
" autocmd vimenter * NERDTree
" quit vim if NERDTree is the only existing window
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" change default NERDTree arrows
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

"------------------------------------------------------------------
" Syntastic
"------------------------------------------------------------------

let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exec = 'eslint_d'
let g:syntastic_json_checkers = ['jsonlint']
let g:syntastic_scss_checkers = ['scss_lint']
let g:syntastic_python_checkers = ['pylint']
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_typescript_checkers = ['tslint', 'tsc']
let g:syntastic_typescript_tsc_args = '--experimentalDecorators'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_aggregate_errors = 1

"------------------------------------------------------------------
" Vim-airline
"------------------------------------------------------------------

set statusline=%F%m%r%h%w[%L][%{&ff}]%y[%p%%][%04l,%04v]
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set laststatus=2

let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#buffer_idx_mode = 1

nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

"------------------------------------------------------------------
" Fugitive
"------------------------------------------------------------------

" use vertical splitting when using git diff
set diffopt+=vertical

" =============================================================================
" Mappings
" =============================================================================

"------------------------------------------------------------------
" Navigation
"------------------------------------------------------------------

" remap hjkl to klo;
map o <Up>
map l <Down>
map k <Left>
map ; <Right>

" allow j to be used instead of o
noremap j o

" unmap h
no h <Nop>
vno h <Nop>

" center the screen when navigating to top/bottom of file/segment, when searching, etc.
nmap G Gzz
nmap gg ggzz
nmap n nzz
nmap N Nzz
nmap } }zt
nmap { {zt
nmap `` ``zz
nmap % %zz

vmap G Gzz
vmap gg ggzz
vmap n nzz
vmap N Nzz
vmap } }zt
vmap { {zt
vmap `` ``zz
nmap % %zz

" center the screen when searching words under cursor
nmap * *zz

" go to the first character on the line instead of to the start of the line
nnoremap 0 ^

" go to the end of a line
nnoremap ) $

" open next/previous file (use buffers)
nmap <leader>ne :bn<CR>
nmap <leader>pre :bp<CR>

"------------------------------------------------------------------
" Typing
"------------------------------------------------------------------

" {}()[] :)
" inoremap { {}<left>
" inoremap ( ()<left>
" inoremap [ []<left>

" inoremap ' ''<left>
" inoremap " ""<left>

" inoremap < <><left>
" inoremap ` ``<left>

" override shortcuts
" add a ruby comment to a line with ic and remove it by rc
map ic :s/^/#/g<CR>:let @/ = ""<CR>
map rc :s/^#//g<CR>:let @/ = ""<CR>

" delete trailing whitespace
nnoremap <silent> <leader>cw :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
" Auto-clean whitespace
autocmd BufWritePre * :%s/\s\+$//e


" add comma and semicolon to the end of line
" inoremap <leader>; <C-o>A;<CR>
" inoremap <leader>, <C-o>A,
nnoremap <leader>;; <S-a>;<Esc>
nmap <leader>, <S-a>,<Esc>

" insert line above/below
nmap <Leader>oo O<Esc><Down>
nmap <Leader>ll j<Esc><Up>

"------------------------------------------------------------------
" Commands
"------------------------------------------------------------------

" switch to normal mode in a faster way
imap kk <Esc>

" switch to normal mode in a faster way
vnoremap mm <Esc>

" open vimrc
nnoremap <leader>ev :e $MYVIMRC<CR>

" use the latest vimrc
nnoremap <leader>rv :so $MYVIMRC<CR>

" go to start of line faster than typing ^
nnoremap <leader>a ^

" go to end of line faster than typing $
nnoremap <leader>e $

" indent with Tab
inoremap <S-Tab> <C-d>
nnoremap <Tab> >>
nnoremap <S-Tab> <<
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" remaping to Ctrl+s does not work for some reason
" even after stty -ixon
" noremap <C-S> :update<CR>
" vnoremap <C-S> <C-C>:update<CR>
" inoremap <C-S> <C-O>:update<CR>

noremap <leader>s :update<CR>
vnoremap <leader>s <C-C>:update<CR>
inoremap <leader>s <C-O>:update<CR>

" Refresh syntax highlighting on F12
noremap <F12> <Esc>:syntax sync fromstart<CR>
inoremap <F12> <C-o>:syntax sync fromstart<CR>

" Copy with Ctrl + C
vmap <C-c> "+y
" Paste with Ctrl + v
nmap <C-v> "+gP
" Cut with Ctrl + x
vnoremap <C-x> "+x

" paste from outside buffer
nnoremap <leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <leader>p <Esc>:set paste<CR>gv"+p:set nopaste<CR>
" copy to outside buffer
nnoremap <leader>y "+yy
vnoremap <leader>y "+y

" Select all text
nmap <C-a> ggVG

" do not move the cursor after copy in visual mode
" vmap y y`]

" make Backspace delete in normal mode
nnoremap <bs> X
" make Backspace delete in visual mode
vnoremap <bs> d

" faster way to move between split windows
nnoremap <leader>o <C-W><Up>
nnoremap <leader>l <C-W><Down>
nnoremap <leader>k <C-W><Left>
nnoremap <leader>; <C-W><Right>

" duplicate current line
noremap <C-d> Yp

" convert word to upper/lowercase
nnoremap <leader>up gUiw
nnoremap <leader>lo guiw

" move line up or down
noremap <leader><up> ddkP
noremap <leader><down> ddp

" remove the highlighting of words caused by search results
nmap <leader>h :noh<CR>

" close Vim in a faster way
nmap <leader>q :x<CR>

" close the current buffer (file) in a faster way
nnoremap <leader>w :w\|bd<cr>

" indent the whole file
nmap <leader>ind gg=G

" =============================================================================
" Mappings (Plugins)
" =============================================================================

"------------------------------------------------------------------
" NERDTree
"------------------------------------------------------------------

map <C-n> :NERDTreeToggle<CR>

let g:NERDTreeMapActivateNode = '<CR>'
let g:NERDTreeMapJumpFirstChild = '<C-^>'
let g:NERDTreeMapJumpLastChild = '<C-$>'
let g:NERDTreeMapOpenRecursively = '<C-NO>'

let g:NERDTreeMapJumpNextSibling = "<C-l>"
let g:NERDTreeMapJumpPrevSibling = "<C-o>"

"SECTION: Init variable calls for key mappings {{{2
" call s:initVariable("g:NERDTreeMapActivateNode", "o")
" call s:initVariable("g:NERDTreeMapChangeRoot", "C")
" call s:initVariable("g:NERDTreeMapChdir", "cd")
" call s:initVariable("g:NERDTreeMapCloseChildren", "X")
" call s:initVariable("g:NERDTreeMapCloseDir", "x")
" call s:initVariable("g:NERDTreeMapDeleteBookmark", "D")
" call s:initVariable("g:NERDTreeMapMenu", "m")
" call s:initVariable("g:NERDTreeMapHelp", "?")
" call s:initVariable("g:NERDTreeMapJumpFirstChild", "K")
" call s:initVariable("g:NERDTreeMapJumpLastChild", "J")
" call s:initVariable("g:NERDTreeMapJumpNextSibling", "<C-j>")
" call s:initVariable("g:NERDTreeMapJumpParent", "p")
" call s:initVariable("g:NERDTreeMapJumpPrevSibling", "<C-k>")
" call s:initVariable("g:NERDTreeMapJumpRoot", "P")
" call s:initVariable("g:NERDTreeMapOpenExpl", "e")
" call s:initVariable("g:NERDTreeMapOpenInTab", "t")
" call s:initVariable("g:NERDTreeMapOpenInTabSilent", "T")
" call s:initVariable("g:NERDTreeMapOpenRecursively", "O")
" call s:initVariable("g:NERDTreeMapOpenSplit", "i")
" call s:initVariable("g:NERDTreeMapOpenVSplit", "s")
" call s:initVariable("g:NERDTreeMapPreview", "g" . NERDTreeMapActivateNode)
" call s:initVariable("g:NERDTreeMapPreviewSplit", "g" . NERDTreeMapOpenSplit)
" call s:initVariable("g:NERDTreeMapPreviewVSplit", "g" . NERDTreeMapOpenVSplit)
" call s:initVariable("g:NERDTreeMapQuit", "q")
" call s:initVariable("g:NERDTreeMapRefresh", "r")
" call s:initVariable("g:NERDTreeMapRefreshRoot", "R")
" call s:initVariable("g:NERDTreeMapToggleBookmarks", "B")
" call s:initVariable("g:NERDTreeMapToggleFiles", "F")
" call s:initVariable("g:NERDTreeMapToggleFilters", "f")
" call s:initVariable("g:NERDTreeMapToggleHidden", "I")
" call s:initVariable("g:NERDTreeMapToggleZoom", "A")
" call s:initVariable("g:NERDTreeMapUpdir", "u")
" call s:initVariable("g:NERDTreeMapUpdirKeepOpen", "U")
" call s:initVariable("g:NERDTreeMapCWD", "CD")

" auto show file in tree
" autocmd BufEnter * if &modifiable | NERDTreeFind | wincmd p | endif
nnoremap <leader>nf :NERDTreeFind<CR>

"------------------------------------------------------------------
" CtrlP
"------------------------------------------------------------------

" use CtrlP plugin to open tags, e.g. search for JavaScript method
noremap <C-m> :CtrlPTag<CR>

"------------------------------------------------------------------
" vim-fugitive
"------------------------------------------------------------------

nnoremap <silent> <leader>gs :<C-u>Gstatus<CR>
nnoremap <silent> <leader>gw :<C-u>Gwrite<CR>
nnoremap <silent> <leader>gr :<C-u>Gread<CR>
nnoremap <silent> <leader>gc :<C-u>Gcommit<CR>
nnoremap <silent> <leader>gb :<C-u>Gblame<CR>
nnoremap <silent> <leader>gd :<C-u>Gdiff<CR>
" nnoremap <silent> <leader>gpr :<C-u>Gpull<CR>
" nnoremap <silent> <leader>gk :<C-u>Gpush<CR>
nnoremap <silent> <leader>gf :<C-u>Gfetch<CR>

" =============================================================================
" Searching
" =============================================================================

" Nicer searching
set incsearch               " Incremental searching
set hlsearch                " Highlight matches
set showmatch               " Show match numbers
set ignorecase              " Search case-insensitive
set smartcase               " ...except when something is capitalized

" =============================================================================
" Functions
" =============================================================================

" functions
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

function! SetLineNumbers()
    set number
endfunc

function! SetRelativeLineNumbers()
    set relativenumber
endfunc

" nnoremap <C-n> :call NumberToggle()<CR>

" nnoremap <C-n> :call SetLineNumbers()<CR>
" nnoremap <C-r> :call SetRelativeLineNumbers()<CR>
