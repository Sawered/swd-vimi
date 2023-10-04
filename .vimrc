"=============================================================================
" Description: Vimi bundle .vimrc
" Author: Vyacheslav Oliyanchuk <miripiruni@gmail.com>
" URL: http://github.com/miripiruni/vimi/
"=============================================================================
so ~/.vimi/load_plugins
" Interface
    set guifont=Hack\ 11
    " Character encoding used inside Vim
    " Only available when compiled with the +multi_byte feature
    set encoding=utf-8
    " Character encodings considered when starting to edit an existing file
    " Only available when compiled with the +multi_byte feature
    set fileencodings=utf-8,cp1251
    " Always add lf in the end of file
    set fileformat=unix
    " Enhance command-line completion
    " Only available when compiled with the +wildmenu feature
    set wildmenu
    " Set completion mode
    " When more than one match, list all matches and complete first match
    " Then complete the next full match
    set wildmode=list:longest,full
    " Ignore following files when completing file/directory names
    " Version control
    set wildignore+=.hg,.git,.svn
    " OS X
    set wildignore+=*.DS_Store
    " Python byte code
    set wildignore+=*.pyc
    " Binary images
    set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
    " Set title of the window to filename [+=-] (path) - VIM
    " Only available when compiled with the +title feature
    set title
    " Show (partial) command in the last line of the screen
    " Comment this line if your terminal is slow
    " Only available when compiled with the +cmdline_info feature
    set showcmd
    " Minimal number of lines to scroll when cursor gets off the screen
    " set scrolljump=5
    " Minimal number of lines to keep above and below the cursor
    " Typewriter mode = keep current line in the center
    set scrolloff=999
    " Always show tabs
    " set showtabline=2
    " Display invisible characters
    set list
    if version >= 700
        set listchars=tab:▸\ ,trail:·,extends:❯,precedes:❮,nbsp:×
    else
        set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
    endif
    " Wrap long lines
    set wrap
    " Don't break words when wrapping
    " Only available when compiled with the +linebreak feature
    set linebreak
    " Show ↪ at the beginning of wrapped lines
    if has("linebreak")
        let &sbr = nr2char(8618).' '
    endif
    " Number of column to be highlighted
    " Only available when compiled with the +syntax feature
    if version >= 703
        set colorcolumn=80
    end
    " Maximum width of text that is being inserted
    " Longer lines will be broken after white space to get this width
    " set textwidth=80
    " Copy indent from current line when starting a new line
    set autoindent
    " Do smart indenting when starting a new line
    " Only available when compiled with the +smartindent feature
    set smartindent
    " Number of spaces to use for each step of (auto)indent
    set shiftwidth=4
    " Use spaces instead of tab
    set expandtab
    " Number of spaces that a tab counts for
    set tabstop=4
    " Number of spaces that a tab counts for while performing editing operations
    set softtabstop=4
    " Number of pixel lines inserted between characters
    " Only in GUI
    set linespace=1
    " Highlight the screen line of the cursor
    " Only available when compiled with the +syntax feature
    set cursorline
    " Turn off cursor blinking in normal mode
    " Only available when compiled with GUI enabled
    set guicursor=n:blinkon0
    " Remove all components and options of the GUI
    " Only available when compiled with GUI enabled
    set guioptions=
    " Number of colors
    set t_Co=256
    " Splitting a window will put the new window below the current one
    " See :sp
    " Only available when compiled with the +windows feature
    set splitbelow
    " Splitting a window will put the new window right of the current one
    " See :vsp
    " Only available when compiled with the +vertsplit feature
    set splitright
    " Don't show the intro message starting Vim
    set shortmess+=I
    " Turn mouse pointer to a up-down sizing arrow
    " Only available when compiled with the +mouseshape feature
    set mouseshape=s:udsizing,m:no
    " Hide the mouse when typing text
    " Only works in GUI
    set mousehide
    " Edit several files in the same time without having to save them
    set hidden
    set modeline

    " No beeps, no flashes
    set visualbell
    set t_vb=
    " List of directories which will be searched when using :find, gf, etc.
    " Search relative to the directory of the current file
    " Search in the current directory
    " Search downwards in a directory tree
    " Only available when compiled with the +path_extra feature
    set path=.,,**

