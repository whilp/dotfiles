filetype on
filetype plugin indent on
syntax on

colorscheme base16-solarized-dark
let g:airline_theme="base16_solarized"

set autoindent
set autoread
set conceallevel=2
set backspace=indent,eol,start
set background=dark
set expandtab
set formatoptions=qrn1c
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set hidden
set ignorecase
set incsearch
set nohlsearch
set nomodeline
set nowrap
set scrollback=-1
set scrolloff=3
set sidescrolloff=5
set signcolumn=no
set shell=/bin/bash
set shiftwidth=4
set showmatch
set noshowcmd
set showtabline=0
set smartcase
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set textwidth=79
set visualbell
set wildmenu
set wildmode=list:full
set completeopt-=preview
set completeopt+=longest,menuone,noselect
set shortmess+=c
set belloff+=ctrlg
let mapleader = " "

inoremap jk <ESC>
nnoremap <Leader>g :Rg<CR>
nnoremap <Leader>f :FZF<CR>
nnoremap <Leader>q :bp\|bd #<CR>
nnoremap <Leader>v :Gstatus<CR>
nnoremap <silent> [f :lprevious<CR>
nnoremap <silent> ]f :lnext<CR>
tnoremap jk <C-\><C-n>

autocmd BufRead,BufNewFile *.bzl setfiletype bzl
autocmd BufRead,BufNewFile BUILD setfiletype bzl
autocmd BufRead,BufNewFile *.BUILD setfiletype bzl
autocmd BufRead,BufNewFile BUILD.* setfiletype bzl
autocmd BufRead,BufNewFile WORKSPACE setfiletype bzl

command! -bar -nargs=1 Gbranch :Git checkout -q -B <q-args>
command! -bar -nargs=1 Gco :Git checkout -q <q-args>

" https://github.com/junegunn/fzf.vim#advanced-customization
command! -bang -nargs=* Rg
            \ call fzf#vim#grep(
            \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 0,
            \   {}, <bang>0)
let $FZF_DEFAULT_COMMAND = 'rg --hidden --files --smart-case'

" https://github.com/nicodebo/base16-fzf/blob/master/bash/base16-solarized-dark.config
let $FZF_DEFAULT_OPTS = '--color=bg+:#073642,bg:#002b36,spinner:#2aa198,hl:#268bd2
            \ --color=fg:#839496,header:#268bd2,info:#b58900,pointer:#2aa198
            \ --color=marker:#2aa198,fg+:#eee8d5,prompt:#b58900,hl+:#268bd2'

let $BAZEL_PYTHON = "/usr/bin/python2.7"

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#delayed_completion = 1
let g:signify_disable_by_default = 1
let g:signify_vcs_list = ["git"]

:highlight! link QuickFixLine Normal

vmap <C-c> y:call osc52#SendViaOSC52(getreg('"'))<cr>
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y

let g:clipboard = {
      \   'name': 'osc52',
      \   'copy': {
      \      '+': 'osc52',
      \      '*': 'osc52',
      \    },
      \   'paste': {
      \      '+': 'osc52',
      \      '*': 'osc52',
      \    },
      \   'cache_enabled': 1,
      \ }

let g:ale_fix_on_save = 1

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

let g:vim_markdown_no_extensions_in_markdown = 1

" TODO: tab completion doesn't seem to care about this.
let &cdpath = join(["", ""] + systemlist("~/bin/cdpath"), ",")

packloadall
sil helptags ALL
