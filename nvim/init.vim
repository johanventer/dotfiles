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
  "set shortmess+=c                            " Avoid displaying insert completion messages
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
      return has_key(g:plugs, a:name) && 
                  \ isdirectory(g:plugs[a:name].dir) && 
                  \ stridx(&rtp, substitute(g:plugs[a:name].dir, '/$', '', '')) >= 0
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
      " Plug 'scrooloose/nerdtree'
      Plug 'kyazdani42/nvim-tree.lua'

      " FZF fuzzy finder
      Plug 'junegunn/fzf'
      Plug 'junegunn/fzf.vim'
      
      " Automatic commenting
      Plug 'tpope/vim-commentary'
      
      " Better terminal manangement
      Plug 'kassio/neoterm'
      
      " Quickly toggle quickfix
      Plug 'drmingdrmer/vim-toggle-quickfix'

      " Icons
      Plug 'kyazdani42/nvim-web-devicons' 
      
      " Status lines
      Plug 'hoob3rt/lualine.nvim' 

      " LSP completion + TreeSitter + other stuff
      Plug 'neovim/nvim-lspconfig'                " LSP configurations for neovim
      Plug 'kabouzeid/nvim-lspinstall'            " LSP install scripts
      Plug 'nvim-lua/lsp_extensions.nvim'         " LSP extensions (Rust inlays)
      Plug 'nvim-lua/completion-nvim'             " Completion engine that support neovim's LSP
      Plug 'kosayoda/nvim-lightbulb'              " Lightbulb code action
      Plug 'RishabhRD/popfix'
      Plug 'RishabhRD/nvim-lsputils'              " Better popup windows for LSP lists
      Plug 'folke/lsp-colors.nvim'                " For themes with missing LSP highlight groups
      Plug 'folke/trouble.nvim'                   " LSP diagnostic list
      Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

      " Prettier
      Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

      " Clang-format
      Plug 'rhysd/vim-clang-format'

      " Themes I like
      Plug 'folke/tokyonight.nvim'
      Plug 'jacoborus/tender.vim'
      Plug 'drewtempelmeyer/palenight.vim'      
    call plug#end()

    "-------------------------------------------------------------------------------------------------
    " Statusline and Colors
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("tokyonight.nvim")
      colorscheme tokyonight
    endif
    if PlugLoaded("lualine.nvim")
        lua <<EOF
          require'lualine'.setup {
            options = {
              icons_enabled = true,
              theme = 'tokyonight',
              component_separators = {'', ''},
              section_separators = {'', ''},
              disabled_filetypes = {}
            },
            sections = {
              lualine_a = {'mode'},
              lualine_b = {'branch'},
              lualine_c = {'filename'},
              lualine_x = {'encoding', 'fileformat', 'filetype'},
              lualine_y = {'progress'},
              lualine_z = {'location'}
            },
            inactive_sections = {
              lualine_a = {},
              lualine_b = {},
              lualine_c = {'filename'},
              lualine_x = {'location'},
              lualine_y = {},
              lualine_z = {}
            },
            tabline = {},
            extensions = {'fzf', 'nerdtree', 'quickfix'}
          }
