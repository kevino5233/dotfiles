syntax on
if has("gui_running")
    colo desert
else
    colo torte
endif
set cmdheight=2
set hlsearch
set encoding=utf8
set ffs=unix,dos,mac
set guitablabel=%t
set nobackup
set nowb
set noswapfile
set cursorline
set backspace=indent,eol,start
hi CursorLine cterm=none ctermbg=darkgrey term=none
hi Todo term=standout ctermfg=1
hi Comment ctermfg=32

" ctags/cscope/grok
" set csprg=/bin/cscope

au GUIEnter * simalt ~x

" auto indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smarttab
set wrap

" formatting
set cc=80

"File ext. garbage
au BufRead,BufNewFile *.vue setfiletype html
au BufRead,BufNewFile *.pde setfiletype java 
au BufRead,BufNewFile *.fbs setfiletype c
au BufRead,BufNewFile BLAME setfiletype c

"Flatbuffers specific stuff that doesn't work anymore?
syn match cStructure display /table\>/
syn match cStructure display /root_type\>/

"lol
syn match cTodo display /@note\>/
syn match cTodo display /@AH[Hh]*\>/

set number

function! OpenFile(filename, destcommand)
    let linenum=0
    let fullname=split(a:filename, ":")
    if len(fullname) > 1
        let linenum=0+fullname[1]
    endif
    execute a:destcommand
    execute 'e!' fullname[0]
    cal cursor(linenum, 0)
endfunction

"navigation utilities
vnoremap // y/<C-R>"<CR>
vnoremap O y:call OpenFile("<C-R>"", "tabnew")<CR>zz
vnoremap oh y:e! <C-R>"<CR>
vnoremap os y:call OpenFile("<C-R>"", "vs")<CR>zz
nnoremap // /<C-R>"<CR>
nnoremap <silent> <C-l> :nohl<CR><C-l>
nmap <C-o> :call OpenFile(expand("<cWORD>"), "tabnew")<CR>zz
nmap ;; :w<CR>:sh<CR>
nmap :: :sh<CR>
nmap -- i--------------------------------------------------------------------------------<CR><C-[>
map , :<UP><CR>
map J <C-d>
map K <C-u>
map <C-j> <C-f>
map <C-k> <C-b>
map L $
map H ^
map qq i                                                                                <C-[>079ldw
imap jj <C-[>
nmap <C-c> :let @+=expand("<cword>")<CR>
vmap <C-c> "+y
imap <C-v> <C-r>+

"lets me be sloppy
command! -nargs=* E edit <args>
command! -nargs=* W write <args>
command! Q q
"Source vimrc shortcuts
nmap <space><space> :tabnew ~/.vimrc<CR>
command! Src source ~/.vimrc
command! SRc source ~/.vimrc
command! SRC source ~/.vimrc

" Search utils

function! DeepSearch(query)
    let filename=@%
    if (filename!="")
        vs
    endif
    ene!
    let cmd="read !search \"" . a:query . "\""
    execute cmd
endfunction

function! Search(query)
    let filename=@%
    if (filename!="")
        vs
    endif
    ene!
    let cmd="read !grep -d \"skip\" -e \"" . a:query . "\" * -nr"
    execute cmd
endfunction

command! -nargs=1 DSearch call DeepSearch(<f-args>)
command! -nargs=1 Dsearch call DeepSearch(<f-args>)
command! -nargs=1 DS call DeepSearch(<f-args>)
command! -nargs=1 Ds call DeepSearch(<f-args>)

command! -nargs=1 Search call Search(<f-args>)
command! -nargs=1 S call Search(<f-args>)
function! Execute(cmd)
    echo split(a:cmd, "")
endfunction

vnoremap X y:!<C-R>"<CR>
vnoremap R y:read !<C-R>"<CR>

"Working directory stuff
command! Swd cd %:p:h
command! SWd cd %:p:h
command! SWD cd %:p:h
command! Cfd echo expand('%:p:h')
command! CFd echo expand('%:p:h')
command! CFD echo expand('%:p:h')
command! PWD pwd
command! PWd pwd
command! Pwd pwd
command! Cpfn let @"=@%
command! CPfn let @"=@%
command! CPFn let @"=@%
function! Header()
    let class=split(@%, "\\.")
    if class[1]=="json"
        let class=split(@%, "_")
    endif
    let switchto=class[0] . ".h"
    execute 'e' switchto
endfunction
function! Cpp()
    let class=split(@%, "\\.")
    if class[1]=="json"
        let class=split(@%, "_")
    endif
    let switchto=class[0] . ".cpp"
    execute 'e' switchto
endfunction

command! Header call Header()
command! HEader call Header()
command! HEAder call Header()
command! Hdr call Header()
command! HDr call Header()
command! Headr call Header()
command! HEadr call Header()
command! Hedr call Header()
command! HEdr call Header()

command! Cpp call Cpp()
command! CPp call Cpp()
command! CPP call Cpp()

map ZZ :w!<CR>:q<CR>

"clipboard
command! Clip let @+=@"
command! CLip let @+=@"
command! CLip let @+=@"
command! CLIp let @+=@"

"quick gvim open
command! Gvim !gvim %
command! GVim !gvim %

"tabs
map fk :tabn<CR>
map f2k fk:tabn<CR>
map f3k f2k:tabn<CR>
map f4k f3k:tabn<CR>
map f5k f4k:tabn<CR>
map f6k f5k:tabn<CR>
map f7k f6k:tabn<CR>
map f8k f7k:tabn<CR>
map f9k f8k:tabn<CR>

map fj :tabp<CR>
map f2j fj:tabp<CR>
map f3j f2j:tabp<CR>
map f4j f3j:tabp<CR>
map f5j f4j:tabp<CR>
map f6j f5j:tabp<CR>
map f7j f6j:tabp<CR>
map f8j f7j:tabp<CR>
map f9j f8j:tabp<CR>

map fL :tablast<CR>:tabnew ./<CR>
map fl :tabnew ./<CR>

command! QW  tabclose!
command! Qw  tabclose!
command! Q   :qa

" mouse
set mouse=a
if has('mouse_sgr')
    set ttymouse=sgr
endif

function! NotSearch(search)
    let regex='^\(\(.*' . a:search . '\)\@!.\)*$'
    let @/=regex
    execute '/' . regex
endfunction

function! BuildCode()
    let filename=@%
    if (filename!="")
        vs
    endif
    ene!
    read !build
endfunction

command! -nargs=1 Ns call NotSearch(<f-args>)
command! -nargs=1 NS call NotSearch(<f-args>)

