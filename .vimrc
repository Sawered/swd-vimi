" ===================================================================
" Базовые настройки
" ===================================================================

set nocompatible " Отключаем режим совместимости с vi. Эту строку лучше держать в начале настроек
set number       " Показываем нумерацию строк

filetype plugin indent on

set encoding=utf-8 "Sets the character encoding used inside Vim.
set fileencodings=utf8,cp1251 " Возможные кодировки файлов и последовательность определения

 " Backspacing settings {
    " start     allow backspacing over the start of insert; CTRL-W and CTRL-U stop once at the start of insert.
    " indent    allow backspacing over autoindent
    " eol       allow backspacing over line breaks (join lines)
    set backspace=indent,eol,start
" }

" Backup, резервные и swp файлы {
    "set nobackup
    set backupdir=~/tmp/bac " Директория для backup файлов
    "set noswapfile
    set directory=~/tmp/swp " Директория для swp файлов
" }

" Загрузка предыдущей сессии {
    set viminfo='10,\"100,:20,%,n~/.viminfo
    " Устанавливаем курсор в файле на место, где он был при закрытии этого файла
    au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
" }

" Саджест по <tab> в командной строке {
    "When 'wildmenu' is on, command-line completion operates in an enhanced
    "mode.  On pressing 'wildchar' (usually <Tab>) to invoke completion,
    "the possible matches are shown just above the command line, with the
    "first match highlighted (overwriting the status line, if there is
    "one).
    set wildmenu
" }

" window title {
    " the title of the window will be set to the value of 'titlestring'
    " (if it is not empty), or to: filename [+=-] (path) - VIM
    set title
" }

" Show (partial) command in the last line of the screen {
    " Set this option off if your terminal is slow.
    " In Visual mode the size of the selected area is shown:
    " - When selecting characters within a line, the number of characters.
    "   If the number of bytes is different it is also displayed: "2-6"
    "   means two characters and six bytes.
    " - When selecting more than one line, the number of lines.
    " - When selecting a block, the size in screen characters:
    "   {lines}x{columns}.
    set showcmd
" }

set scrolljump=5
set scrolloff=3

set incsearch   " При поиске перескакивать на найденный текст в процессе набора строки
set showmatch
set hlsearch    " Включаем подсветку выражения, которое ищется в тексте
set ignorecase  " Игнорировать регистр букв при поиске
set smartcase
set gdefault

" Не бибикать! {
    set novisualbell
    set t_vb=
" }

set showtabline=2 " Показывать табы всегда
set list          " Показывать табуляцию и eol-символ текущей строки

" Символ табуляции и конца строки {
    if has('multi_byte')
        if version >= 700
            set listchars=tab:»\ ,trail:·,extends:→,precedes:←,nbsp:×
            "set listchars=tab:▸\ ,eol:¬ " Textmate like
        else
            set listchars=tab:»\ ,trail:·,extends:>,precedes:<,nbsp:_
        endif
    endif
" }

" Символ, который будет показан перед перенесенной строкой {
    if has("linebreak")
          let &sbr = nr2char(8618).' '  " Show ↪ at the beginning of wrapped lines
    endif
" }

set wrap            " Включаем перенос строк (http://vimcasts.org/episodes/soft-wrapping-text/)
set linebreak       " Перенос не разрывая слов
set autoindent      " Копирует отступ от предыдущей строки
set smartindent     " Включаем 'умную' автоматическую расстановку отступов
set expandtab
set shiftwidth=4    " Размер сдвига при нажатии на клавиши << и >>
set tabstop=4       " Размер табуляции
set softtabstop=4
set linespace=1     " add some line space for easy reading

set history=1000 " store lots of :cmdline history

" Приводим в порядок status line {
    " from https://github.com/vgod/vimrc/blob/master/vimrc
    set laststatus=2
    set statusline=\ %{HasPaste()}%<%-15.25(%f%)%m%r%h\ %w\ \ 
    set statusline+=\ \ \ [%{&ff}/%Y]%=file=%{&fileencoding}\ enc=%{&encoding}\ 
    set statusline+=\ \ \ %<%20.30(%{hostname()}:%{CurDir()}%)\ 
    set statusline+=\ \ \ %=%-10.(%l,%c%V%)\ %p%%/%L

    fun! CurDir()
        let curdir = substitute(getcwd(), $HOME, "~", "")
        return curdir
    endfunction

    fun! HasPaste()
        if &paste
            return '[PASTE]'
        else
            return ''
        endif
    endfunction
