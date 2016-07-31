" .vimrc
" a bunch of garbage
"
" Preamble ---------------------------------------------------------------- {{{

set nocompatible
filetype on " fix bad exit status with OSX vim
filetype off
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'airblade/vim-gitgutter'
Plugin 'chriskempson/base16-vim'
Plugin 'edkolev/tmuxline.vim'
Plugin 'embear/vim-localvimrc'
Plugin 'junegunn/vim-easy-align'
Plugin 'kien/ctrlp.vim'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'rust-lang/rust.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tomasr/molokai'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'Valloric/YouCompleteMe'
"Plugin 'klen/python-mode'
"Plugin 'racer-rust/vim-racer'


" plugin from http://vim-scripts.org/vim/scripts.html
"Plugin 'L9'
" Git plugin not hosted on GitHub
"Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
"Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Avoid a name conflict with L9
"Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

set runtimepath^=bundle/ctrlp.vim

" }}}
" Basic options ----------------------------------------------------------- {{{

set encoding=utf-8
set modelines=1
set autoindent
set showmode
set showcmd
set hidden
set visualbell
set ttyfast
set ruler
set backspace=indent,eol,start
set number
set laststatus=2
set history=1000

set list
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set shell=/bin/zsh
set lazyredraw
set matchtime=3
"set showbreak=↪\   " that extra space be important
set splitbelow
set splitright
set fillchars=diff:⣿,vert:│
set autowrite
set autoread
set shiftround
set title
set linebreak
set dictionary=/usr/share/dict/words
set joinspaces " HI HATERS

" Make the yank buffer copy into the clipboard
set clipboard=unnamed

" Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" Make Vim able to edit crontab files again.
set backupskip=/tmp/*,/private/tmp/*"

" I still use a mouse to scroll.
set mouse=a

" Save when losing focus
au FocusLost * :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Cursorline {{{
" Only show cursorline in the current window and in normal mode.

augroup cline
    au!
    au WinLeave * set nocursorline
    au WinEnter * set cursorline
    au InsertEnter * set nocursorline
    au InsertLeave * set cursorline
augroup END

" }}}
" Trailing whitespace {{{

augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:·
    au InsertLeave * :set listchars+=trail:·
augroup END

" }}}
" Tabs, spaces, wrapping {{{

set tabstop=4
set shiftwidth=4
set softtabstop=4 " for expandtab
set expandtab
set wrap
set textwidth=80
set formatoptions=croqj12

if version >= 703
    set colorcolumn=+1
endif

" }}}
" Backups {{{

if version >= 703
    set undofile
    set undoreload=10000
    set undodir=~/.vim/tmp/undo     " undo files
endif

set nobackup  " fuck backups, yolo
set nowritebackup
set noswapfile

" }}}
" Leader {{{

let mapleader = "\\"
let maplocalleader = ","

" }}}
" Color scheme {{{

syntax on
if ! has("gui_running")
    set t_Co=256
endif


if isdirectory(expand("~/.config/base16-shell/scripts"))
	let g:base16_shell_path=expand("~/.config/base16-shell/scripts")
endif

if isdirectory(expand("~/.vim/bundle/base16-vim/"))
	let base16colorspace=256  " Access colors present in 256 colorspace
	colorscheme base16-summerfruit
else
    colorscheme default
endif

set background=light

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" }}}

" }}}
" Searching and movement -------------------------------------------------- {{{

" Use sane regexes.
nnoremap / /\v
vnoremap / /\v

set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set gdefault

set scrolloff=3
set sidescroll=1
set sidescrolloff=10

set virtualedit+=block

noremap <leader><space> :noh<cr>:call clearmatches()<cr>

" Made D behave
nnoremap D d$

" Made Y behave
nnoremap Y y$

" Don't move on *
nnoremap * *<c-o>

" Keep search matches in the middle of the window and pulse the line when moving
" to them.
nnoremap n nzzzv
nnoremap N Nzzzv

" Same when jumping around
nnoremap g; g;zz
nnoremap g, g,zz

" Open a Quickfix window for the last search.
nnoremap <silent> <leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" Fix linewise visual selection of various text objects
nnoremap VV V
nnoremap Vit vitVkoj
nnoremap Vat vatV
nnoremap Vab vabV
nnoremap VaB vaBV

" Directional Keys {{{

noremap j gj
noremap k gk

" Easy buffer navigation
noremap <C-h>  <C-w>h
noremap <C-j>  <C-w>j
noremap <C-k>  <C-w>k
noremap <C-l>  <C-w>l
noremap <leader>v <C-w>v

" Move between separate buffers
noremap <C-Left> :bp<CR>
noremap <C-Right> :bn<CR>
noremap ` <C-^>


" }}}

" }}}
" Folding ----------------------------------------------------------------- {{{

set foldlevelstart=100

" Space to toggle folds.
nnoremap <Space> za
vnoremap <Space> za

" Make zO recursively open whatever top level fold we're in, no matter where the
" cursor happens to be.
nnoremap zO zCzO

" Use ,z to "focus" the current fold.
nnoremap <leader>z zMzvzz

function! MyFoldText() " {{{
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    let foldedlinecount = v:foldend - v:foldstart

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2 -len(foldedlinecount))
    let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
    return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
endfunction " }}}
set foldtext=MyFoldText()

" }}}
" Filetype-specific stuff ------------------------------------------------- {{{

" C {{{

augroup ft_c
    au!
    au FileType c setlocal foldmethod=syntax
augroup END

" }}}
" Rust {{{

augroup ft_rust
    au!
    au FileType rust setlocal foldmethod=syntax
    au FileType rust nnoremap <leader><leader> :!clear && bash -c 'cargo test'<cr>
    au FileType rust setlocal hidden
augroup END

" }}}
" Java {{{

augroup ft_java
    au!

    au FileType java setlocal foldmethod=marker
    au FileType java setlocal foldmarker={,}
augroup END

" }}}
" Pandoc (Markdown) {{{
"
"

augroup ft_pandoc
    au!

    " Wrap the text into paragraphs and turn on spell checking
    au FileType pandoc setlocal joinspaces spell formatoptions+=t formatoptions-=j

    let g:pandoc#modules#disabled = ['chdir']
    let g:pandoc#syntax#conceal#blacklist = ['subscript', 'superscript', 'ellipses']
    let g:pandoc#formatting#mode = 'h'
    let g:pandoc#keyboard#header_style = 's'


    " requires fugitive
augroup END

" tex.vim {{{

let g:tex_conceal = "abdmg"

"}}}

" }}}
" QuickFix {{{

augroup ft_quickfix
    au!
    au Filetype qf setlocal colorcolumn=0 nolist nocursorline nowrap
augroup END

" }}}
" Ruby {{{

augroup ft_ruby
    au!
    au Filetype ruby setlocal foldmethod=syntax
augroup END

" }}}
" Scheme {{{

augroup ft_scheme
    au!
    au Filetype scheme RainbowParenthesesToggle
    au Filetype scheme setlocal tabstop=2 shiftwidth=2 softtabstop=2
augroup END

" }}}
" Vim {{{

augroup ft_vim
    au!

    au FileType vim setlocal foldmethod=marker
    au FileType help setlocal textwidth=78
    au BufWinEnter *.txt if &ft == 'help' | wincmd L | endif
augroup END

" }}}
" Mail {{{

augroup ft_mail
    au!

    au Filetype mail setlocal spell joinspaces textwidth=78
    au FileType mail map <F8> :%g/^> >/d<CR>

augroup END

" }}}
" }}}
" Convenience mappings ---------------------------------------------------- {{{
" Destroy infuriating keys {{{

" Fuck you, help key.
noremap <F1> <nop>
nnoremap <F1> <nop>
inoremap <F1> <nop>
vnoremap <F1> <nop>

" Stop it, hash key.
inoremap # X<BS>#

" }}}
" Training keys {{{
" To be a better human and vim user. Only doing this in normal mode for now.
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
" }}}

" Clean trailing whitespace
nnoremap <leader>w :%s/\s\+$//<cr>:let @/=''<cr>

" Send visual selection to gist.github.com as a private, filetyped Gist
" Requires the gist command line too (brew install gist)
vnoremap <leader>G :w !gist -p -t %:e \| xsel<cr>
vnoremap <leader>UG :w !gist -p \| xsel<cr>

" Substitute
nnoremap <leader>s :%s//<left>

" Easier linewise reselection
nnoremap <leader>V V`]

" Split line (sister to [J]oin lines)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc><right>

" Align text
nnoremap <leader>Al :left<cr>
nnoremap <leader>Ac :center<cr>
nnoremap <leader>Ar :right<cr>
vnoremap <leader>Al :left<cr>
vnoremap <leader>Ac :center<cr>
vnoremap <leader>Ar :right<cr>

" Less chording
nnoremap ; :

" Select (charwise) the contents of the current line, excluding indentation.
" Great for pasting Python lines into REPLs.
nnoremap vv ^vg_

" Better Completion
set completeopt=longest,menuone,preview

" Gary Bernhardt's Multipurpose Tab Key {{{
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>
"}}}

" Typos {{{
command! -bang E e<bang>
command! -bang Q q<bang>
command! -bang W w<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Wq wq<bang>
command! -bang WQ wq<bang>

" Toggle paste
set pastetoggle=<F9>

" Make for the lazy (me)
nnoremap <leader><leader> :make!<cr>

" }}}
" }}}
" Plugin settings --------------------------------------------------------- {{{
"
" ctrlp{{{

let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" }}}
" virtualenv {{{
let g:virtualenv_directory='.'
" }}}
" Localvimrc {{{
let g:localvimrc_sandbox=0
"let g:localvimrc_ask=0
let g:localvimrc_persistent=1

" }}}
" NERDTree {{{

nnoremap ft :NERDTreeToggle<cr>
nnoremap ff :NERDTreeFocus<cr>

let NERDChristmasTree=1
let NERDTreeIgnore=['\.pyc$'] " blah

" }}}
" Airline / Powerline {{{

"let g:Powerline_symbols = 'fancy'

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

let g:airline_theme = 'base16'
let g:airline#extensions#tmuxline#enabled = 1
" airline#extensions#tmuxline#snapshot_file = "~/.tmux-statusline-colors.conf"


" }}}
" Pymode {{{
    let g:pymode_lint = 0
    let g:pymode_warnings = 0
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
    let g:pymode_syntax_print_as_function = 1
    let g:pymode_doc = 0
    let g:pymode_virutalenv = 1
    let g:pymode_rope_autoimport = 0
    let g:pymode_rope_show_doc_bind = '<nop>'

    if getcwd() == $HOME
        let g:pymode = 0
    endif
" }}}
"
" easy-align {{{
"
" Start interactive EasyAlign in visual mode (e.g. vip<Enter>)
vmap <Enter> <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. <Leader>aip)
nmap <Leader>a <Plug>(EasyAlign)

" }}}

" YouCompleteMe {{{

let g:ycm_rust_src_path = '/usr/src/rust/src'

" }}}

" }}}
" Environments (GUI/Console) ---------------------------------------------- {{{

if has('gui_running')
    set guifont=Ubuntu\ Mono\ 11

    " Remove all the UI cruft
    set go-=T
    set go-=l
    set go-=L
    set go-=rfor
    set go-=R

    highlight SpellBad term=underline gui=undercurl guisp=Orange

    " Use a line-drawing char for pretty vertical splits.
    set fillchars+=vert:│

    " Different cursors for different modes.
    set guicursor=n-c:block-Cursor-blinkon0
    set guicursor+=v:block-vCursor-blinkon0
    set guicursor+=i-ci:ver20-iCursor

    if has("gui_macvim")
        " Full screen means FULL screen
        set fuoptions=maxvert,maxhorz

        " Use the normal HIG movements, except for M-Up/Down
        let macvim_skip_cmd_opt_movement = 1
        no   <D-Left>       <Home>
        no!  <D-Left>       <Home>
        no   <M-Left>       <C-Left>
        no!  <M-Left>       <C-Left>

        no   <D-Right>      <End>
        no!  <D-Right>      <End>
        no   <M-Right>      <C-Right>
        no!  <M-Right>      <C-Right>

        no   <D-Up>         <C-Home>
        ino  <D-Up>         <C-Home>
        imap <M-Up>         <C-o>{

        no   <D-Down>       <C-End>
        ino  <D-Down>       <C-End>
        imap <M-Down>       <C-o>}

        imap <M-BS>         <C-w>
        inoremap <D-BS>     <esc>my0c`y
    else
        " Non-MacVim GUI, like Gvim
    end
else
    " Console Vim
endif

" }}}
