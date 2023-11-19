" Plugin Management


" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" File and folder management
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'dbakker/vim-projectroot'
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews

" Snippets
Plug 'honza/vim-snippets'
Plug 'natebosch/dartlang-snippets'
Plug 'grvcoelho/vim-javascript-snippets'
Plug 'mlaursen/vim-react-snippets'

" Language support
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Dart
Plug 'dart-lang/dart-vim-plugin'

" Javascript
Plug 'pangloss/vim-javascript'

" HTML
Plug 'gregsexton/MatchTag'

" Git
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'

" Enhancement

Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'metakirby5/codi.vim'
Plug 'tpope/vim-surround'

" Aesthetic
Plug 'ghifarit53/tokyonight-vim'
Plug 'cocopon/iceberg.vim'
Plug 'arcticicestudio/nord-vim'
Plug 'ryanoasis/vim-devicons'

call plug#end()

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set mouse=a " enable mouse scrolling
set clipboard+=unnamedplus " use system clipboard by default
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent " tab width
set incsearch ignorecase smartcase hlsearch " highlight text while searching
set fillchars+=vert:\▏ " requires a patched nerd font (try FiraCode)
set wrap breakindent " wrap long lines to the width set by tw
set encoding=utf-8 " text encoding
set number " enable numbers on the left
set relativenumber " current line is 0
set title " tab title as file name
set noshowmode " dont show current mode below statusline
set noshowcmd " to get rid of display of last command
set conceallevel=2 " set this so we wont break indentation plugin
set splitright " open vertical split to the right
set splitbelow " open horizontal split to the bottom
set tw=90 " auto wrap lines that are longer than that
set emoji " enable emojis
set history=1000 " history limit
set backspace=indent,eol,start " sensible backspacing
set undofile " enable persistent undo
set undodir=/tmp " undo temp file directory
set foldlevel=0 " open all folds by default
set inccommand=nosplit " visual feedback while substituting
set showtabline=0 " always show tabline
set grepprg=rg\ --vimgrep " use rg as default grepper
set lazyredraw " for better performance
set scrolloff=3 " more manageable scrolloff
set noswapfile " no swap files
let g:airline#extensions#tabline#enabled = 1 " shows the tabline
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'

" Required by coc.nvim
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" Aesthetic
set termguicolors
let g:tokyonight_style = 'storm' " available: night, storm
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
syntax on
hi NonText guifg=bg                                     " mask ~ on empty lines
hi clear CursorLineNr                                   " use the theme color for relative number
hi CursorLineNr gui=bold                                " make relative number bold
hi SpellBad guifg=#fdd835 gui=bold,undercurl            " misspelled words
"" transparent background
" hi Normal guibg=NONE ctermbg=NONE
" hi NonText ctermbg=none
" hi Normal guibg=NONE ctermbg=NONE

" coc multi cursor highlight color
hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

" Plugin Configurations

"" Disable built-in plugins/providers
let loaded_netrwPlugin = 1
let g:loaded_python_provider = 0
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
if glob('~/.python3') != ''
  let g:python3_host_prog = expand('~/.python3/bin/python')
else
  let g:python3_host_prog = systemlist('which python3')[0]
endif

"" Coc.nvim Configuration
" Navigate snippet placeholders using tab
  inoremap <silent><expr> <tab> coc#pum#visible() ? coc#pum#next(1) : "\<tab>"
  inoremap <silent><expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-yank',
            \'coc-diagnostic',
            \'coc-explorer',
            \'coc-word',
            \'coc-omni',
            \'coc-json',
            \'coc-java',
            \'coc-eslint',
            \'coc-emmet',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-snippets',
            \'coc-pyright',
            \'coc-prettier',
            \'coc-syntax',
            \'coc-marketplace',
            \'coc-highlight',
            \'coc-html-css-support',
            \'coc-flutter-tools']

" indentLine
let g:indentLine_char_list = ['▏', '¦', '┆', '┊']
let g:indentLine_setColors = 0
let g:indentLine_setConceal = 0                         " actually fix the annoying markdown links conversion

