" Plugins
call plug#begin()

  Plug 'nvim-lua/plenary.nvim' " required by other plugins

"  Plug 'dikiaap/minimalist'
"  Plug 'tomasiser/vim-code-dark'
"  Plug 'mhartington/oceanic-next'
"  Plug 'navarasu/onedark.nvim'
"  Plug 'projekt0n/github-nvim-theme'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' } " pretty

  Plug 'tpope/vim-fugitive' " git commands

  Plug 'neovim/nvim-lspconfig' " lsp stuff

  Plug 'christoomey/vim-tmux-navigator' " seamless tmux<->vim navigation

  Plug 'nvim-telescope/telescope.nvim' " fancy popups

  Plug 'antoinemadec/FixCursorHold.nvim' " decouple cursorhold from updatetime

  Plug 'nvim-lualine/lualine.nvim' " nice status bar

call plug#end()

" Source the matflo vimrc if it exists
if filereadable("~/.vimrc")
  source ~/.vimrc
endif

" Set colour scheme
if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable

colorscheme catppuccin-mocha

" Status bar
"set statusline +=%*\ %n\ %*                   "buffer number
"set statusline +=%*%{&ff}%*                   "file format
"set statusline +=%*%y%*                       "file type
"set statusline +=%*\ %<%F%*                   "full path
"set statusline +=%*%m%*                       "modified flag
"set statusline +=%*%=%{FugitiveStatusline()}  "Git branch
"set statusline +=%*%5l%*                      "current line
"set statusline +=%*/%L%*                      "total lines
"set statusline +=%*%4v\ %*                    "virtual column number
"
lua require('status-bar')

" LSP setup
lua require('lsp-config')

" Delay to trigger 'hover over' events (used for lsp diagnostic popups)
let g:cursorhold_updatetime = 100

" Disable mouse actions
set mouse=

" Telescope config
lua require('telescope-config')

" Clang mappings
nnoremap <C-W>cf :lua vim.lsp.buf.format()<CR>
nnoremap <C-W>cr :pyf /usr/local/opt/llvm/share/clang/clang-rename.py<CR>
nnoremap <C-W>f :lua require("lsp_fixcurrent")()<CR>
nnoremap <C-W>gh :ClangdSwitchSourceHeader<CR>

" Telescope mappings
nnoremap <C-W>t :b#<CR>
nnoremap <C-W>f :lua require('telescope.builtin').find_files({ cwd = '~' })<CR>
nnoremap <C-W>g :lua require('telescope.builtin').live_grep({ cwd = '~' })<CR>
nnoremap <C-W>] :lua require('telescope.builtin').grep_string({ cwd = '~' })<CR>
nnoremap <C-W>d :lua require('telescope.builtin').diagnostics({ bufnr = 0 })<CR>
nnoremap <C-W>rc :lua require('telescope.builtin').git_bcommits()<CR>
nnoremap <C-W>bl :lua require('telescope.builtin').buffers()<CR>

" Other mappings
nnoremap <C-W>rb :Git blame<CR>
nnoremap <C-W>bc :bdelete<CR>
nnoremap <C-W>bk :bwipeout<CR>
nnoremap <C-W>bn :bnext<CR>
nnoremap <C-W>bp :bprevious<CR>
nnoremap <C-W>be :edit 

"lua require('matflo')
