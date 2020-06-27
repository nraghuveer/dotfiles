set shell=/bin/zsh
set cmdheight=3
let mapleader = "\<Space>"
filetype off
set nocompatible
set number
set relativenumber

" # ============ Plugins ===================
call plug#begin('~/.local/share/nvim/plugged')
Plug 'davidhalter/jedi-vim'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdcommenter'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'racer-rust/vim-racer'

" AUTO
Plug 'jiangmiao/auto-pairs'

" # UI - Customization
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" # Color Schemes
Plug 'morhetz/gruvbox'

call plug#end()

colorscheme gruvbox
set background=dark

" # ================= RUST - ALE =============================
let g:ale_fixers = {
      \   'rust': ['rustfmt'],
      \}

let g:ale_linters = {
      \'rust': ['rls'],
      \}

let g:ale_rust_rls_toolchain = 'nightly'

let g:ale_fix_on_save = 1
let g:airline#extensions#ale#enabled = 1
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)


" # ================ RUST - deoplete ==========================
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({'rust': ['ale', 'racer']})


" # ============== Key Mappings ( Don't Judge me ) ============

" =============================================================================
" # Keyboard shortcuts
" =============================================================================
" ; as :
" nnoremap ; :

" jj to Esc
imap jj <Esc>

" Open file tree
nnoremap <leader>ft :wincmd v<bar> :Ex <bar> :vertical resize 30<CR>
nnoremap <leader>v :wincmd v<CR>
nnoremap <leader>vv :wincmd s<CR>
" split navigations
nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>
" Switch between windows
nnoremap <leader>r :wincmd r<CR>
nnoremap <leader>wo :wincmd o<CR>
nnoremap <leader>fs :resize 100<CR>
nnoremap <leader>fsv :vertical resize 100<CR>

" Close the file with <leader>q
nnoremap <leader>q :q<CR>
nnoremap <leader>w :w<CR>
nnoremap <leader>wq :wq<CR>
nnoremap <leader>qq :q!<CR>

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Suspend with Ctrl+f
inoremap <C-f> :sus<cr>
vnoremap <C-f> :sus<cr>
nnoremap <C-f> :sus<cr>

" Jump to start and end of line using the home row keys
map H ^
map L $

" Neat X clipboard integration
" <leader>p will paste clipboard into buffer
" <leader>c will copy entire buffer into clipboard
noremap <leader>p :read !xsel --clipboard --output<cr>
noremap <leader>c :w !xsel -ib<cr><cr>

" fzf config
nnoremap <leader>ps :Rg<SPACE>
nnoremap <C-f> :GFiles<CR>
nnoremap <leader>f :Files<CR>

" Open new file adjacent to current file
nnoremap <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Map control + ; to put ; at end of line and go to below line
inoremap ;; <Esc>A;<Esc>o
nnoremap ;; A;<Esc>o

" Left and right can switch buffers
nnoremap <left> :bp<CR>
nnoremap <right> :bn<CR>

" Move by line
nnoremap j gj
nnoremap k gk

" Rust Specific
nnoremap rr :!cargo run<CR>
inoremap rr <Esc>:!cargo run<CR>

" ALE -> ee to open error window
inoremap ee :ALEDetail<CR>
nnoremap ee :ALEDetail<CR>

" Refresh the vim config
nnoremap <C-r> :so /home/raghuveer/.config/nvim/init.vim<CR>

" insert the brackers with bb in insert and normal mode
nnoremap <leader>b a{<CR><CR>}<Esc>ki<C-i>