"}

" Show the line and column number of the cursor position {
    set ruler
    set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
" }

" Создаем меню с кодировками {
    menu Encoding.UTF-8 :e ++enc=utf8 <CR>
    menu Encoding.Windows-1251 :e ++enc=cp1251<CR>
    menu Encoding.koi8-r :e ++enc=koi8-r<CR>
    menu Encoding.cp866 :e ++enc=cp866<CR>
" }

" Проверка орфографии {
    if version >= 700
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
" }

set splitbelow " текущее будет ниже нового при :sp
set splitright " текущее окно будет правее нового при :vsp

" AutoReload .vimrc {
    " from http://vimcasts.org/episodes/updating-your-vimrc-file-on-the-fly/
    " Source the vimrc file after saving it
    if has("autocmd")
      autocmd! bufwritepost .vimrc source $MYVIMRC
    endif
" }

set cursorline    " Подсветка строки, в которой находится в данный момент курсор
set guicursor=    " Отключаем мигание курсора
set guioptions-=T " Отключаем панель инструментов
set guioptions-=e " Отключаем графические табы (текстовые занимают меньше места)

" Фолдинг {
    " zf - создает новую складку (актуально при foldmethod=manual).
    " zd - удаляет складку, на которой в данный момент находится курсор.
    " zD - рекурсивно удаляет все складки под курсором.
    " zE - удаляет все складки в окне.
    " zo - открыть текущую складку.
    " zO - открыть текущую складку и все складки внутри нее.
    " zc - скрыть текущую складку.
    " zС - скрыть текущую складку и все складки внутри нее.
    " za - скрыть/открыть текущую складку.
    " zA - скрыть/открыть текущую складку и все складки внутри нее.
    " {zr, zm} - {увеличивает, уменьшает} на 1 уровень сокрытия складок.
    " {zR, zM} - {открыть, скрыть} все складки.
    set foldcolumn=2        " Ширина строки где располагается фолдинг
    set foldmethod=manual   " Фолдинг по отступам
    set foldnestmax=10      " Глубина фолдинга 10 уровней
    set nofoldenable        " Не фолдить по умолчанию
    set foldlevel=1         " This is just what i use
" }

set formatoptions-=o "dont continue comments when pushing o/O



" ===================================================================
" Шорткаты
" ===================================================================

let mapleader = "," " мапим кнопку <Leader> на запятую. По умолчанию <Leader>
                    " это обратный слэш \

" ,m {
    " По ,m в Normal mode включает/выключает поддержку мыши
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
" }

" ,r {
    " Поиск и замена во всех открытых буферах http://vim.wikia.com/wiki/VimTip382
    function! Replace()
        let s:word = input("Replace " . expand('<cword>') . " with:")
        :exe 'bufdo! %s/\<' . expand('<cword>') . '\>/' . s:word . '/ge'
        :unlet! s:word
    endfunction
    map ,r :call Replace()<CR>
" }

" <Enter> {
    " Clear the search highlight by pressing ENTER when in Normal mode (Typing commands)
    :nnoremap <CR> :nohlsearch<CR>/<BS><CR>
" }

" < > {
    vnoremap < <gv
    vnoremap > >gv
" }

" ,v {
    " Вставлять код извне без этой строчки проблематично, без нее начитается
    " бешеный реформат кода
    set pastetoggle=<leader>v
" }

" <F2> {
    " Fast Save File
    map <F2> :w<CR>
    vmap <F2> <ESC>:w<CR>v
    imap <F2> <ESC>:w<CR>i
" }

" <F4> {
    " Fast grep
    " грепает в текущей директории по слову, на котором стоит курсор
    map <F4> :execute "vimgrep /" . expand("<cword>") . "/j **" <Bar> cw<CR> 
" }

