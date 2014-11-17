"""""""""""""""""""""""""""""""""""""""""""""""""
" Unique vimrc for me.
" ~/.vimrc should be sym-linked to this one
"""""""""""""""""""""""""""""""""""""""""""""""""

"#################################################
""  Vundle section BEGIN (This must put first)
"#################################################

""""""""""""""""""""""""""""""""""""""""""""""""""
" Necessary set up to use Vundle to manage plugins
""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible    " required
filetype off        " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')
" by default Vundle installs plugins to ~/.vim/bundle

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Plugins used by me
" Misc
Plugin 'scrooloose/nerdtree'
Plugin 'luochen1990/rainbow'

" For vimshell
" vimproc is needed for vimshell.
" After installing vimproc, one have to make manually:
" $ cd ~/.vim/bundle/vimproc.vim
" $ make
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'

" python
Plugin 'klen/python-mode'

" Haskell
Plugin 'dag/vim2hs'
Plugin 'eagletmt/neco-ghc'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Examples on how to use Vundle to manage plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " The following are examples of different formats supported.
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"#################################################
""  Vundle section END
"#################################################


syntax on
set number

set incsearch
set showcmd
set hlsearch

if has("gui_running")
    set guifont=Monospace\ 12
	set background=dark
    colorscheme zenburn
else
	set background=dark
endif

" For code style guide
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" For system verilog
autocmd BufNewFile,BufRead *.sv set filetype=verilog


" For backup and swp file location
set backup

function InitBackupDir()
    let separator = "."
    let parent = $HOME .'/' . separator . 'vim/'
    let backup = parent . 'backup/'
    let tmp    = parent . 'tmp/'
    if exists("*mkdir")
        if !isdirectory(parent)
            call mkdir(parent)
        endif
        if !isdirectory(backup)
            call mkdir(backup)
        endif
        if !isdirectory(tmp)
            call mkdir(tmp)
        endif

    endif
    let missing_dir = 0
    if isdirectory(tmp)
        execute 'set backupdir=' . escape(backup, " ") . "/,."
    else
        let missing_dir = 1
    endif
    if isdirectory(backup)
        execute 'set directory=' . escape(tmp, " ") . "/,."
    else
        let missing_dir = 1
    endif
    if missing_dir
        echo "Warning: Unable to create backup directories: " 

        . backup ." and " . tmp
        echo "Try: mkdir -p " . backup

        echo "and: mkdir -p " . tmp
        set backupdir=.                 

        set directory=.
    endif

endfunction          

call InitBackupDir()


" For man plugin
source $VIMRUNTIME/ftplugin/man.vim

" For octave
" Octave syntax
augroup filetypedetect
    au! BufRead,BufNewFile *.m,*.oct set filetype=octave
augroup END 

" Use keywords from Octave syntax language file for autocomplete
if has("autocmd") && exists("+omnifunc")
    autocmd Filetype octave
                \ if &omnifunc == "" |
                \ setlocal omnifunc=syntaxcomplete#Complete |
                \ endif
endif 


"""""""""""""""""""""""""
" Enable rainbow plugin
"""""""""""""""""""""""""
" Use :RainbowToggle to disable/enable it
let g:rainbow_active = 1


"""""""""""""""""""""""""
" vim2hs
"""""""""""""""""""""""""
" the script contains cabal/hlint/jmacro compilers under vim2hs/compiler.
" Now, I only enabled hlint for haskell source code.
" I am not sure if other compilers have been enabled.
" When compiler hlint is set, to check haskell source file, type
" :make
" Set compiler to hlint
au BufRead,BufNewFile *.hs compiler hlint

" I am not sure about performance impact when multiline strings is enabled.
" Let me disable it by default, until there is real requirement to enable this.
" let g:haskell_multiline_strings = 1


"""""""""""""""""""""""""""
" neco-ghc (ghc-mod)
"""""""""""""""""""""""""""
" Enable omni-completion
au BufRead,BufNewFile *.hs setlocal omnifunc=necoghc#omnifunc


"""""""""""""""""""""""
" pymode
"""""""""""""""""""""""
let g:pymode_options_max_line_length = 128
let g:pymode_rope_lookup_project = 1
