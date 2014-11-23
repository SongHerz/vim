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
""" Misc
Plugin 'scrooloose/nerdtree'
Plugin 'luochen1990/rainbow'
" Also the script 3239
Plugin 'fholgado/minibufexpl.vim'
" After installing, one have to make manually.
" ruby-dev package is required on ubuntu 14.04.
" Make sure the version matches the version linked by vim.
" To check ruby version in vim, type
" :ruby puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"
" Extension making instructions:
" $ cd ~/.vim/bundle/command-t/ruby/command-t
" $ ruby extconf.rb
" $ make
Plugin 'https://github.com/wincent/command-t'

" For vimshell
" vimproc is needed for vimshell.
" After installing vimproc, one have to make manually:
" $ cd ~/.vim/bundle/vimproc.vim
" $ make
Plugin 'Shougo/vimproc.vim'
Plugin 'Shougo/vimshell.vim'

""" python
Plugin 'klen/python-mode'

""" Haskell
Plugin 'dag/vim2hs'
" Display type of sub-exprs, err/wrn, expansion of splices
Plugin 'eagletmt/ghcmod-vim'
" A completion plugin for Haskell, using ghc-mod
Plugin 'eagletmt/neco-ghc'

""" For C/C++
" A few of quick commands to swtich between source files and header files quickly. 
" ':help alternate' for information
Plugin 'a.vim'
" I installed libclang-dev for ubuntu 14.04,
" but I think only install libclang-xx package is enough.
"
" I think this is much better than omnicppcomplete,
" because it analyze source code on the fly, and I do not
" have to maintain ctags any more :D
Plugin 'Rip-Rip/clang_complete'

""" For Octave
" FIXME: DETECT the directory of this vimrc file AUTOMATICALLY,
"        and determine plugins paths dynamically.
set rtp+=~/vim/octave/

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
filetype plugin indent on

set nocompatible
set ruler
set showcmd
set number

set incsearch
set hlsearch

if has("gui_running")
	colo default
	" horizontal scroll bar
	set guioptions+=b
    " FIXME: CHECK SCREEN SIZE AND SET PROPER FONT AUTOMATICALLY
    " set guifont=Monospace\ 12
	set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
    set nowrap
    " colorscheme koehler
	set background=dark
    colorscheme zenburn
    highlight Normal guifg=LightGray guibg=Black
    highlight Visual guifg=NONE guibg=NONE gui=reverse
else
	set background=dark
    set mouse=a
endif

" For code style guide
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" file encoding
set fileencodings=ucs-bom,utf-8,gb18030,default,latin1

" Do not reset windows size to the same when open or close windows
set noequalalways



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

"""""""""""""""""""
" For fold methond
"""""""""""""""""""
" set foldmethod=syntax
" Do not fold on startup
" set foldlevel=100

""""""""""""""""""""
" For :Man command
""""""""""""""""""""
source $VIMRUNTIME/ftplugin/man.vim
source $VIMRUNTIME/syntax/man.vim

"""""""""""""""""""""""""""
"""""""""""""""""""""""""""
" General Key Mappings
"""""""""""""""""""""""""""
"""""""""""""""""""""""""""
" Map Up and Down to go only one line of the window
" not the whole line
noremap <Up> gk
noremap <Down> gj

""""""""""""""""""""""
""""""""""""""""""""""
" Octave settings
""""""""""""""""""""""
""""""""""""""""""""""
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
"""""""""""""""""""""""""
" Misc Settings
"""""""""""""""""""""""""
"""""""""""""""""""""""""

"""""""""""""""""""""""""
" Enable rainbow plugin
"""""""""""""""""""""""""
" Use :RainbowToggle to disable/enable it
let g:rainbow_active = 1

"""""""""""""""""""""""""
" Command-T plugin
"""""""""""""""""""""""""
let g:CommandTMaxHeight = 30
let g:CommandTMaxFiles = 500000
let g:CommandTInputDebounce = 200
let g:CommandTMaxCachedDirectories = 10
nnoremap <leader>f :CommandT<CR>



"""""""""""""""""""""""""
"""""""""""""""""""""""""
" Haskell Settings
"""""""""""""""""""""""""
"""""""""""""""""""""""""

" Remember if haskell related configurations have been initialized.
let g:haskell_config_init_done = 0

function HaskellConfig()
    """""""""""""""""""""""""
    " vim2hs
    """""""""""""""""""""""""
    " the script contains cabal/hlint/jmacro compilers under vim2hs/compiler.
    " Now, I only enabled hlint for haskell source code.
    " I am not sure if other compilers have been enabled.
    " When compiler hlint is set, to check haskell source file, type
    " :make
    " Set compiler to hlint
    compiler hlint

    if !g:haskell_config_init_done
        " I am not sure about performance impact when multiline strings is enabled.
        " Let me disable it by default, until there is real requirement to enable this.
        " let g:haskell_multiline_strings = 1
    endif

    """""""""""""""""""""""""""
    " neco-ghc
    """""""""""""""""""""""""""
    " Enable omni-completion
    setlocal omnifunc=necoghc#omnifunc

    if !g:haskell_config_init_done
        let g:necoghc_enable_detailed_browse = 1
    endif

    """"""""""""""""""""""""""
    " ghcmod-vim
    """"""""""""""""""""""""""
    nnoremap <leader>t  :GhcModType<cr>
    nnoremap <leader>c  :GhcModTypeClear<cr>
    nnoremap <leader>e  :GhcModExpand<cr>

    let g:haskell_config_init_done = 1
endfunction

au BufRead,BufNewFile *.hs call HaskellConfig()


"""""""""""""""""""""""
" pymode
"""""""""""""""""""""""
let g:pymode_options_max_line_length = 128
let g:pymode_rope_lookup_project = 1

""""""""""""""""""""""
""""""""""""""""""""""
" C/C++ settings
""""""""""""""""""""""
""""""""""""""""""""""
"""""""""""""""""""""""
" For doxygen support
"""""""""""""""""""""""
let g:syntax_extra_c='doxygen'
let g:syntax_extra_cpp='doxygen'
let g:load_doxygen_syntax=1
let g:doxygen_enhanced_color=1

""""""""""""""""""""""""
" clang_complete
""""""""""""""""""""""""
" At least there is no libclang.so for ubuntu 14.04,
" after installing libclang-dev package.
let g:clang_library_path = 'libclang-3.5.so.1'


""""""""""""""""""""""
""""""""""""""""""""""
" HDL settings
""""""""""""""""""""""
""""""""""""""""""""""
" For system verilog
autocmd BufNewFile,BufRead *.sv set filetype=verilog