" Status line
    function! FileSize()
        let bytes = getfsize(expand("%:p"))
        if bytes <= 0
            return ""
        endif
        if bytes < 1024
            return bytes . "B"
        else
            return (bytes / 1024) . "K"
        endif
    endfunction

    function! CurDir()
        return expand('%:p:~')
    endfunction

    " Last window always has a status line
    set laststatus=2
    " Content of the status line
    " Only available when compiled with the +statusline feature
    set statusline=\
    " Buffer number
    set statusline+=%n:\
    " File name
    set statusline+=%t
    " Modified flag
    set statusline+=%m
    set statusline+=\ \
    " Paste mode flag
    set statusline+=%{&paste?'[paste]\ ':''}
    " File encoding
    set statusline+=%{&fileencoding}
    " Type of file
    " Only available when compiled with the +autocmd feature
    set statusline+=\ \ %Y
    " Column number
    set statusline+=\ %3.3(%c%)
    " Current line / number of lines in buffer
    set statusline+=\ \ %3.9(%l/%L%)
    " Percentage through file in lines
    " set statusline+=\ \ %2.3p%%
    " File size
    set statusline+=\ \ %{FileSize()}
    " Truncate here if line is too long
    set statusline+=%<
    " Path to the file
    set statusline+=\ \ CurDir:%{CurDir()}





" Create encodings menu
" Создаем меню с кодировками
        menu Encoding.UTF-8 :e ++enc=utf8 <CR>
        menu Encoding.Windows-1251 :e ++enc=cp1251<CR>
        menu Encoding.koi8-r :e ++enc=koi8-r<CR>
        menu Encoding.cp866 :e ++enc=cp866<CR>


" Spell checking
" Проверка орфографии
        if version >= 700
        " Turn off spell checking
            set spell spelllang=
            set nospell " По умолчанию проверка орфографии выключена
            menu Spell.off :setlocal spell spelllang= <cr>
            menu Spell.Russian+English :setlocal spell spelllang=ru,en <cr>
            menu Spell.Russian :setlocal spell spelllang=ru <cr>
            menu Spell.English :setlocal spell spelllang=en <cr>
            menu Spell.-SpellControl- :
            menu Spell.Word\ Suggest<Tab>z= z=
            menu Spell.Previous\ Wrong\ Word<Tab>[s [s
            menu Spell.Next\ Wrong\ Word<Tab>]s ]s
        endif

" Folding
    " za = toggle current fold
    " zR = open all folds
    " zM = close all folds
        " from https://github.com/sjl/dotfiles/blob/master/vim/.vimrc
        function! MyFoldText()
            let line = getline(v:foldstart)

            let nucolwidth = &fdc + &number * &numberwidth
            let windowwidth = winwidth(0) - nucolwidth - 3
            let foldedlinecount = v:foldend - v:foldstart

            " expand tabs into spaces
            let onetab = strpart(' ', 0, &tabstop)
            let line = substitute(line, '\t', onetab, 'g')

            let line = strpart(line, 0, windowwidth - 2 - len(foldedlinecount))
            let fillcharcount = windowwidth - len(line) - len(foldedlinecount)
            return line . '…' . repeat(" ",fillcharcount) . foldedlinecount . '…' . ' '
        endfunction
        set foldtext=MyFoldText()

        set foldcolumn=0        " Ширина строки где располагается фолдинг
        set foldmethod=indent   " Фолдинг по отступам
        set foldnestmax=10      " Глубина фолдинга 10 уровней
        set nofoldenable        " Не фолдить по умолчанию
        set foldlevel=1         " This is just what i use
        set fillchars="fold: "  " remove the extrafills --------

    " Не показывать парную скобку
        let loaded_matchparen=1 " перестает прыгать на парную скобку, показывая где она. +100 к скорости
        set noshowmatch " Не показывать парные <> в HTML





" Search
    " While typing a search command, show pattern matches as it is typed
    " Only available when compiled with the +extra_search feature
    set incsearch
    " When there is a previous search pattern, highlight all its matches
    " Only available when compiled with the +extra_search feature
    set hlsearch
    " Ignore case in search patterns
    set ignorecase
    " Override the 'ignorecase' if the search pattern contains upper case characters
    set smartcase
    " All matches in a line are substituted instead of one
    set gdefault


