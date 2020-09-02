" Plugins
" -------------------------------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'scrooloose/nerdtree'                      " File browser
  Plug 'qpkorr/vim-bufkill'                       " Better buffer management (don't close windows when deleting buffers)
  Plug 'sheerun/vim-polyglot'                     " Language packs
  Plug 'ciaranm/detectindent'                     " Detect indents
  Plug 'tpope/vim-commentary'                     " Auto commenting
  Plug 'tpope/vim-fugitive'                       " Git
  Plug 'junegunn/fzf'                             " Fuzzy finder
  Plug 'junegunn/fzf.vim'                         " Fuzzy finder vim helpers
  Plug 'ryanoasis/vim-devicons'                   " Icons for NERDTree
  Plug 'vim-airline/vim-airline'                  " Airline status line
  Plug 'jackguo380/vim-lsp-cxx-highlight'         " Semantic highlighting for c/c++/objc
  Plug 'djoshea/vim-autoread'                     " Auto reload files when they change
  Plug 'kassio/neoterm'                           " Terminal management
  Plug 'edkolev/tmuxline.vim'                     " tmux airline
  Plug 'uiiaoo/java-syntax.vim'                   " Better Java syntax highlighting
  "Plug 'airblade/vim-gitgutter'
  Plug 'Yggdroot/indentLine'
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc intellisense engine
  
  " Themes
  Plug 'vim-airline/vim-airline-themes'
  Plug 'morhetz/gruvbox'
  Plug 'rakr/vim-one'
  Plug 'ayu-theme/ayu-vim'
  Plug 'dempfi/vim-airline-neka'
  Plug 'danilo-augusto/vim-afterglow'
  Plug 'rainglow/vim'
  Plug 'connorholyday/vim-snazzy'
call plug#end()

" -------------------------------------------------------------------------------------------------
" Plugin Configuration
" -------------------------------------------------------------------------------------------------

" Disable highlighting variables in Java
highlight link JavaIdentifier NONE

" vim-commentary
autocmd FileType rust setlocal commentstring=//\ %s
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType typescript setlocal commentstring=//\ %s
autocmd FileType javascriptreact setlocal commentstring=//\ %s
autocmd FileType typescriptreact setlocal commentstring=//\ %s

" neoterm
let g:neoterm_default_mod = "botright"
let g:neoterm_size = 15
let g:neoterm_autoscroll = 1

" NERDTree
let NERDTreeShowHidden=1                      " Show hidden files in nerdtree
let NERDTreeMinimalUI = 1

" DetectIndent
augroup detect_indent
    autocmd!
    autocmd BufReadPost * DetectIndent
augroup end

" FZF
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden --literal --ignore node_modules --ignore .git', <bang>0) 

" COC
let g:coc_global_extensions = [
            \'coc-highlight', 'coc-tsserver', 'coc-html', 'coc-python', 'coc-css',
            \'coc-eslint', 'coc-prettier', 'coc-json', 'coc-java',
            \'coc-actions', 'coc-yaml', 'coc-rls']
augroup custom_coc
    autocmd!
    autocmd FileType python let b:coc_root_patterns = ['.pylintrc', 'requirements.txt']
    autocmd FileType typescript.tsx,typescript,javascript,javascript.tsx let b:coc_root_patterns = ['package.json']
    "autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled=1

" -------------------------------------------------------------------------------------------------
" Basics
" -------------------------------------------------------------------------------------------------

" Source config when saved
let g:vimrc_path = expand('<sfile>:p')
execute "autocmd! BufWritePost" g:vimrc_path "source" g:vimrc_path

set termguicolors                           " Enable 24bit color  
set nowrap                                  " Disable wrapping by default
set hidden                                  " Allow hidden buffers
set mouse=a                                 " Enable mouse support
set number numberwidth=4                    " Enable line numbers
set ts=4 sts=4 sw=4 expandtab               " Insert spaces for tabs and set the width
set textwidth=119                           " Specifies the width of inserted text
set cmdheight=1                             " Single line commands
set updatetime=300                          " Time before writing to swap file (ms)
set shortmess+=c                            " Avoid displaying insert completion messages
set completeopt=noinsert,menuone,preview    " Sets the behaviour of the autocompletion menu
set signcolumn=yes                          " Always draw the sign column (gutter indicators)
set ignorecase                              " Ignore search case, needs to be on for smartcase to work
set smartcase                               " Ignore search case unless there is a capital in the term
set linespace=3                             " Insert a number of pixels between lines (for underlining)
set cursorline                              " Highlight the line the cursor is currently on
set sessionoptions+=globals                 " Include global variables in sessions saved with mksession
set backspace=indent,eol,start              " Allow backspace everywhere
set clipboard+=unnamedplus                  " Use the system clipboard by default for yank/delete/paste

