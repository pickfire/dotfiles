" Author: Ivan Tham <pickfire@riseup.net> http://pickfire.tk/
" 注意：该作者支持使用中文

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ Plug-ins                                                                ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

" Install Plug -> faster
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─

call plug#begin('~/.config/nvim/plugged/')
Plug 'mattn/emmet-vim', { 'for': ['html', 'css'] }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }

Plug 'mattn/webapi-vim', { 'for': 'rust' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }

Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'posva/vim-vue', { 'for': 'vue' }

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
Plug 'w0rp/ale', { 'on': 'ALEEnable' }

Plug 'lilydjwg/colorizer'         " colorize #c6c6c6
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesEnable' }
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }

Plug 'jamessan/vim-gnupg'
Plug 'skydark/fcitx.vim', { 'on': 'Fcitx' }
Plug 'NLKNguyen/papercolor-theme' " inspired by google's material design
call plug#end()

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ Plug-ins Configuration                                                  ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

" vim-indent-guides
let g:indent_guides_auto_colors = 0

" vim-easy-align
vmap <Enter> <Plug>(EasyAlign)
nmap gs <Plug>(EasyAlign)

" colorizer
let g:colorizer_maxlines = 256

" emmet-vim
let g:user_emmet_install_global = 1

" vim-racer
au FileType rust nmap gd <Plug>(rust-def)

" Eye Candy
"colorscheme PaperColor
set background=dark
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" ale
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_completion_enabled = 1
let g:ale_fixers = {
\  'javascript': ['eslint'],
\  'rust': ['rustfmt'],
\}

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ General                                                                 ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

set shell=/bin/sh               " always in sh to prevent invalid argument

set spelllang=en_us
set thesaurus=/usr/share/mythes/mthesaur.txt
set dictionary=/usr/share/dict/cracklib-small " a minimal dictionary
set clipboard+=unnamed " easier copying

set cinoptions=(0,t0            " better c indentation
set grepprg=rg\ --vimgrep

" netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ Key Bindings                                                            ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

tnoremap <ESC><ESC> <C-\><C-n>

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ Multi-lingual                                                           ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

" plugins
au FileType c               RainbowParentheses
au FileType html            IndentGuidesEnable

" filetype
au BufRead,BufNewFile ~/usr/led/*.dat            setlocal ft=ledger
au FileType sh,xml,html,vue,*script,liquid,pug   setlocal ts=2 sts=2 sw=2 et
au FileType py,markdown                          setlocal ts=4 sts=4 sw=4 et
au FileType help                                 setlocal nospell
au FileType text,tex,markdown,asciidoc,html      setlocal spell
au FileType javascript                           setlocal cino=J1
if executable('ctags')
  au BufWritePost *.c,*.h silent! !ctags -R &
endif

" format tel on vcf
au BufRead *.vcf let @t=':s/[-+ ]//ge | s/:6\?0\(3\|1.\)/:+60 \1-/ | s/\d\{4\}$/ &//TELh'

" vim: ts=2 sts=2 sw=2 et sta