" Шорткаты

    let mapleader = "," " мапим <Leader> на запятую. По умолчанию <Leader> это обратный слэш \

    " ,m
        " Toggle mouse support in Normal mode
        set mouse=
        function! ToggleMouse()
          if &mouse == 'a'
            set mouse=
            echo "Mouse usage disabled"
          else
            set mouse=a
            echo "Mouse usage enabled"
          endif
        endfunction
        nnoremap <leader>m :call ToggleMouse()<CR>

    " ,r
        " Find and replace in all open buffers
        " See http://vim.wikia.com/wiki/VimTip382
        function! Replace()
            let s:word = input("Replace " . expand('<cword>') . " with:")
            :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/gce'
            :unlet! s:word
        endfunction
        nnoremap <Leader>r :<C-u>call Replace()<CR>

    " <Esc><Esc>
        " Clear the search highlight in Normal mode
        nnoremap <silent> <Esc><Esc> :nohlsearch<CR><Esc>

    " < >
        vnoremap < <gv
        vnoremap > >gv

    " ,p
        " Toggle the 'paste' option
        "set pastetoggle=<Leader>p

    " ,nm
        " Switch type of line numbers
        " http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
        " Vim 7.3 required
        let g:relativenumber = 0
        function! ToogleRelativeNumber()
          if g:relativenumber == 0
            let g:relativenumber = 1
            set norelativenumber
            set number
            echo "Show line numbers"
          elseif g:relativenumber == 1
            let g:relativenumber = 2
            set nonumber
            set relativenumber
            echo "Show relative line numbers"
          else
            let g:relativenumber = 0
            set nonumber
            set norelativenumber
            echo "Show no line numbers"
          endif
        endfunction
        nnoremap <Leader>nm :<C-u>call ToogleRelativeNumber()<cr>

    " ,g
        " Toggle GUI elements
        " Only available when compiled with GUI enabled
        function! ToggleGUINoise()
          if &go==''
            exec('se go=mTrL')
            echo "Show GUI elements"
          else
            exec('se go=')
            echo "Show no GUI elements"
          endif
        endfunction
        nnoremap <Leader>g <Esc>:<C-u>call ToggleGUINoise()<cr>

    " ,f
        " Fast grep
        " Recursive search in current directory for matches with current word
        nnoremap <Leader>f :<C-u>execute "Ack " . expand("<cword>") <Bar> cw<CR>

    " ,s
        " Shortcut for :%s//
        nnoremap <leader>s :<C-u>%s//<left>
        vnoremap <leader>s :s//<left>

    " Move lines
        " Move one line
        nnoremap <C-S-k> ddkP
        nnoremap <C-S-j> ddp
        " Move selected lines
        " See http://www.vim.org/scripts/script.php?script_id=1590
        vnoremap <C-S-k> xkP'[V']
        vnoremap <C-S-j> xp'[V']

    " Standart Copy paste
        vnoremap <C-c> "+y
        nnoremap <C-a> :set paste<cr>"+p<cr>:set nopaste<cr>

    " Y from cursor position to the end of line
        nnoremap Y y$

    " Pasting with correct indention
        " nnoremap p p=`]
        " nnoremap P P=`[

    " Disable <Arrow keys>
        " Warning: nightmare mode!
        "inoremap <Up> <NOP>
        "inoremap <Down> <NOP>
        "inoremap <Left> <NOP>
        "inoremap <Right> <NOP>
        "noremap <Up> <NOP>
        "noremap <Down> <NOP>
        "noremap <Left> <NOP>
        "noremap <Right> <NOP>
        " Navigate with <Ctrl>-hjkl in Insert mode
        inoremap <C-h> <C-o>h
        inoremap <C-j> <C-o>j
        inoremap <C-k> <C-o>k
        inoremap <C-l> <C-o>l

    " Switch splits
        nnoremap <C-h> <C-W>h
        nnoremap <C-j> <C-W>j
        nnoremap <C-k> <C-W>k
        nnoremap <C-l> <C-W>l

    " ,v
        " Open the .vimrc in a new tab
        nnoremap <leader>v :<C-u>tabedit $MYVIMRC<CR>
        :cabbrev e NERDTreeClose<CR>:e!

    " <Space> = <PageDown>
        nnoremap <Space> <PageDown>

    " n и N
        " Search matches are always in center
        nnoremap n nzz
        nnoremap N Nzz
        nnoremap * *zz
        nnoremap # #zz
        nnoremap g* g*zz
        nnoremap g# g#zz

    " K to split
        " Basically this splits the current line into two new ones at the cursor position,
        " then joins the second one with whatever comes next.
        "
        " Example:                      Cursor Here
        "                                    |
        "                                    V
        " foo = ('hello', 'world', 'a', 'b', 'c',
        "        'd', 'e')
        "
        " becomes
        "
        " foo = ('hello', 'world', 'a', 'b',
        "        'c', 'd', 'e')
        "
        " Especially useful for adding items in the middle of long lists/tuples in Python
        " while maintaining a sane text width.
        nnoremap K <nop>
        nnoremap K h/[^ ]<cr>"zd$jyyP^v$h"zpJk:s/\v +$//<cr>:noh<cr>j^

    " Navigate through wrapped lines
        noremap j gj
        noremap k gk

    " gf
        " Open file under cursor in a new vertical split
        nnoremap gf :<C-u>vertical wincmd f<CR>

    " Create a new window relative to the current one
        nnoremap <Leader><left>  :<C-u>leftabove  vnew<CR>
        nnoremap <Leader><right> :<C-u>rightbelow vnew<CR>
        nnoremap <Leader><up>    :<C-u>leftabove  new<CR>
        nnoremap <Leader><down>  :<C-u>rightbelow new<CR>

    " Copy indented line without spaces
        nnoremap ,y ^yg_"_dd

    " ,c
        " camelCase => camel_case
        vnoremap <silent> <Leader>c :s/\v\C(([a-z]+)([A-Z]))/\2_\l\3/g<CR>

    " <Space><Space>
        " Double space to ". "
        " inoremap <Space><Space> .

    " ,ts
        " Fix trailing white space
        nnoremap <leader>ts :<C-u>%s/\s\+$//e<CR>

    " ,bl
        " Show buffers
        nnoremap <Leader>bl :<C-u>ls<cr>:b

    " ,bp
        " Go to prev buffer
        nnoremap <Leader>bp :<C-u>bp<cr>

    " ,bn
        " Go to next buffer
        nnoremap <Leader>bn :<C-u>bn<cr>

    " ,u
        " Change case to uppercase
        nnoremap <Leader>u gUiw
        inoremap <Leader>u <esc>gUiwea

    " В коммандном режиме разрешить прыгать в конец и начало строки,
    " как в консоли
        cnoremap <c-e> <end>
        inoremap     <c-e> <c-o>$
        cnoremap <c-a> <home>
        inoremap     <c-a> <c-o>^

    " ,b
        " In Visual mode exec git blame with selected text
        vnoremap <Leader>b :<C-U>!git blame <C-R>=expand("%:p") <CR> \| sed -n <C-R>=line("'<") <CR>,<C-R>=line("'>") <CR>p <CR>

    " ,w
        " Jump to next split
        nnoremap <Leader>w <C-w>w

    " Ctrl+s
        noremap <C-s> <esc>:w<CR>
        inoremap <C-s> <esc>:w<CR>

    " ,n
        " Edit another file in the same directory with the current one
        noremap <Leader>n :<C-u>vnew <C-R>=expand("%:p:h") . '/'<CR>

    " Bind :Q to :q
        command! Q q

    " {<CR>
        " auto complete {} indent and position the cursor in the middle line
        "inoremap {<CR> {<CR>}<Esc>O
        "inoremap (<CR> (<CR>)<Esc>O
        "inoremap [<CR> [<CR>]<Esc>O

    " Fold with space
        " nnoremap <Space> za
        " vnoremap <Space> zf

    " ,tt show tabs
        " map <Leader>tt :tabs<CR>
    " ,t go tab
        " map <Leader>t :tabn
    " Switch tabs with <Tab>
        nnoremap <Tab> gt
        nnoremap <S-Tab> gT

    " Ремапим русские символы
        " set langmap=ёйцукенгшщзхъфывапролджэячсмитьбюЁЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.~QWERTYUIOP{}ASDFGHJKL:\\"ZXCVBNM<>

    " ,q close window
        map <Leader>q :q<CR>

    " ,d current dir
        map <Leader>d :NERDTree %:p:h<CR>

