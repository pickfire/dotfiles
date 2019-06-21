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
Plug 'mattn/emmet-vim', { 'for': ['html', 'css', 'vue'] }
Plug 'othree/html5.vim', { 'for': 'html' }
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
Plug 'elzr/vim-json', { 'for': 'json' }

Plug 'mattn/webapi-vim', { 'for': 'rust' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }

Plug 'lervag/vimtex', { 'for': ['tex', 'bib'] }
Plug 'dag/vim-fish', { 'for': 'fish' }
Plug 'cespare/vim-toml', { 'for': 'toml' }
Plug 'ledger/vim-ledger', { 'for': 'ledger' }
Plug 'posva/vim-vue', { 'for': 'vue' }

Plug 'junegunn/vim-easy-align', { 'on': ['<Plug>(EasyAlign)', 'EasyAlign'] }
"Plug 'w0rp/ale'

Plug 'lilydjwg/colorizer'         " colorize #c6c6c6
Plug 'nathanaelkane/vim-indent-guides', { 'on': 'IndentGuidesEnable' }
Plug 'junegunn/rainbow_parentheses.vim', { 'on': 'RainbowParentheses' }

Plug 'lotabout/skim', { 'do': './install' }
Plug 'lotabout/skim.vim'

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
let g:racer_experimental_completer = 1
"au FileType rust nmap gd         <Plug>(rust-def)
"au FileType rust nmap <c-w><c-d> <Plug>(rust-def-split)
"au FileType rust nmap <c-w>d     <Plug>(rust-def-split)
"au FileType rust nmap <leader>gd <Plug>(rust-doc)

" Eye Candy
"colorscheme PaperColor
"set background=light
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
  \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
  \,sm:block-blinkwait175-blinkoff150-blinkon175

" ale
let g:ale_lint_delay = 500
let g:ale_lint_on_text_changed = 'normal'
let g:ale_linters = { 'tex': ['chktex'] }
let g:ale_fixers = {
\  'javascript': ['eslint', 'importjs'],
\  'rust': ['rustfmt'],
\  '*': ['remove_trailing_lines', 'trim_whitespace'],
\}
let g:ale_java_javac_classpath = '/home/ivan/usr/uni/oodj/ass/build/classes'

" vimtex
let g:vimtex_view_automatic = 0
let g:vimtex_view_method = 'zathura'

" skim.vim
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)
nnoremap <M-p> :Files<cr>
nnoremap <M-u> :Rg<cr>

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ General                                                                 ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

set shell=/bin/sh               " always in sh to prevent invalid argument

set spelllang=en_us
set thesaurus=/usr/share/mythes/mthesaur.txt
set dictionary=/usr/share/dict/cracklib-small " a minimal dictionary

set cinoptions=(0,t0            " better c indentation
set list                        " clear whitespace
set grepprg=rg\ --vimgrep

" netrw
let g:netrw_altv=1
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_list_hide=netrw_gitignore#Hide()

call matchadd('ColorColumn', '\%81v', 100) " colorcolumn only on wide lines

" highlight matches when jumping to next
nnoremap <silent> n  n:call HLNext(0.4)<cr>
nnoremap <silent> N  N:call HLNext(0.4)<cr>

function! HLNext (blinktime)
  highlight DefaultOnRed ctermbg=red
  let [bufnum, lnum, col, off] = getpos('.')
  let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
  let target_pat = '\c\%#\%('.@/.'\)'
  let ring = matchadd('DefaultOnRed', target_pat, 101)
  redraw
  exec 'sleep ' . float2nr(a:blinktime * 10) . 'm'
  call matchdelete(ring)
  redraw
endfunction

" javascript
let g:javascript_plugin_jsdoc = 1

" tex
let b:tex_stylish = 1
let g:tex_flavor = 'latex'

" jedi-vim
let g:jedi#popup_on_dot = 0
let g:jedi#popup_on_first = 0
let g:jedi#show_call_signatures = 0

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ Key Bindings                                                            ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

tnoremap <ESC><ESC> <C-\><C-n>

" ┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
" ┃ Multi-lingual                                                           ┃
" ┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

" syntax
au BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css
au FileType vue syntax sync fromstart

" plugin
au FileType c    RainbowParentheses
au FileType html IndentGuidesEnable

" tags
au BufRead *.rs :setlocal tags=./rusty-tags.vi;/,$RUST_SRC_PATH/rusty-tags.vi
au BufWritePost *.rs :silent! exec "!rusty-tags vi --quiet --start-dir=" . expand('%:p:h') . "&" | redraw!

" filetype
au BufRead,BufNewFile ~/usr/led/*.dat               setlocal ft=ledger
au FileType sh,*ml,*ss,vue,*script,liquid,pug,json  setlocal ts=2 sts=2 sw=2 et
au FileType py,markdown                             setlocal ts=4 sts=4 sw=4 et
au FileType help                                    setlocal nospell
au FileType text,tex,markdown,asciidoc,html         setlocal spell
au FileType javascript,vue                          setlocal cino=J1
au FileType java                                    setlocal makeprg=ant\ compile
au FileType tex                                     setlocal cole=2
if executable('ctags')
  au BufWritePost *.c,*.h silent! !ctags -R &
endif

" format tel on vcf
au BufRead *.vcf let @t=':s/[-+ ]//ge | s/:6\?0\(3\|1.\)/:+60 \1-/ | s/\d\{4\}$/ &//TELh'

" vim: ts=2 sts=2 sw=2 et sta
