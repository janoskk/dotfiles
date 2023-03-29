call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'tpope/vim-sensible'
if (!exists('g:vscode'))
  Plug 'morhetz/gruvbox'

  Plug 'nvim-lualine/lualine.nvim'
  " Icons for lualine
  Plug 'kyazdani42/nvim-web-devicons'
endif

" Initialize plugin system
" - Automatically executes `filetype plugin indent on` and `syntax enable`.
call plug#end()
  
" Only if not loaded by `VSCode Neovim`
if (!exists('g:vscode'))
  "Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
  "If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
  "(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
  if (empty($TMUX))
    if (has("nvim"))
      "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    endif
    "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
    "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
    " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
    if (has("termguicolors"))
      set termguicolors
    endif
  endif
  
  " Set color scheme by terminal settings
  if ($DARK_TERM_THEME == "0")
      set bg=light
  else
      set bg=dark
  endif
  try
      colorscheme gruvbox
  catch
  endtry

  " Setup enhanced status line
  lua require('lualine').setup { options = { theme = 'gruvbox' } }
endif

" Set indent to two spaces
set autoindent expandtab tabstop=2 shiftwidth=2