EOF
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
    "
    "-------------------------------------------------------------------------------------------------
    " nvim-tree
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-tree.lua")
      " Toggle file browser
      nmap <leader>b :NvimTreeToggle<CR>
  
      " Find current file in file browser
      nmap <leader>B :NvimTreeFindFile<CR>
    endif
    
    "-------------------------------------------------------------------------------------------------
    " NERDTree - file browser
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nerdtree")
      echo "Hello"

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
    " LSP completion & diagnostics
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-lspconfig")
      lua <<EOF
        local on_attach = function(client, bufnr)
          local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
          local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

          buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

          -- Mappings.
          local opts = { noremap=true, silent=true }
          buf_set_keymap('n', '<f11>', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', 'gd',    '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
          buf_set_keymap('n', '<f12>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', '<c-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
          buf_set_keymap('n', 'K',     '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
          buf_set_keymap('n', 'gi',    '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
          buf_set_keymap('n', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
          buf_set_keymap('n', 'gr',    '<cmd>lua vim.lsp.buf.references()<CR>', opts)
          buf_set_keymap('n', 'g0',    '<cmd>lua vim.lsp.buf.document_symbol()<CR>', opts)
          buf_set_keymap('n', 'gW',    '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>', opts)
          buf_set_keymap('n', '<f2>',  '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
          buf_set_keymap('n', 'ga',    '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
          buf_set_keymap('n', 'g[',    '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
          buf_set_keymap('n', 'g]',    '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
          buf_set_keymap('n', '<f8>',  '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)

          -- Set some keybinds conditional on server capabilities
          if client.resolved_capabilities.document_formatting then
            buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

            -- Use the formatting of the LSP for some languages automatically
            if client.name == "rust" then
              vim.api.nvim_exec([[
                augroup Formatting
                  autocmd! * <buffer>
                  autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()
                augroup END
              ]], false)
            end

          elseif client.resolved_capabilities.document_range_formatting then
            buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
          end

         -- Show diagnostics on hover
          vim.api.nvim_exec([[
            augroup Diagnostics
              autocmd! * <buffer>
              autocmd CursorHold * lua vim.lsp.diagnostic.show_line_diagnostics()
            augroup END
          ]], false)

          -- Set autocommands conditional on server_capabilities
          if client.resolved_capabilities.document_highlight then
            vim.api.nvim_exec([[
              augroup lsp_document_highlight
                autocmd! * <buffer>
                autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
                autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
              augroup END
            ]], false)
          end

          require'completion'.on_attach()
        end

        local rust_settings = {
          ["rust-analyzer"] = { 
            checkOnSave = {
              command = "clippy"
            } 
          } 
        }

        local function setup_servers()
          require'lspinstall'.setup()
  
          local servers = require'lspinstall'.installed_servers()
  
          -- Add manually installed servers here, i.e:
          -- table.insert(servers, "tsserver")
  
          for _, server in pairs(servers) do
            local config = {
              on_attach = on_attach
            }

            if server == "rust" then
              config.settings = rust_settings
            end

            require'lspconfig'[server].setup(config)
          end
        end

        setup_servers()

        vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics, {
            underline = true,
            signs = true,
            virtual_text = false,
            update_in_insert = false,
          }
        )

        vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
        vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
        vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
        vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})
EOF

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
    endif
    
    "-------------------------------------------------------------------------------------------------
    " lsp_extensions
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("lsp_extensions.nvim")
      augroup InlayHints
        autocmd!
        autocmd CursorMoved,InsertLeave,BufEnter,BufWinEnter,TabEnter,BufWritePost *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = ' » ', highlight = "Comment", aligned = false, enabled = {"ChainingHint", "ParameterHint", "TypeHint"} }
      augroup END
    endif

    "-------------------------------------------------------------------------------------------------
    " lsputils
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-lsputils")
      lua <<EOF
        vim.lsp.handlers['textDocument/codeAction'] = require'lsputil.codeAction'.code_action_handler
        vim.lsp.handlers['textDocument/references'] = require'lsputil.locations'.references_handler
        vim.lsp.handlers['textDocument/definition'] = require'lsputil.locations'.definition_handler
        vim.lsp.handlers['textDocument/declaration'] = require'lsputil.locations'.declaration_handler
        vim.lsp.handlers['textDocument/typeDefinition'] = require'lsputil.locations'.typeDefinition_handler
        vim.lsp.handlers['textDocument/implementation'] = require'lsputil.locations'.implementation_handler
        vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
        vim.lsp.handlers['workspace/symbol'] = require'lsputil.symbols'.workspace_handler
EOF
    endif

    "-------------------------------------------------------------------------------------------------
    " lsptrouble
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("trouble.nvim")
      lua <<EOF
        require("trouble").setup {
          -- your configuration comes here
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
       }

EOF
      nnoremap <leader>x  <cmd>TroubleToggle<cr>
      nnoremap <leader>xw <cmd>TroubleToggle lsp_workspace_diagnostics<cr>
      nnoremap <leader>xd <cmd>TroubleToggle lsp_document_diagnostics<cr>
      nnoremap <leader>xq <cmd>TroubleToggle quickfix<cr>
      nnoremap <leader>xl <cmd>TroubleToggle loclist<cr>
      nnoremap gR <cmd>TroubleToggle lsp_references<cr>
    endif
    
    "-------------------------------------------------------------------------------------------------
    " treesitter
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-treesitter")
      lua <<EOF
        require'nvim-treesitter.configs'.setup {
          ensure_installed = "maintained",
          highlight = {
            enable = true
          },
        }
EOF
    endif

    "-------------------------------------------------------------------------------------------------
    " nvim-lightbulb
    "-------------------------------------------------------------------------------------------------
    if PlugLoaded("nvim-lightbulb")
      lua <<EOF
        vim.fn.sign_define("LightBulbSign", {text = " ", numhl = "LspDiagnosticsDefaultInformation"})
EOF
      autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb{ sign = { priority = 1 } }
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
    if has("unix") && filereadable("/proc/version")
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