" Copy into X11 PRIMARY when releasing the mousebutton in visual mode (for copy on select)
" and stay in visual mode
:vnoremap <LeftRelease> "*y<LeftRelease>gv

" Colors
let ayucolor="mirage"
let g:airline_theme = 'ayu'
colorscheme ayu
" let g:terminal_color_0  = '#2e3436'
" let g:terminal_color_1  = '#cc0000'
" let g:terminal_color_2  = '#4e9a06'
" let g:terminal_color_3  = '#c4a000'
" let g:terminal_color_4  = '#3465a4'
" let g:terminal_color_5  = '#75507b'
" let g:terminal_color_6  = '#0b939b'
" let g:terminal_color_7  = '#d3d7cf'
" let g:terminal_color_8  = '#555753'
" let g:terminal_color_9  = '#ef2929'
" let g:terminal_color_10 = '#8ae234'
" let g:terminal_color_11 = '#fce94f'
" let g:terminal_color_12 = '#729fcf'
" let g:terminal_color_13 = '#ad7fa8'
" let g:terminal_color_14 = '#00f5e9'
" let g:terminal_color_15 = '#eeeeec'

" -------------------------------------------------------------------------------------------------
" Key Mappins
" -------------------------------------------------------------------------------------------------

let mapleader=' '                        

" Edit vimrc
nmap <leader>v :execute "vsplit" g:vimrc_path<cr> 

" Toggle terminal
nmap ` :Ttoggle<cr>

" Toggle file browser
nmap <leader>b :NERDTreeToggle<CR>

" Find current file in file browser
nmap <leader>B :NERDTreeFind<CR>

" Split vertically
nmap <leader>\ :vsplit<cr> :wincmd l<cr>

" Split horizontally
nmap <leader>% :split<cr> :wincmd j<cr>

" Buffers
nmap <f1> :Buffers<cr>

" Find in project
nmap <leader>f :Ag<space>
nmap <f3> :Ag<space>
nmap <leader>F :Ag <C-R><C-W><CR>

" Auto commenting
nmap <leader>/ gcc
vmap <leader>/ gc

" Format file
nmap <leader>" :Format<cr>

" Delete buffer
nmap <C-q>     :BD<cr> 

" Write
nmap <C-s>     :w<cr>

" Navigate quickfile
nmap <f9>      :cn<cr>
nmap <F21>     :cprev<cr>

" Ctrl-p fuzzy file finder
nmap <C-p>     :Files<CR>

" Window navigation
nmap <C-S-Left>   <C-w>h
nmap <C-S-Right>  <C-w>l
nmap <C-S-Up>     <C-w>k
nmap <C-S-Down>   <C-w>j

" coc completion with TAB
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" coc confirm completion
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" coc mappings
nmap <silent> [c    <Plug>(coc-diagnostic-prev)
nmap <silent> ]c    <Plug>(coc-diagnostic-next)
nmap <silent> <f8>  <Plug>(coc-diagnostic-next)
nmap <silent> <f9>  :cnext<cr>
nmap <silent> <F20> <Plug>(coc-diagnostic-prev)
nmap <silent> gd    <Plug>(coc-definition)
nmap <silent> <f12> <Plug>(coc-definition)
nmap <silent> gy    <Plug>(coc-type-definition)
nmap <silent> gi    <Plug>(coc-implementation)
nmap <silent> gr    <Plug>(coc-references)
nmap <leader>rn     <Plug>(coc-rename)
nmap <f2>           <Plug>(coc-rename)
nmap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
nmap <silent> <leader>s  :CocList -I symbols<cr>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nmap <silent> K :call <SID>show_documentation()<CR>

command! -nargs=0 Format :call CocAction('format')
command! -nargs=? Fold   :call CocAction('fold', <f-args>)
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

" Terminal
nmap <silent> <leader>t :botright Ttoggle<cr>
tmap <Esc> <C-\><C-n>

" Todo 
nmap <leader>` :e ~/Desktop/todo.txt<cr>

" QuickFix 
autocmd QuickFixCmdPost [^l]* botright cwindow
autocmd QuickFixCmdPost    l* botright lwindow

" Building (override s:build in project specific stuff)
function! Build()
    if !exists("g:build_cmd")
        echoerr "Set g:build_cmd with the command you want to run"
        return
    endif
    " Kill any running process in the terminal
	:Tkill
    " Clear the terminal and any scrollback
	:Tclear!
    " Open the terminal
	:Topen
    " Run the build command
    execute ":T ". g:build_cmd
endfunction
command! Build call Build()
map <f5> :Build<cr>
map <f4> :cclose<cr>

" Allow local rc files
set exrc
set secure
