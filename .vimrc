"
" A (not so) minimal vimrc.  "

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set nu
set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =1         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitright             " Open new windows right of the current window.
set splitbelow             " Open new windows below the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set list                   " Show non-printable characters.
let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
"if has('multi_byte') && &encoding ==# 'utf-8'
"  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
"  "let &listchars = 'tab:•\ ,trail:•,extends:»,precedes:«' " Unprintable chars mapping
"else
"  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
"endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
"set backup
"set backupdir   =$HOME/.vim/files/backup/
"set backupext   =-vimbackup
"set backupskip  =
"set directory   =$HOME/.vim/files/swap//
"set updatecount =100
"set undofile
"set undodir     =$HOME/.vim/files/undo/
"set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" enable 256-color mode
"let &t_Co=256
"let &t_AF="\e[38;5;%dm"
"let &t_AB="\e[48;5;%dm"

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" file encode setting
set fileencodings=utf-8,gb2312,gb18030,gbk,ucs-bom,cp936,latin1
set enc=utf8
set fencs=utf8,gbk,gb2312,gb18030

call plug#begin('~/.vim/plugged')
" Plug 'KeitaNakamura/neodark.vim'
 Plug 'joshdick/onedark.vim'
" Plug 'morhetz/gruvbox'
" Plug 'KabbAmine/yowish.vim'
 Plug 'vim-airline/vim-airline'
 Plug 'wakatime/vim-wakatime'
 Plug 'ycm-core/YouCompleteMe'
 Plug 'junegunn/fzf.vim'
 Plug 'vim-autoformat/vim-autoformat'
call plug#end()

" solve the delay when changing from insert mode to normal mode
set timeoutlen=1000 ttimeoutlen=0

" yowish gruvbox
colorscheme onedark
" light
"set background=dark

" airline setting
let g:airline_powerline_fonts = 1
"let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#whitespace#enabled = 0

"key map
nnoremap <C-]>      :YcmCompleter GoToDefinition <CR>
nnoremap <leader>gd :YcmCompleter GoToDefinition <CR>
nnoremap <leader>gr :YcmCompleter GoToReferences <CR>


nnoremap <F2>   :Explore <CR>
inoremap jj     <Esc>
