local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('numToStr/Comment.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
vim.call('plug#end')

require('Comment').setup()

-- Ctrl+p to find files
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })

-- Ctrl+Backspace: Delete previous word
vim.keymap.set('i', '<C-H>', '<C-w>')

-- Ctrl+Delete: Delete next word  
vim.keymap.set('i', '<C-Del>', '<C-o>dw')

vim.opt.termguicolors = true

-- Map Ctrl+/ for both single line and visual selection
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-/>', 'gc', { remap = true })

-- Make tab 4 spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Show line number
vim.opt.number = true

-- Remove highlighted text with escape
vim.keymap.set('n', '<esc>', '<cmd>noh<cr><esc>', { silent = true })

-- Stop breaking line between a word
vim.opt.linebreak = true

-- Navigate visual lines
vim.keymap.set('n', 'j', 'gj', { noremap = true })
vim.keymap.set('n', 'k', 'gk', { noremap = true })

-- Copy to system clipboard
vim.opt.clipboard = 'unnamedplus'

-- Hiding cursor position indicator
vim.opt.ruler= false

-- Leader key
vim.g.mapleader = " "

-- Run the current file
vim.api.nvim_create_user_command(
  'Run',
  function()
    local filetype = vim.bo.filetype
    local interpreters = {
      python = 'python',
      javascript = 'bun',
      ruby = 'ruby',
      haskell = 'runghc',
      sml = 'sml',
      c = 'gcc',
    }

    local interpreter = interpreters[filetype]

    if not interpreter then
      print('File type not supported')
      return
    end

    local file = vim.fn.expand('%:p')
    local filename = vim.fn.fnamemodify(file, ':t')
    local command = string.format('!%s ./%s', interpreter, filename)

    vim.cmd('silent w')

    -- Compile and run if using C
    if interpreter == 'gcc' then
        vim.cmd('!gcc ' .. filename .. ' -o a && ./a')
        return
    end

    -- Pipe the input if solving algorithms
    if file == vim.fn.expand('/home/alabhya/Desktop/algorithms/main.py') then
      vim.cmd('!cat input.txt | python main.py')
      return
    end

    vim.cmd(command)
  end,
  {}
)

-- Shortcut to trigger file run
vim.api.nvim_set_keymap('n', '<Leader>r', ':Run<CR>', { silent = true })

-- Shortcut to save and quit
vim.api.nvim_set_keymap('n', '<Leader>q', ':wqa<CR>', { noremap = true, silent = true })

