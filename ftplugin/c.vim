setlocal makeprg=g++\ %\ -o\ %:t:r

function! CRun(...)
    update
	let e = 0
	if getftime(expand("%:r")) < getftime(expand("%"))
		make
		let e = v:shell_error
	endif
	if e == 0
		let idx = 1
		let arg = ""
		while idx <= a:0
			execute "let a = a:" . idx
			let arg = arg . ' ' . a
			let idx = idx + 1
		endwhile
        execute "!./" . expand("%:r") . " " . arg
	endif
endfunction
command! -nargs=* Run call CRun(<f-args>)