" Environment
    " Store lots of history entries: :cmdline and search patterns
    set history=1000
    " Save file with root permissions
    command! SaveAsRoot exec 'w !sudo tee % > /dev/null' | e!

    " Backspacing settings
        " start     allow backspacing over the start of insert;
        "           CTRL-W and CTRL-U stop once at the start of insert.
        " indent    allow backspacing over autoindent
        " eol       allow backspacing over line breaks (join lines)
        set backspace=indent,eol,start

    " Backup и swp files
        " Don't create backups
        set nobackup
        " Don't create swap files
        set noswapfile

    " Load previous session
        " Only available when compiled with the +viminfo feature
        set viminfo='10,\"100,:20,%,n~/.viminfo
        " Set cursor to its last position
        au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

    " AutoReload .vimrc
    " See http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
    " Source the vimrc file after saving it
    if has("autocmd")
        autocmd! bufwritepost .vimrc source $MYVIMRC
    endif

    " Go to last file(s) if invoked without arguments
        " http://vimcastsim.wikia.com/wiki/Open_the_last_edited_file
        " autocmd VimLeave * nested if (!isdirectory($HOME . "/.vim")) |
        "     \ call mkdir($HOME . "/.vim") |
        "     \ endif |
        "     \ execute "mksession! " . $HOME . "/.vim/Session.vim"
        " autocmd VimEnter * nested if argc() == 0 && filereadable($HOME . "/.vim/Session.vim") |
        "     \ execute "source " . $HOME . "/.vim/Session.vim"

    " Auto change the directory to the current file I'm working on
    "autocmd BufEnter * lcd %:p:h

    " Save on losing focus
    " Only available for GUI
    autocmd FocusLost * :wa

    " Resize splits when the window is resized
    " Only available for GUI
    au VimResized * exe "normal! \<c-w>="

