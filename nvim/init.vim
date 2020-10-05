if !exists('g:vscode')

" Plugins
" -------------------------------------------------------------------------------------------------

call plug#begin('~/.local/share/nvim/plugged')
  Plug 'neovim/nvim-lspconfig'                    " LSP configurations for neovim
  Plug 'nvim-lua/completion-nvim'                 " Completion engine that support neovim's LSP
  Plug 'nvim-lua/diagnostic-nvim'                 " Diagnostics with neovim's LSP
  Plug 'prettier/vim-prettier',                   " Prettier :)
    \ { 'do': 'yarn install' }
  Plug 'airblade/vim-rooter'                      " Switch local working directory to project root
  Plug 'scrooloose/nerdtree'                      " File browser
  Plug 'qpkorr/vim-bufkill'                       " Better buffer management (don't close windows when deleting buffers)
  Plug 'sheerun/vim-polyglot'                     " Language packs
  Plug 'ciaranm/detectindent'                     " Detect indents
  Plug 'tpope/vim-commentary'                     " Auto commenting
"  Plug 'tpope/vim-fugitive'                       " Git
"  Plug 'airblade/vim-gitgutter'                   " Git gutter
  Plug 'junegunn/fzf'                             " Fuzzy finder
  Plug 'junegunn/fzf.vim'                         " Fuzzy finder vim helpers
  Plug 'ryanoasis/vim-devicons'                   " Icons for NERDTree
  Plug 'vim-airline/vim-airline'                  " Airline status line
  "Plug 'itchyny/lightline.vim'                    " Status line
  Plug 'jackguo380/vim-lsp-cxx-highlight'         " Semantic highlighting for c/c++/objc
  Plug 'djoshea/vim-autoread'                     " Auto reload files when they change
  Plug 'kassio/neoterm'                           " Terminal management
  Plug 'edkolev/tmuxline.vim'                     " tmux airline
  Plug 'uiiaoo/java-syntax.vim'                   " Better Java syntax highlighting
  Plug 'Yggdroot/indentLine'                      " Show line indents
  Plug 'drmingdrmer/vim-toggle-quickfix'          " Quickly toggle quickfix
  "Plug 'neoclide/coc.nvim', {'branch': 'release'} " coc intellisense engine
  
  " Themes
  "Plug 'vim-airline/vim-airline-themes'
  "Plug 'morhetz/gruvbox'
  "Plug 'rakr/vim-one'
  Plug 'ayu-theme/ayu-vim'
  "Plug 'dempfi/vim-airline-neka'
  "Plug 'danilo-augusto/vim-afterglow'
  "Plug 'rainglow/vim'
  "Plug 'connorholyday/vim-snazzy'
  "Plug 'sonph/onehalf', {'rtp': 'vim/'}
  Plug 'jacoborus/tender.vim'
call plug#end()

" -------------------------------------------------------------------------------------------------
"  LSP/Completion Configuration
" -------------------------------------------------------------------------------------------------

lua <<EOF
local nvim_command = vim.api.nvim_command

local on_attach_vim = function()
  require'completion'.on_attach()
  require'diagnostic'.on_attach()
  nvim_command('autocmd CursorHold <buffer> lua vim.lsp.util.show_line_diagnostics()')
end

require'nvim_lsp'.tsserver.setup{on_attach=on_attach_vim}
require'nvim_lsp'.jdtls.setup{on_attach=on_attach_vim}
EOF

set shortmess+=c                            " Avoid displaying insert completion messages
set completeopt=noinsert,menuone            " Sets the behaviour of the autocompletion menu

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Use TAB as a completion trigger key
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()

" LSP mappings
" nnoremap <silent> <f12> <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <f12> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap          <f2>  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <f8>  :NextDiagnosticCycle<CR>
nnoremap <silent> <leader><f8>  :PrevDiagnosticCycle<CR>

" Why?
"au BufNewFile,BufRead *.ts setlocal filetype=typescript
"au BufNewFile,BufRead *.tsx setlocal filetype=typescript.tsx

