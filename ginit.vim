if exists('g:fvim_loaded')
  " good old 'set guifont' compatibility with HiDPI hints...
  if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
    set guifont=Iosevka:h19
  else
    set guifont=Iosevka:h32
  endif

  FVimFontNoBuiltinSymbols v:false
  FVimFontAutoSnap v:true

  FVimFontNormalWeight 500
  FVimFontBoldWeight 800

  FVimUIPopupMenu v:true

  FVimCursorSmoothMove v:true
  FVimCursorSmoothBlink v:true

  " Ctrl-ScrollWheel for zooming in/out
  nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
  nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
  nnoremap <F11> :FVimToggleFullScreen<CR>
endif
