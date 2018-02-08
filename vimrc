syntax on
colo torte
set cmdheight=2
set hlsearch
set encoding=utf8
set ffs=unix,dos,mac
set guitablabel=%t
set nobackup
set nowb
set noswapfile
set cursorline
hi CursorLine cterm=none ctermbg=darkgrey term=none
hi Todo term=standout ctermfg=1
hi Comment ctermfg=32
"hi Constant ctermfg=14
"hi Type ctermfg=10

" auto indent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set smarttab
set wrap

"File ext. garbage
au BufRead,BufNewFile *.pde setfiletype java 
au BufRead,BufNewFile *.fbs setfiletype c

"Flatbuffers specific stuff that doesn't work anymore?
syn match cStructure display /table\>/
syn match cStructure display /root_type\>/

"lol
syn match cTodo display /@note\>/
syn match cTodo display /@AH[Hh]*\>/

set number

"utility stuff
nnoremap <silent> <C-l> :nohl<CR><C-l>
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
imap jj <C-[>
map ? /<UP>

"lets me be sloppy
command! -nargs=* E edit <args>
command! -nargs=* W write <args>

"Source vimrc shortcuts
nmap <space><space> :tabnew ~/.vimrc<CR>
command! Src w ~/.vimrc | source ~/.vimrc
command! SRc w ~/.vimrc | source ~/.vimrc
command! SRC w ~/.vimrc | source ~/.vimrc

" command line utils
command! -nargs=1 Search !search <f-args>

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

command! QW  tabclose
command! Qw  tabclose

" mouse
set mouse=a
if has('mouse_sgr')
	set ttymouse=sgr
endif