" Перемещение строк {
    " переместить одну строку
    "nmap <D-S-Up> ddkP
    nmap <D-S-k> ddkP
    "nmap <D-S-Down> ddp
    nmap <D-S-j> ddp

    " переместить несколько выделенных строк http://www.vim.org/scripts/script.php?script_id=1590 the best {
    "vmap <D-S-Up> xkP'[V']
    vmap <D-S-k> xkP'[V']
    "vmap <D-S-Down> xp'[V']
    vmap <D-S-j> xp'[V']
" }

" Мапим {действие} от курсора до конца строки {
    nnoremap Y y$ " yank
    nnoremap D d$ " удалить
    nnoremap C c$ " заменить
" }

" Pasting with correct indention {
    nmap ]p p=`]
    nmap ]P P=`[
" }

" Disable <Arrow keys> {
    " Warning: nightmare mode!
    inoremap <Up> <NOP>
    inoremap <Down> <NOP>
    inoremap <Left> <NOP>
    inoremap <Right> <NOP>
    noremap <Up> <NOP>
    noremap <Down> <NOP>

    " Позволяем передвигаться с помощью hjkl в Insert mode зажав <Ctrl> {
    imap <C-h> <C-o>h
    imap <C-j> <C-o>j
    imap <C-k> <C-o>k
    imap <C-l> <C-o>l
" }

" ,v {
    " Pressing ,v opens the vimrc file in a new tab {
    nmap <leader>v :tabedit $MYVIMRC<CR>
" }

" <C-s> for saving file {
    nmap <C-s> :w<CR>
    imap <silent> <C-s> <Esc>:w<CR>a
" }

" <C-w> to close the current buffer {
    nmap <silent> <C-w> :bdelete<CR>
" }

" key mapping for tab navigation {
    nmap <Tab> gt
    nmap <S-Tab> gT
" }

"Key mapping for textmate-like indentation {
    nmap <D-[> <<
    nmap <D-]> >>
    vmap <D-[> <gv
    vmap <D-]> >gv
" }

cmap w!! %!sudo tee > /dev/null % " save file with root permissions

" <C-F11> {
    " Toggle line numbers type http://stackoverflow.com/questions/4387210/vim-how-to-map-two-tasks-under-one-shortcut-key
    let g:relativenumber = 0
    function! ToogleRelativeNumber()
      if g:relativenumber == 0
        let g:relativenumber = 1
        set norelativenumber
        set number
      elseif g:relativenumber == 1
        let g:relativenumber = 2
        set nonumber
        set relativenumber
      else
        let g:relativenumber = 0
        set nonumber
        set norelativenumber
      endif
    endfunction
    map <C-F11> :call ToogleRelativeNumber()<cr>
" }

" <Space> = <PageDown> Как в браузерах {
    nmap <Space> <PageDown>
" }



" ===================================================================
" Плагины
" ===================================================================

call pathogen#helptags()
call pathogen#runtime_append_all_bundles() " Сначала запускаем бандл, а затем настраиваем плагины

" Solarized {
    set t_Co=16
    if has("gui_running")
        set t_Co=256
        let g:solarized_termcolors=256
    endif

    syntax enable
    set background=dark
    colorscheme solarized
    call togglebg#map("<leader>b") " По нажатию ,b переключает фон и подсветку синтаксиса ч-б/б-ч
" }

" FuzzyFinder {
    nnoremap <silent> ffb :FufBuffer<CR>
    nnoremap <silent> fff :FufFile<CR>
    nnoremap <silent> ffd :FufDir<CR>
    nnoremap <silent> ffj :FufJumpList<CR>
" }

" NERDTree {
    nmap <leader>n :NERDTreeToggle<CR>
    let NERDTreeShowBookmarks=1
    let NERDTreeChDirMode=0
    let NERDTreeQuitOnOpen=1
    let NERDTreeShowHidden=1
    let NERDTreeKeepTreeInNewTab=1
" }

" NERDCommenter {
    " IDEA-like and TextMate-like comment shortcuts
    nmap <D-/> <Leader>c<space> " toggle line commenting
    vmap <D-/> <Leader>cc
" }
