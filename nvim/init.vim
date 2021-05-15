" Disable plugins, leaving only basic nvim configuration
" let g:no_plugins = 1

" If using the neovim integration in VS Code, do not load any of our config
if !exists('g:vscode')
  " -------------------------------------------------------------------------------------------------
  " Basics
  " -------------------------------------------------------------------------------------------------
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
  set clipboard+=unnamed,unnamedplus          " Use the system clipboard by default for yank/delete/paste
  set shortmess+=c                            " Avoid displaying insert completion messages
  set completeopt=noinsert,menuone            " Sets the behaviour of the autocompletion menu
 
  " Source config when saved
  "
  if has("autocmd")
    au! BufWritePost .vimrc,init.vim nested so $MYVIMRC
  en

  " Copy into X11 PRIMARY when releasing the mousebutton in visual mode (for copy on select)
  " and stay in visual mode
  " :vnoremap <LeftRelease> "*y<LeftRelease>gv

  " Allow local rc files
  set exrc
  set secure
 
  " -------------------------------------------------------------------------------------------------
  " Key Mappings
  " -------------------------------------------------------------------------------------------------
  let mapleader=' '                        

  " Edit vimrc
  nmap <leader>v :execute "vsplit" $MYVIMRC<cr> 

  " Split vertically
  nmap <leader>\ :vsplit<cr> :wincmd l<cr>

  " Split horizontally
  nmap <leader>% :split<cr> :wincmd j<cr>

  " Delete buffer
  nmap <C-q>     :BD<cr> 

  " Write
  nmap <C-s>     :w<cr>

  " Navigate quicklist
  nmap <f9>         :cn<cr>
  nmap <leader><f9> :cprev<cr>

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

  " -------------------------------------------------------------------------------------------------
  " Plugins
  " -------------------------------------------------------------------------------------------------
  if !exists('g:no_plugins')
    function! PlugLoaded(name)
      let key = has_key(g:plugs, a:name)
      let dir = isdirectory(g:plugs[a:name].dir)
      let rtp = stridx(&rtp, substitute(g:plugs[a:name].dir, '/$', '', '')) >= 0
      return (key && dir && rtp)
    endfunction

    call plug#begin('~/.local/share/nvim/plugged')
      " Switch local working directory to project root
      Plug 'airblade/vim-rooter'                    
      
      " Better buffer management (don't close windows when deleting buffers)
      Plug 'qpkorr/vim-bufkill'               

      " Indent and tab/space detection
      Plug 'roryokane/detectindent'

      " Auto reload files when they change
      Plug 'djoshea/vim-autoread'                     
      
      " NERDTree file browser
      Plug 'scrooloose/nerdtree'

      " FZF fuzzy finder
      Plug 'junegunn/fzf'
      Plug 'junegunn/fzf.vim'
      
      " Automatic commenting
      Plug 'tpope/vim-commentary'
      
      " Better terminal manangement
      Plug 'kassio/neoterm'
      
      " Quickly toggle quickfix
      Plug 'drmingdrmer/vim-toggle-quickfix'

      " LSP completion
      Plug 'neovim/nvim-lspconfig'                " LSP configurations for neovim
      Plug 'nvim-lua/completion-nvim'             " Completion engine that support neovim's LSP
      Plug 'kosayoda/nvim-lightbulb'              " Lightbulb code action

      " Rust  
      Plug 'rust-lang/rust.vim'
      Plug 'cespare/vim-toml'

      " Prettier
      Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

      " Clang-format
      Plug 'rhysd/vim-clang-format'

      " Better Java syntax highlighting
      Plug 'uiiaoo/java-syntax.vim'                   

      " Apex ftplugin and syntax highlighting
      Plug 'ejholmes/vim-forcedotcom'

      " Status lines and themes
      Plug 'itchyny/lightline.vim'                " Status line
      Plug 'jacoborus/tender.vim'
      Plug 'drewtempelmeyer/palenight.vim'      
    call plug#end()

    "-------------------------------------------------------------------------------------------------
    " Statusline and Colors
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("tender.vim")
        colorscheme palenight
    endif
    
    "-------------------------------------------------------------------------------------------------
    " vim-rooter
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("vim-rooter")
      let g:rooter_patterns = ['package.json', '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', '.project']
    endif

    "-------------------------------------------------------------------------------------------------
    " Detect indents and tab/spaces
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("detectindent")
      augroup DetectIndent
        autocmd!
        autocmd BufReadPost *  DetectIndent
      augroup END
    endif
    
    "-------------------------------------------------------------------------------------------------
    " NERDTree - file browser
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nerdtree")
      " Show hidden files in nerdtree
      let NERDTreeShowHidden=1
      let NERDTreeMinimalUI = 1

      " Toggle file browser
      nmap <leader>b :NERDTreeToggle<CR>
  
      " Find current file in file browser
      nmap <leader>B :NERDTreeFind<CR>
    endif

    "-------------------------------------------------------------------------------------------------
    " FZF - fuzzy finder
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("fzf.vim")
      let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }

      " Ctrl-p fuzzy file finder
      nmap <C-p> :Files<CR>

      " Buffers
      nmap <f1> :Buffers<cr>
  
      " Find in project
      nmap <leader>f :Rg<space>
      nmap <leader>F :Rg <C-R><C-W><CR>
    endif

    "-------------------------------------------------------------------------------------------------
    " vim-commentary - automatic commenting
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("vim-commentary")
      " Auto commenting
      nmap <leader>/ gcc
      vmap <leader>/ gc

      autocmd FileType c,cpp,java setlocal commentstring=//\ %s
    endif

    "-------------------------------------------------------------------------------------------------
    " Neoterm - better terminal management
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("neoterm")
      let g:neoterm_default_mod = "botright"
      let g:neoterm_size = 15
      let g:neoterm_autoscroll = 1
      let g:neoterm_autoinsert = 1

      nmap <silent> <leader>t :botright Ttoggle<cr>
      tmap <Esc> <C-\><C-n>
      nmap ` :Ttoggle<cr>
      autocmd BufEnter term://* startinsert
      autocmd BufLeave term://* stopinsert
    endif
    
    "-------------------------------------------------------------------------------------------------
    " Toggle quickfix
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("vim-toggle-quickfix")
      nmap <bs> <Plug>window:quickfix:loop
    endif

    "-------------------------------------------------------------------------------------------------
    " Rust (using LSP for completion/diagnostics, but this has an up to date
    " filetype plugin.
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("rust.vim")
      let g:rustfmt_autosave = 1                  " Format Rust files on save
    endif

    "-------------------------------------------------------------------------------------------------
    " Prettier
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("vim-prettier")
      let g:prettier#autoformat = 0
      let g:prettier#autoformat_require_pragma = 0
      let g:prettier#quickfix_enabled = 1
      let g:prettier#config#print_width = '80'
    endif
    
    "-------------------------------------------------------------------------------------------------
    " Clang-format
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("vim-clang-format")
      let g:clang_format#detect_style_file = 1
      let g:clang_format#auto_format = 1
    endif
    
    "-------------------------------------------------------------------------------------------------
    " Better Java syntax highlighting
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("java-syntax.vim")
      " Disable highlighting variables in Java
      highlight link JavaIdentifier NONE
    endif
    
    "-------------------------------------------------------------------------------------------------
    " LSP completion & diagnostics
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-lspconfig")
      lua <<EOF
        local util = require 'lspconfig/util'
        local nvim_command = vim.api.nvim_command
          
        local on_attach_vim = function()
          require'completion'.on_attach()
        end
          
        require'lspconfig'.tsserver.setup{on_attach=on_attach_vim}
        require'lspconfig'.rust_analyzer.setup{on_attach=on_attach_vim}
        -- require'lspconfig'.apex_jorje.setup{on_attach=on_attach_vim}
        require'lspconfig'.jdtls.setup{on_attach = on_attach_vim}
        require'lspconfig'.ccls.setup{on_attach=on_attach_vim}

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            update_in_insert = false,
         }
       )
EOF

        " Show diagnostics on hover
        augroup Diagnostics
          autocmd!
          autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
        augroup END

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
        nnoremap <silent> <f12> <cmd>lua vim.lsp.buf.declaration()<CR>
        nnoremap <silent> <f12> <cmd>lua vim.lsp.buf.definition()<CR>
        nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
        nnoremap <silent> gi    <cmd>lua vim.lsp.buf.implementation()<CR>
        nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
        nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
        nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
        nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
        nnoremap          <f2>  <cmd>lua vim.lsp.buf.rename()<CR>
        nnoremap <silent> <f8>  <cmd>lua vim.lsp.diagnostic.goto_next()<CR>
    endif

    "-------------------------------------------------------------------------------------------------
    " nvim-lightbulb
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-lightbulb")
      autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()
    endif
    
    "-------------------------------------------------------------------------------------------------
    " gnvim - nvim GUI
    "-------------------------------------------------------------------------------------------------
    if exists('g:gnvim')
      set guifont=Cousine\ Nerd\ Font\ Regular:h10
      let g:fzf_layout = { 'down': '~40%' }
    endif

  endif
 
  "-------------------------------------------------------------------------------------------------
  " WSL specific stuff
  "-------------------------------------------------------------------------------------------------
  function! IsWSL()
    if has("unix")
      let lines = readfile("/proc/version")
      if lines[0] =~ "Microsoft"
        return 1
      endif
    endif
    return 0
  endfunction
  
  if IsWSL()
    let g:clipboard = {
              \   'name': 'win32yank-wsl',
              \   'copy': {
              \      '+': 'win32yank.exe -i --crlf',
              \      '*': 'win32yank.exe -i --crlf',
              \    },
              \   'paste': {
              \      '+': 'win32yank.exe -o --lf',
              \      '*': 'win32yank.exe -o --lf',
              \   },
              \   'cache_enabled': 0,
              \ }
  endif
endif
