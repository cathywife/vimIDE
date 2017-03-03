setlocal et sta sw=4 sts=4
"set et "将ＴＡＢ替换成空格
au BufNewFile,BufRead  *.py set tabstop=4 softtabstop=4 textwidth=79  fileformat=unix
syntax on
"set cul "高亮光标所在行
set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示  
set go=             " 不要图形按钮  
color desert     " 设置背景主题  
color ron     " 设置背景主题  
color torte     " 设置背景主题  
set guifont=Courier_New:h10:cANSI   " 设置字体  
set ruler           " 显示标尺  
"set showcmd         " 输入的命令显示出来，看的清楚些  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
set foldenable      " 允许折叠 
set fdm=indent
"空格折叠
nnoremap <space> za
nnoremap <C-j> zR
set nocompatible  "去掉讨厌的有关vi一致性模式，避免以前版本的一些bug和局限  
" 显示中文帮助
if version >= 603
	set helplang=cn
	set encoding=utf-8
endif
" 显示行号
set number
" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch


"将tab替换为空格
nmap tt :%s/\t/    /g<CR>
"set title
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()" 
func SetTitle() 
      if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "")
        call append(line(".")+1, "#Author:")
        call append(line(".")+2, "#Mail: ")
        call append(line(".")+3, "#Platform:") 
     	call append(line(".")+4, "#Date:".strftime("%c"))
        call append(line(".")+5, "")
      elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# coding=utf-8")
	    call append(line(".")+1, "")
        call append(line(".")+2, "#Author:")
        call append(line(".")+3, "#Mail: ")
        call append(line(".")+4, "#Platform:") 
	    call append(line(".")+5, "#Date:".strftime("%c"))
        call append(line(".")+6, "")
      else
		call setline(1, "/*************************************************************************") 
        call append(line("."), "      > File Name: ".expand("%"))
        call append(line(".")+1, "	 > Author: ") 
		call append(line(".")+2, "	 > Mail: ") 
        call append(line(".")+3, "	 > Platform:")
		call append(line(".")+4, "	 > Date: ".strftime("%c"))
		call append(line(".")+5, " ************************************************************************/") 
		call append(line(".")+6, "")
      endif
      if expand("%:e") == 'cpp'
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
  	  endif
	  if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	  endif
	  if expand("%:e") == 'h'
		call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
		call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
		call append(line(".")+8, "#endif")
      endif
      if &filetype == 'java'
		call append(line(".")+6,"public class ".expand("%:r"))
		call append(line(".")+7,"")
	  endif

endfunc 
autocmd BufNewFile * normal G
"map
imap <C-l> #  
imap <C-k> <Esc>
map <F3> :NERDTreeToggle<CR>
imap <F3> <ESC> :NERDTreeToggle<CR>
"打开树状文件目录  
map <C-F3> \be  
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		exec "!time python3.4 %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
"        exec "!go build %<"
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
	endif
endfunc
"代码格式优化化
map <F6> :call FormartSrc()<CR><CR>
func FormartSrc()
    exec "w"
    if &filetype == 'c'
        exec "!astyle --style=ansi -a --suffix=none %"
    elseif &filetype == 'cpp' || &filetype == 'hpp'
        exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
    elseif &filetype == 'perl'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'py'||&filetype == 'python'
        exec "r !autopep8 -i --aggressive %"
    elseif &filetype == 'java'
        exec "!astyle --style=java --suffix=none %"
    elseif &filetype == 'jsp'
        exec "!astyle --style=gnu --suffix=none %"
    elseif &filetype == 'xml'
        exec "!astyle --style=gnu --suffix=none %"
    else
        exec "normal gg=G"
        return
    endif
    exec "e! %"
endfunc
"结束定义FormartSrc

imap <C-f> if __name__ == '__main__': <CR>



"共享剪贴板  
set clipboard+=unnamed 
"自动保存
set autowrite
set ruler                   " 打开状态栏标尺

"python补全
let g:pydiction_location = '~/.vim/after/complete-dict'
let g:pydiction_menu_height = 20
let Tlist_Ctags_Cmd='/usr/local/bin/ctags'
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
let python_highlight_all=1
let g:SimpylFold_docstring_prview=1
set encoding=utf8
autocmd FileType python set omnifunc=pythoncomplete#Complete


" My Bundles here:
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()
"Bundle 'tpope/vim-fugitive'
"Bundle 'gmarik/vundle'
"Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
"Bundle 'Yggdroot/indentLine'
"let g:indentLine_char = '┊'
""ndle 'tpope/vim-rails.git'
"" vim-scripts repos
"Bundle 'L9'
"Bundle 'FuzzyFinder'
"" non github repos
"Bundle 'git://github.com/wincent/command-t.git'
"Bundle 'Auto-Pairs'
"Bundle 'python-imports.vim'
"Bundle 'CaptureClipboard'
"Bundle 'ctrlp-modified.vim'
"Bundle 'last_edit_marker.vim'
"Bundle 'synmark.vim'
""Bundle 'Python-mode-klen'
"Bundle 'SQLComplete.vim'
"Bundle 'Javascript-OmniCompletion-with-YUI-and-j'
""Bundle 'JavaScript-Indent'
""Bundle 'Better-Javascript-Indentation'
"Bundle 'jslint.vim'
"Bundle "pangloss/vim-javascript"
"Bundle 'Vim-Script-Updater'
"Bundle 'ctrlp.vim'
"Bundle 'tacahiroy/ctrlp-funky'
"Bundle 'jsbeautify'
"Bundle 'The-NERD-Commenter'
""django
"Bundle 'django_templates.vim'
"Bundle 'Django-Projects'
"Bundle 'tmhedberg/SimpylFold' 
"Bundle 'vim-scripts/indentpython.vim' 
"Bundle 'Valloric/YouCompleteMe'  
"Bundle 'jnurmine/Zenburn'
"Bundle 'scrooloose/nerdtree'
"Bundle 'Lokaltog/powerline'


"Bundle 'FredKSchott/CoVim'
"Bundle 'djangojump'


"let NERDTreeIgnore=['\.pyc']
"filetype plugin indent on 


let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

" python with virtualenv support
py << EOF 
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir,'bin/activate_thie.py')
    execfile(activate_this,dict(__file__ = activate_this))