" ======================== Commands ============================= "{{{

au BufEnter * set fo-=c fo-=r fo-=o                     " stop auto commenting on new lines
au FileType help wincmd L                               " open help in vertical split
au BufWritePre * :%s/\s\+$//e                           " remove trailing whitespaces before saving
au CursorHold * silent call CocActionAsync('highlight') " highlight match on cursor hold

" enable spell only if file type is normal text

let spellable = ['markdown', 'gitcommit', 'txt', 'text', 'liquid', 'rst']
autocmd BufEnter * if index(spellable, &ft) < 0 | set nospell | else | set spell | endif


" coc completion popup
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Return to last edit position when opening files
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

" python renaming and folding
augroup python
    autocmd FileType python nnoremap <leader>rn :Semshi rename <CR>
    autocmd FileType python set foldmethod=syntax
    autocmd FileType python syn sync fromstart
    autocmd FileType python syn region foldImports start='"""' end='"""' fold keepend
augroup end

" format with available file format formatter
command! -nargs=0 Format :call CocAction('format')

" organize imports
command! -nargs=0 OR :call CocAction('runCommand', 'editor.action.organizeImport')


" Functions

" check if last inserted char is a backspace (used by coc pmenu)
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" show docs on things with e
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"}}}

" Store temporary files in .vim to keep the working directories clean.
set directory=~/.vim/swap
set undodir=~/.vim/undo

" ======================== Custom Mappings ====================== "{{{


"" the essentials
let mapleader=","
nnoremap ; :
nmap <leader>so :so ~/.config/nvim/init.vim<CR> :AirlineToggle<CR>:AirlineToggle<CR> " Refreshes airline
nmap <leader>q :bd <CR>
nmap <leader>w :w!<CR>
map <leader>i :edit ~/.config/nvim/init.vim<CR>
nmap <leader>e :ProjectRootExe CocCommand explorer<CR>
nmap <Tab> :bnext<CR>
nmap <S-Tab> :bprevious<CR>
noremap <leader>pi :PlugInstall<CR>
nmap s <Plug>(easymotion-s)
nmap <leader>ff :Files <CR>
nmap <leader>/ :Rg <CR>
let g:UltiSnipsExpandTrigger="<c-y>"
nmap <leader>c :Codi <CR>
nmap <leader>~ :below terminal <cr>
imap <leader>m <ESC>


  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<cr>"


" Flutter mappings

map <leader>fs :CocCommand flutter.run <CR>
map <leader>fr :CocCommand flutter.dev.hotRestart <CR>
map <leader>fq :CocCommand flutter.dev.quit <CR>

" new line in normal mode and back
map <Enter> o<ESC>
map <S-Enter> O<ESC>

" Opens a debug output below the buffer

nnoremap <leader>fd :below new output:///flutter-dev <CR>

" switch between splits using ctrl + {h,j,k,l}
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-n> <C-\><C-N><C-w>j
inoremap <C-e> <C-\><C-N><C-w>k
inoremap <C-i> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
noremap <C-n> <C-w>j
nnoremap <C-e> <C-w>k
nnoremap <C-i> <C-w>l

" disable hl with 2 esc
noremap <silent><esc> <esc>:noh<CR><esc>
" trim white spaces

nnoremap <F2> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

" markdown preview
au FileType markdown nmap <leader>m :MarkdownPreview<CR>

"" coc

" multi cursor shortcuts
nmap <silent> <C-a> <Plug>(coc-cursors-word)
xmap <silent> <C-a> <Plug>(coc-cursors-range)

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" other stuff
nmap <leader>rn <Plug>(coc-rename)

" jump stuff
nmap <leader>jd <Plug>(coc-definition)
nmap <leader>jy <Plug>(coc-type-definition)
nmap <leader>ji <Plug>(coc-implementation)
nmap <leader>jr <Plug>(coc-references)

" other coc actions
nnoremap <silent> e :call <SID>show_documentation()<CR>
nmap <leader>a <Plug>(coc-codeaction-line)
nmap <leader>. v<Plug>(coc-codeaction-selected)

" fugitive mappings
nmap <leader>gd :Gdiffsplit<CR>
nmap <leader>gb :Git blame<CR>
nmap <leader>gc :G add . <cr> :G commit -m ""
