" to run, use
" sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
"""""""""""""""""
"GLOBAL SETTINGS"
"""""""""""""""""
" miscellaneous
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
" x delete without copy
nnoremap x "_d
nnoremap <S-x> "_d$
nnoremap xx "_dd
" don't show insert mode in status bar
set noshowmode

" show tab...
set list
set listchars=tab:>\ ,trail:-,eol:$
set ffs=unix
set encoding=utf-8
set fileencoding=utf-8
hi NonText ctermfg=0xFFFFFF

" use system clipboard
set clipboard+=unnamedplus


"""""""""
"VSCODE!"
"""""""""
if exists('g:vscode')
  " {{ PLUGINS
  call plug#begin('~/.vim/plugged')
    Plug 'tpope/vim-surround'
  call plug#end()
  " }}
  nnoremap <space> :call VSCodeNotify('whichkey.show')<CR>
	" Mappings "
	""""""""""""
	" comment
  map gc <C-/>
  " terminal
  command! Terminal call VSCodeNotify('workbench.action.terminal.toggleTerminal')
""""""""
"NATIVE"
""""""""
else
  """""""""
  "Plugins"
  """""""""
  call plug#begin('~/.vim/plugged')
    " function
    Plug 'preservim/nerdtree'
    Plug 'rbgrouleff/bclose.vim'
    Plug 'francoiscabrol/ranger.vim'
    " Plug 'wakatime/vim-wakatime'
    " input
    Plug 'tpope/vim-surround'
    Plug 'preservim/nerdcommenter'
    " Plug 'terryma/vim-multiple-cursors'
    " appearance
    Plug 'itchyny/lightline.vim'
    Plug 'drewtempelmeyer/palenight.vim'
    Plug 'Yggdroot/indentLine'
    " language support
    " Plug 'neovim/nvim-lspconfig'
  call plug#end()
  " lightline
  let g:lightline = {
        \ 'colorscheme': 'Tomorrow_Night_Eighties',
        \ }
  " nerdcommenter
  filetype plugin on
  nnoremap gcc V:call NERDComment('x', 'toggle')<CR>
  nnoremap <silent> gc} V}:call NERDComment('x', 'toggle')<CR>
  nnoremap <silent> gc{ V{:call NERDComment('x', 'toggle')<CR>
  " nerdtree
  nnoremap <leader>n :NERDTreeFocus<CR>
  nnoremap <C-t> :NERDTreeToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>
  " theme
  hi Normal ctermbg=NONE

  "MISC
  "Relative line number
  set number relativenumber
  "Mouse
  set mouse=a
  """"""""""
  "Language"
  """"""""""
  
  """"""""
  "Leader"
  """"""""
  let mapleader=" "
  " TAB "
  nnoremap <leader><TAB>l :tabnext <CR>
  nnoremap <leader><TAB>h :tabprevious <CR>
  nnoremap <leader><TAB>n :tabnew <CR>
  nnoremap <leader><TAB>d :tabclose <CR>
  nnoremap <leader><TAB>f :tabfind 
  " remap <Ctrl+w> "
  nnoremap <leader>w <C-w>
endif
