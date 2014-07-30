call NERDTreeAddKeyMap({
       \ 'key': 'h',
       \ 'callback': 'NERDTreeGoHomeHandler',
       \ 'quickhelpText': 'Change root to CWD'})

function! NERDTreeGoHomeHandler()
    let cwd = getcwd()
    "call g:NERDTreePath.changeToDir(cwd)
    execute 'NERDTree' cwd
endfunction