" -------------------------------------------------------------------------------------------------
" Plugin Configuration
" -------------------------------------------------------------------------------------------------

" Prettier
let g:prettier#config#print_width = '80'
let g:prettier#config#tab_width = '2'
let g:prettier#config#use_tabs = 'false'
let g:prettier#autoformat = 0
augroup prettier
  autocmd!
  autocmd BufWritePre * PrettierAsync
augroup end

" Disable highlighting variables in Java
highlight link JavaIdentifier NONE

" vim-commentary
autocmd FileType rust setlocal commentstring=//\ %s
autocmd FileType javascript setlocal commentstring=//\ %s
autocmd FileType typescript setlocal commentstring=//\ %s
autocmd FileType javascriptreact setlocal commentstring=//\ %s
autocmd FileType typescriptreact setlocal commentstring=//\ %s
autocmd FileType javascript.tsx setlocal commentstring=//\ %s
autocmd FileType typescript.tsx setlocal commentstring=//\ %s

" neoterm
let g:neoterm_default_mod = "botright"
let g:neoterm_size = 15
let g:neoterm_autoscroll = 1
let g:neoterm_autoinsert = 1

" NERDTree
let NERDTreeShowHidden=1                      " Show hidden files in nerdtree
let NERDTreeMinimalUI = 1

" DetectIndent
augroup detect_indent
    autocmd!
    autocmd BufReadPost * DetectIndent
augroup end

" FZF
command! -bang -nargs=* Ag call fzf#vim#ag(<q-args>, '--hidden --literal --ignore node_modules --ignore .git --ignore target', <bang>0) 
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#branch#enabled=1

" Indentline
let g:indentLine_char = '▏'

" -------------------------------------------------------------------------------------------------
" gnvim
" -------------------------------------------------------------------------------------------------

set guifont=Cousine\ Nerd\ Font\ Regular:h10

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
let g:airline_theme = 'tender'
"let g:lightline = { 'colorscheme': 'wombat' }
colorscheme tender

" -------------------------------------------------------------------------------------------------
" Key Mappings
" -------------------------------------------------------------------------------------------------

let mapleader=' '                        

" Edit vimrc
nmap <leader>v :execute "vsplit" g:vimrc_path<cr> 

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
nmap <leader>F :Ag <C-R><C-W><CR>

" Auto commenting
nmap <leader>/ gcc
vmap <leader>/ gc

" Delete buffer
nmap <C-q>     :BD<cr> 

" Write
nmap <C-s>     :w<cr>

" Navigate quicklist
nmap <bs>         <Plug>window:quickfix:loop
nmap <f9>         :cn<cr>
nmap <leader><f9> :cprev<cr>

" Ctrl-p fuzzy file finder
nmap <C-p>     :GFiles<CR>
nmap <C-f>     :Files<CR>

" Window navigation
nnoremap <C-S-Left>   <C-w>h
nnoremap <C-S-Right>  <C-w>l
nnoremap <C-S-Up>     <C-w>k
nnoremap <C-S-Down>   <C-w>j
inoremap <C-S-Left>   <C-\><C-N><C-w>h
inoremap <C-S-Right>  <C-\><C-N><C-w>l
inoremap <C-S-Up>     <C-\><C-N><C-w>k
inoremap <C-S-Down>   <C-\><C-N><C-w>j
tnoremap <C-S-Left>   <C-\><C-N><C-w>h
tnoremap <C-S-Right>  <C-\><C-N><C-w>l
tnoremap <C-S-Up>     <C-\><C-N><C-w>k
tnoremap <C-S-Down>   <C-\><C-N><C-w>j

" Terminal
nmap <silent> <leader>t :botright Ttoggle<cr>
tmap <Esc> <C-\><C-n>
nmap ` :Ttoggle<cr>
autocmd BufEnter term://* startinsert
autocmd BufLeave term://* stopinsert

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

" Allow local rc files
set exrc
set secure

endif
