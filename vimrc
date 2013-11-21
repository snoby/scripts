set expandtab
set tabstop=3
set shiftwidth=3
set autoindent
set smartindent
set number
set incsearch
set nolazyredraw " Don't redraw while executing macros
set cindent  " correctly indent c files
set ignorecase   " don't care about the case when searching
set smartcase    " will only make the search case sensitive when search term is 
set hlsearch     " highlight the search functionality

set autowrite     " Automatically write a file when moving off a modified buffer.
"This makes the clipboard selection alutomatically shared to the system
"set clipboard=unnamed
"Make visual selections automatically go to the clipboard
"set go+=a


execute pathogen#infect()
filetype on      " always detect the file type.
syntax on
filetype plugin indent on
let g:load_doxygen_syntax=1

set cpoptions+=$
set showmatch
set sidescroll=0 " don't wrap lines
set laststatus=2 "show status
"set showtabline=2 " always show tabs in gvim, but not vim


"
" This is for the taglist window
let Tlist_Exit_OnlyWindow = 1
let Tlist_Auto_Open = 1  " always open at startup
let Tlist_Show_One_File =1 " just show one file in the window
let Tlist_Process_File_always =1 "create tags file even when window not running
let Tlist_Auto_Update = 1
let Tlist_Auto_Highlight_Tag = 1


"
"
"this is for the autocomplete
" to autocomplete after it has popped  a window up use Ctrl-O to select
set nocp

" This is for python  python-mode
filetype off
"call pathogen#infect()
" disable call pathogen#helptags()

filetype plugin indent on

"end for python mode

" disable autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType cpp set omnifunc=omni#cpp#complete#Main
autocmd FileType c set omnifunc=ccomplete#Complete

" This is for the status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ \ [%{Tlist_Get_Tagname_By_Line()}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L] 

"
" For the omni autocomplete to work the tags database
" must be created this way:
"  ctags -R --c++-kinds=+p --fields=+iaS --extra=+q
"
"  the following is used to automatically clase the 
"  autocomplete preview window
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif


"
" This is for selecting the font on the 
" operating sysetem.
"
"
if has ( 'gui_running')
   if has ("unix")
   let s:uname = system("uname")
   	if s:uname == "Darwin\n"
      	" This is a mac
      	"set guifont=Monaco:h11
      	set guifont="DejaVu Sans Mono":h12
         " Turn off antialias
         "set noanti  
         "Turn on the Toolbar
         set go+=T
   	else
      "This is a Linux based computer.
         set guifont=Monospace\ 9
   	endif
	endif
colorscheme torte
endif

"
"The following are key maping commands
"
"         Generate tags in a particular projects root - Control F12
map <C-F12> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . <CR>
nnoremap <silent> <F8> :TlistToggle<CR> :TlistUpdate<CR>


" Let ctrl tab switch betwen tabs just like in a web browser
noremap <c-tab> :tabnext<cr>
" shift ctrl tab goes the other way
noremap<c-s-tab> :tabprev<cr>
" FINALLY for the mac, don't know about Linux
" Go to the last tab
noremap<D-0> :tablast<CR>


" Let me know when I'm getting near the end of the line
set colorcolumn=120
set formatoptions=qrn1



" Note worthy key press commands"
" Note shift enter will open a new tab with the tag under the cursor.

" \ t will start the command T file open command.

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Tab configuration
map <leader>tn :tabnew<cr>


"This allows me to fold results of a search
" original fold with context nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?0:(getline(v:lnum-1)=~@/)\\|\\|(getline(v:lnum+1)=~@/)?1:2 foldmethod=expr foldlevel=0 foldcolumn=2<CR>
nnoremap \z :setlocal foldexpr=(getline(v:lnum)=~@/)?2:3 foldmethod=expr foldlevel=0 foldcolumn=2<CR>








" This is for the neocomplcache plugin
let g:neocomplcache_enable =1
let g:neocomplcache_enable_at_startup =1
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
"
" Below is for tags
"  If you have multiple tag files , or your current working directory changes,
"  it is usefult ot have vim search recursively upwards for the tags file.
set tags=./tags;/







" nice a simple way to make the gui tab show the tab number
" the name and whether it's modified or not.
set guitablabel=%N:%M%t
"
" Customize various Vim auto-completion features.
"

" The function InsertTabWrapper and the mappings that follow it give the Tab
" character completion behavior in insert mode similar to what's available in
" modern IDEs. Borrowed from: http://vim.wikia.com/wiki/VimTip102.

function! InsertTabWrapper(direction)
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\"
    elseif "backward" == a:direction
        return "\"
    else
        return "\"
    endif
endfunction

inoremap  =InsertTabWrapper ("forward")
inoremap  =InsertTabWrapper ("backward")


" Some more customizations.
" If we lose focus autosave
au FocusLost * :wa


set runtimepath^=~/.vim/bundle/ctrlp.vim/doc

"
" For Easy Expansion of the Active File Directory
"Now when we type %% on Vim's : command-line prompt it automatically
"expands to the path of the active buffer.
"
cnoremap <expr> %% getcmdtype() == ':' ? expand('%h').'/' : '%%'