" File specific
    autocmd BufNewFile *.py 0r ~/.vimi/templates/template.py
    autocmd BufNewFile *.xml 0r ~/.vimi/templates/template.xml
    autocmd BufNewFile *.xsl 0r ~/.vimi/templates/template.xsl
    autocmd BufNewFile *.jade 0r ~/.vimi/templates/template.jade
    autocmd BufNewFile *.html 0r ~/.vimi/templates/template.html

    autocmd FileType jade setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" Plugins

    " Solarized
    "    syntax enable
    "    let g:solarized_termcolors=256
    "    set background=dark
    "    try
    "        colorscheme solarized
    "    catch /^Vim\%((\a\+)\)\=:E185/
    "        echo "Solarized theme not found. Run :BundleInstall"
    "    endtry

    "    try
    "        call togglebg#map("<Leader>b")
    "    catch /^Vim\%((\a\+)\)\=:E117/
    "        " :(
    "    endtry

    " NERDTree
        nnoremap <Bs> :<C-u>NERDTreeToggle<CR>
        let NERDTreeShowBookmarks=0
        let NERDTreeChDirMode=0
        let NERDTreeQuitOnOpen=1
        "let NERDTreeShowHidden=1
        let NERDTreeKeepTreeInNewTab=0
        " Disable display of the 'Bookmarks' label and 'Press ? for help' text
        let NERDTreeMinimalUI=1
        " Use arrows instead of + ~ chars when displaying directories
        let NERDTreeDirArrows=1
        let NERDTreeBookmarksFile= $HOME . '/.vim/.NERDTreeBookmarks'
        let g:NERDTreeWinSize=50

    " SnipMate
        let g:snipMate = { 'snippet_version' : 1 }

    " UltiSnips
        let g:UltiSnipsExpandTrigger="<tab>"
        let g:UltiSnipsJumpForwardTrigger="<tab>"
        let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

    " VimWiki
        let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/'}]

    " Tagbar
        "nmap <F8> :TagbarToggle<CR>

    " CTRL-P
        let g:ctrlp_custom_ignore = {
          \ 'dir':  '\v[\/](\.git|\.hg|\.svn|app\/cache)$',
          \ }

    " Syntastic
        let g:syntastic_enable_signs=1
        "highlight SyntasticErrorSign guifg=white guibg=red
        let g:loaded_syntastic_javascript_jshint_checker=1
        let g:syntastic_javascript_checkers = ['jshint']

    " Airline
        let g:airline_theme='powerlineish'
        " base16,wombat
        let g:airline_powerline_fonts = 1

        if !exists('g:airline_symbols')
          let g:airline_symbols = {}
        endif

        " unicode symbols
        let g:airline_left_sep = '»'
        let g:airline_left_sep = '▶'
        let g:airline_right_sep = '«'
        let g:airline_right_sep = '◀'
        let g:airline_symbols.colnr = ' ㏇:'
        let g:airline_symbols.colnr = ' ℅:'
        let g:airline_symbols.crypt = '🔒'
        let g:airline_symbols.linenr = '☰'
        let g:airline_symbols.linenr = ' ␊:'
        let g:airline_symbols.linenr = ' ␤:'
        let g:airline_symbols.linenr = '¶'
        let g:airline_symbols.maxlinenr = ''
        let g:airline_symbols.maxlinenr = '㏑'
        let g:airline_symbols.branch = '⎇'
        let g:airline_symbols.paste = 'ρ'
        let g:airline_symbols.paste = 'Þ'
        let g:airline_symbols.paste = '∥'
        let g:airline_symbols.spell = 'Ꞩ'
        let g:airline_symbols.notexists = 'Ɇ'
        let g:airline_symbols.notexists = '∄'
        let g:airline_symbols.whitespace = 'Ξ'

        " powerline symbols
        let g:airline_left_sep = ''
        let g:airline_left_alt_sep = ''
        let g:airline_right_sep = ''
        let g:airline_right_alt_sep = ''
        let g:airline_symbols.branch = ''
        let g:airline_symbols.colnr = ' ℅:'
        let g:airline_symbols.readonly = ''
        let g:airline_symbols.linenr = ' :'
        let g:airline_symbols.maxlinenr = '☰ '
        let g:airline_symbols.dirty='⚡'
" Custom modifications

    function! <SID>StripTrailingWhitespaces()
        " Preparation: save last search, and cursor position.
        let _s=@/
        let l = line(".")
        let c = col(".")
        " Do the business:
        %s/\s\+$//e
        " Clean up: restore previous search history, and cursor position
        let @/=_s
        call cursor(l, c)
    endfunction
    autocmd BufWritePre *.rs,*.py,*.js,*.php,*.sql,*.css,*.less :call <SID>StripTrailingWhitespaces()

    " Ovverride syntax
    au BufNewFile,BufRead *.gradle setf groovy
    au BufNewFile,BufRead,BufReadPre *.md setf markdown
    au BufNewFile,BufRead,BufReadPre *.go setf go
    "au BufNewFile,BufRead *.html.twig set filetype=htmltwig

    colorscheme jellybeans
    " laravel
    " peacock
    " halflife
    " juicy
    " zacks
    " hyrule
    " jellybeans
    " gruvbox

    " Line numbers & folding
    set number
    let php_folding=1
    set foldlevel=1
    set foldcolumn=2
    set foldenable
    set mouse=""
    set mousemodel=extend

    let snips_author = 'skoryukin'
    let g:jellybeans_overrides = {
    \    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
    \              'ctermfg': 'Black', 'ctermbg': 'Yellow',
    \              'attr': 'bold' },
    \}

    "stop parenthesis matching (it fix slow cursor)
    let loaded_matchparent=1

    " disable vim-pasta for some types
    let g:pasta_disabled_filetypes = ['python', 'coffee', 'yaml']

    " Disable Ex-mode
    map Q <Nop>

    " Paste yanked text
    map <S-Insert> <C-r>"
    map! <S-Insert> <C-r>"

    ":map <silent> <S-Insert> "+p
    ":imap <silent> <S-Insert> <Esc>"+pa

    " Make shift-insert work like in Xterm
    "map <S-Insert> <MiddleMouse>
    "map! <S-Insert> <MiddleMouse>

"PHP CS Fixer
    " If php-cs-fixer is in $PATH, you don't need to define line below
    let g:php_cs_fixer_path = "~/bin/php-cs-fixer" " define the path to the php-cs-fixer.phar
    let g:php_cs_fixer_level = "symfony"              " which level ?
    let g:php_cs_fixer_config = "default"             " configuration
    "let g:php_cs_fixer_config_file = '.php_cs'       " configuration file
    let g:php_cs_fixer_php_path = "php"               " Path to PHP
    " If you want to define specific fixers:
    "let g:php_cs_fixer_fixers_list = "linefeed,short_tag,indentation"
    let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
    let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
    let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
"Racer
    set hidden
    "let g:racer_cmd = "/home/sawered/.cargo/bin/racer"
    "let $RUST_SRC_PATH="$HOME/prj/rust/src/"
    let g:racer_experimental_completer = 1
