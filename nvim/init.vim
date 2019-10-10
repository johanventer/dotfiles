" Source config when saved
let g:vimrc_path = expand('<sfile>:p')
execute "autocmd! BufWritePost" g:vimrc_path "source" g:vimrc_path

call plug#begin('~/.local/share/nvim/plugged')

" Automatically save/restore file views
Plug 'vim-scripts/restore_view.vim'

" File browser
Plug 'scrooloose/nerdtree'

" Better buffer management (don't close windows when deleting buffers)
Plug 'qpkorr/vim-bufkill'

" Language packs
Plug 'sheerun/vim-polyglot'

" Auto pairs
Plug 'jiangmiao/auto-pairs'
let g:AutoPairsMultilineClose = 0

" Detect indents
Plug 'ciaranm/detectindent'
augroup detect_indent
    autocmd!
    autocmd BufReadPost * :DetectIndent
augroup end

" Auto commenting
Plug 'tpope/vim-commentary'

" Fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden --literal', <bang>0) 

" Icons for NERDTree
Plug 'ryanoasis/vim-devicons'

" Airline status line
Plug 'vim-airline/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Semantic highlighting for c/c++/objc
Plug 'jackguo380/vim-lsp-cxx-highlight'

" Easy color scheme switching
Plug 'xolox/vim-misc'
Plug 'xolox/vim-colorscheme-switcher'

" Auto reload files when they change
Plug 'djoshea/vim-autoread'

" Terminal management
Plug 'kassio/neoterm'

" coc intellisense engine
let g:coc_global_extensions = [
            \'coc-highlight', 'coc-tsserver', 'coc-html', 'coc-python', 'coc-css',
            \'coc-eslint', 'coc-prettier', 'coc-json', 'coc-java'
            \]
Plug 'neoclide/coc.nvim', {'branch': 'release'}
augroup custom_coc
    autocmd!
    autocmd FileType python let b:coc_root_patterns = ['.pylintrc', 'requirements.txt']
    autocmd FileType typescript.tsx let b:coc_root_patterns = ['package.json']
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup end

" Themes
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'rakr/vim-one'
Plug 'ayu-theme/ayu-vim'
Plug 'danilo-augusto/vim-afterglow'
Plug 'rainglow/vim'

call plug#end()

" Basics
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
set clipboard+=unnamedplus                  " Use the system clipboard by default for yank/delete/paste
set backspace=indent,eol,start              " Allow backspace everywhere

" Colors
let g:airline_theme='ayu_dark'
colorscheme ayu
let g:terminal_color_0  = '#2e3436'
let g:terminal_color_1  = '#cc0000'
let g:terminal_color_2  = '#4e9a06'
let g:terminal_color_3  = '#c4a000'
let g:terminal_color_4  = '#3465a4'
let g:terminal_color_5  = '#75507b'
let g:terminal_color_6  = '#0b939b'
let g:terminal_color_7  = '#d3d7cf'
let g:terminal_color_8  = '#555753'
let g:terminal_color_9  = '#ef2929'
let g:terminal_color_10 = '#8ae234'
let g:terminal_color_11 = '#fce94f'
let g:terminal_color_12 = '#729fcf'
let g:terminal_color_13 = '#ad7fa8'
let g:terminal_color_14 = '#00f5e9'
let g:terminal_color_15 = '#eeeeec'

""
"" Mappings
"" 

" Open folds with space
nnoremap <space> za

" Leader key
let mapleader=','

" Alternative ESC
inoremap <leader>, <ESC>
vnoremap <leader>, <ESC>

" Buffer stuff
nnoremap <C-q> :BD<cr>
nnoremap <C-s> :w<cr>

" Open NERDTree
nnoremap <leader>b :NERDTreeToggle<CR>
nnoremap <leader>B :NERDTreeFind<CR>

" Open init.vim
nnoremap <leader>v :execute "vsplit" g:vimrc_path<cr>

" Split the file vertically
nnoremap <leader>\ :vsplit<cr> :wincmd l<cr>

" Comment with <leader>/
nmap <leader>/ gcc
vmap <leader>/ gc

" Find in project
nmap <leader>f :Ag<space>

" Switch buffers
nmap <leader>[ :bprev<cr>
nmap <leader>] :bnext<cr>
nmap <a-pageup> :bprev<cr>
nmap <a-pagedown> :bnext<cr>

" Navigate quickfix
nmap <f9> :cn<cr>
nmap <F21> :cprev<cr>

" Run fzf for ctrl-p
nnoremap <C-p> :Files<CR>

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

" coc completion with ctrl-space
inoremap <silent><expr> <c-space> coc#refresh()

" coc confirm completion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" coc mappings
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
nmap <silent> <f8> <Plug>(coc-diagnostic-next)
nmap <silent> <f9> :cnext<cr>
nmap <silent> <F20> <Plug>(coc-diagnostic-prev)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> <f12> <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <f2> <Plug>(coc-rename)
nnoremap <silent> <leader>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader>s  :CocList -I symbols<cr>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Terminal
nnoremap <silent> <leader>t :vertical botright Ttoggle<cr><C-w>l
tnoremap <Esc> <C-\><C-n>
