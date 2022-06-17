set nocompatible

" ================================================================================
" plugins
" ================================================================================
filetype off                  " required
" set the runtime path to include Vundle and initialize
if has('win32' || 'win64')
    set rtp+=~/AppData/Local/nvim/bundle/Vundle.vim
    call vundle#begin('~/AppData/Local/nvim/bundle')
else
    set rtp+=~/.local/share/nvim/bundle/Vundle.vim
    call vundle#begin('~/.local/share/nvim/bundle')
endif
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" seamless navigation between panes embedded in tmux
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'airblade/vim-rooter'
Plugin 'morhetz/gruvbox'
Plugin 'tpope/vim-vinegar'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal

filetype plugin on


" ================================================================================
" settings
" ================================================================================
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set autoread " read changes to file automatically
set nobackup " do not keep a backup file, use versions instead
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set incsearch " do incremental searching
set tabstop=4
set smarttab
set scrolloff=6
set sidescrolloff=6
set display+=lastline
set number
set expandtab
set shiftwidth=4
set autoindent
set backupdir=./.backup,/tmp,.
set directory=.,./.backup,/tmp
set noswapfile
" permanent undo
set undofile
set undodir=~/.vimdid
"set cursorline
set laststatus=2

" global plugin settings
let g:airline#extensions#tabline#enabled = 1
let g:rooter_silent_chdir = 1
let g:ctrlp_show_hidden = 1

" theme settings
if has('gui_running')
    set guioptions=aegimrL
    colorscheme gruvbox
    if has('gui_win32') || has('gui_win64')
        set guifont=Consolas:h9:cANSI
    else
        set guifont=Menlo-Regular:h12
    endif
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    set t_Co=16
    syntax on
    set hlsearch
    hi Comment gui=NONE
    hi String gui=italic
endif

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" ================================================================================
" autocommands
" ================================================================================

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid or when inside an event handler
" (happens when dropping a file on gvim).
" Also don't do it when the mark is in the first line, that is the default
" position when opening a file.
autocmd BufReadPost *
\ if line("'\"") > 1 && line("'\"") <= line("$") |
\   exe "normal! g`\"" |
\ endif

" Dont add comment at the newline
au FileType * set fo-=c fo-=r fo-=o fo+=j
autocmd InsertEnter * :set number
autocmd InsertEnter * :set cursorline!
autocmd InsertLeave * :set relativenumber
autocmd InsertLeave * :set cursorline
autocmd BufEnter * silent! lcd %:p:h
autocmd FileType text setlocal textwidth=78
autocmd Syntax * syntax keyword hhNotes NOTE NOTES containedin=ALL | highlight def link hhNotes TODO

au BufRead,BufNewFile *.fth set filetype=forth
au BufRead,BufNewFile *.s set filetype=armasm
au BufRead,BufNewFile *.md set filetype=markdown
" au BufRead,BufNewFile *.cpp set makeprg=g++\ -std=c++11\ %\ -o\ -%<\ -Wall

" ================================================================================
" bindings
" ================================================================================
let mapleader=" "
nnoremap <Leader>q :q<CR>
nnoremap <Leader>Q <C-w><C-p>:q<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>e :e 
nnoremap <Leader>f :sus<CR>
nnoremap <Leader>v :vsplit<CR><C-w><C-p>:CtrlPBuffer<CR>
nnoremap <Leader>V :Vex<CR>

nnoremap <Leader>b :CtrlPBuffer<CR>
nnoremap <Leader>B <C-w><C-p>:CtrlPBuffer<CR>

nnoremap <Leader>g :vimgrep
nnoremap <Leader>c :copen<CR>
nnoremap <Leader>C :cclose<CR>
nnoremap <Leader>m :make<CR>

nnoremap <Leader><TAB> <C-w><C-w>
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k
nnoremap <Leader>l <C-w>l

nnoremap <Leader>H <C-w>H
nnoremap <Leader>J <C-w>J
nnoremap <Leader>K <C-w>K
nnoremap <Leader>L <C-w>L

nnoremap <Leader>[ 2<C-w><
nnoremap <Leader>] 2<C-w>>
nnoremap <Leader>- 2<C-w>-
nnoremap <Leader>= 2<C-w>+

nnoremap <Leader>,8 :set tw=80<CR>
nnoremap <Leader>,0 :set tw=0<CR>
nnoremap <Leader>,cpp :-1read $HOME/dotfiles/vim/skeleton.cpp<CR>8j
nnoremap <Leader><Leader> <C-^>

nnoremap H ^
nnoremap L $

" inspired by unimpaired plugin
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>
nnoremap ]B :blast<CR>
nnoremap [B :bfirst<CR>

nnoremap [<space> O<ESC>
nnoremap ]<space> o<ESC>

nnoremap [ob :set background=light<CR>
nnoremap ]ob :set background=dark<CR>
nnoremap [ow :set wrap<CR>
nnoremap ]ow :set nowrap<CR>
nnoremap [os :set spell<CR>
nnoremap ]os :set nospell<CR>

" Don't use Ex mode, use Q for formatting
map Q <Nop>

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" add curly closing brackets after pressing enter
inoremap {<CR> {<CR>}<ESC>O

" move to start and end of line using home row keys
map H ^
map L $

" allow Ctrl-S as a save command
noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>


" ================================================================================
" functions
" ================================================================================

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  \ | wincmd p | diffthis
endif

" Close all buffers not currently displayed
command! CloseHiddenBuffers call s:CloseHiddenBuffers()
function! s:CloseHiddenBuffers()
    let open_buffers = []

    for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
    endfor

    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
            exec "bdelete ".num
        endif
    endfor
endfunction

