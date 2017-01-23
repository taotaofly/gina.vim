function! gina#command#lcd#define() abort
  return s:command
endfunction


" Instance -------------------------------------------------------------------
let s:command = {}

function! s:command.command(range, qargs, qmods) abort
  let git = gina#core#get_or_fail()
  let args = s:build_args(git, a:qargs)
  execute 'lcd' gina#util#fnameescape(args.params.path)
endfunction


" Private --------------------------------------------------------------------
function! s:build_args(git, qargs) abort
  let args = gina#command#args(a:qargs)
  let args.params = {}
  let args.params.path = args.pop(1, '.')

  if !empty(args.params.path)
    let args.params.path = gina#util#abspath(
          \ gina#util#expand(args.params.path)
          \)
  endif

  return args.lock()
endfunction
