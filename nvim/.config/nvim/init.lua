-- Leader key
vim.g.mapleader = " "

vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
        vim.opt_local.spell = true
    end,
})

local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('numToStr/Comment.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('jiangmiao/auto-pairs')
Plug('nvim-lualine/lualine.nvim')
Plug('folke/tokyonight.nvim')
vim.call('plug#end')

-- Function to set colorscheme based on background
local function set_colorscheme_by_background()
  if vim.o.background == 'dark' then
    vim.cmd[[colorscheme tokyonight]]
  else
    vim.cmd[[colorscheme tokyonight-day]]
  end
end

-- Set initial colorscheme
set_colorscheme_by_background()

-- Auto-update when background changes
vim.api.nvim_create_autocmd("OptionSet", {
  pattern = "background",
  callback = set_colorscheme_by_background,
})

require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        -- Close file picker
        ["<C-[>"] = require('telescope.actions').close,
      },
    }
  }
})

require('Comment').setup()
require('lualine').setup({
    options = {
        component_separators = {left = '', right = ''},
        section_separators = {left = '', right = ''}
    },
    sections = {
        lualine_b = {},
        lualine_x = {}
    }
})

-- Hide the mode since it's shown by lualine
vim.opt.showmode = false

vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>', { desc = 'Find files' })

-- Highlight the current line number
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

-- Don't comment the next line automatically
 vim.cmd([[autocmd FileType * set formatoptions-=ro]])

vim.opt.termguicolors = true

-- Map Ctrl+/ for both single line and visual selection
vim.keymap.set('n', '<C-/>', 'gcc', { remap = true })
vim.keymap.set('v', '<C-/>', 'gc', { remap = true })
vim.keymap.set('i', '<C-/>', '<Esc>gcca', { remap = true })

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
      rust = 'cargo'
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

    if interpreter == 'cargo' then
        vim.cmd('!cargo run')
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

