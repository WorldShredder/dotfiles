local o = vim.opt

-- General
o.number = true -- Line numbers
o.relativenumber = true -- Relative line numbers
o.cursorline = true -- Highlight current line
o.ruler = true -- Show row/col of current line
o.syntax = 'on' -- Syntax highlighting
o.scrolloff = 10 -- Vertical scroll ceiling
o.sidescrolloff = 5 -- Horizontal scroll ceiling
o.encoding = 'UTF-8' -- Default encoding
o.spelllang = { 'en' } -- Lang for spellcheck
o.modeline = false

-- User Interface
o.showmatch = true -- Show matching brackets
o.termguicolors = true -- Enable terminal GUI colors
o.foldenable = false -- Disable auto-folding
o.title = true -- Set window title to value of titlestring
o.signcolumn = 'yes' -- Always show sign column
o.cmdheight = 0 -- Hide commandline by default
o.completeopt = 'menuone,noinsert,noselect' -- see docs

-- Indentation
o.autoindent = true -- Maintain indent levels
o.expandtab = true -- Expand TAB to spaces
o.shiftwidth = 4 -- Number of spaces per indent level
o.tabstop = 4 -- Number of spaces per TAB char
o.smartindent = true -- Smart auto indentation
o.grepprg = 'rg --vimgrep' -- Use ripgrep if available

-- Behavior
o.clipboard:append('unnamedplus') -- Enable system clipboard
o.mouse = 'a' -- Enable mouse in (a)ll modes
o.ttimeoutlen = 250 -- Keymap timeout (ms)
o.splitright = true -- New v-pane right
o.splitbelow = true -- New h-pane below
o.errorbells = false -- No error sounds
o.backspace = 'indent,eol,start' -- Normal backspace
o.autochdir = false -- Keep current directory
o.iskeyword:append('-') -- Treat hyphen as word token
o.path:append('**') -- Recursive search with `gf`
o.modifiable = true -- Editable buffers

-- Search
o.ignorecase = true -- Case insensitive search
o.smartcase = true -- Case sensitive on uppcase
o.hlsearch = false -- Disable search highlights
o.incsearch = true -- Show incremental matches

-- Commandline
o.wildmenu = true -- Enhanced command-line completion
o.wildmode = 'longest:full,full' -- Completion mode for command-line
o.wildignorecase = true -- Case-insensitive tab completion
o.showcmd = true -- Show last command in status line
o.inccommand = 'split' -- Show :substitute, :smagic, :command-preview, etc

-- File Handling
o.backup = false -- No backup files
o.writebackup = false -- No backup before overwrite
o.swapfile = false -- No swap files
o.autowrite = false -- No autosave
o.diffopt:append(
    'vertical' -- Vertical diff split
)
o.diffopt:append(
    'algorithm:patience' -- Better diff algo
)
o.diffopt:append(
    'linematch:60' -- Smart line matching
)
o.hidden = true -- Hide abandoned buffers
