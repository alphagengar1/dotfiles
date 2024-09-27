call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'
call plug#end()

set termguicolors
let g:gruvbox_contrast_dark = 'hard'
colorscheme gruvbox
nnoremap <silent> [oh :call gruvbox#hls_show()<CR>
nnoremap <silent> ]oh :call gruvbox#hls_hide()<CR>
nnoremap <silent> coh :call gruvbox#hls_toggle()<CR>

nnoremap * :let @/ = ""<CR>:call gruvbox#hls_show()<CR>*
nnoremap / :let @/ = ""<CR>:call gruvbox#hls_show()<CR>/
nnoremap ? :let @/ = ""<CR>:call gruvbox#hls_show()<CR>?
set background=dark

syntax on

set tabstop=4
set shiftwidth=4

set mouse=a
set number
set incsearch
set hlsearch
set autoindent
set smartindent
set cindent
set showmatch
set ruler
set relativenumber
set cursorline
set clipboard=unnamedplus

filetype plugin indent on

set backspace=indent,eol,start
set wrap
set ttimeout
set ttimeoutlen=1
set ttyfast
set lazyredraw
set encoding=utf-8

noremap y "+y
noremap Y "+Y
noremap yy "+yy

inoremap { {}<Left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {{ {
inoremap {} {}

inoremap [ []<Left>
inoremap [] []

inoremap ( ()<Left>
inoremap () ()

nnoremap c( di(
nnoremap c{ di{
nnoremap c[ di[
nnoremap <Esc> :nohlsearch<CR>
