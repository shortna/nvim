-- plugins
local Plug = vim.fn["plug#"]
vim.call("plug#begin")

-- lsp
Plug("neovim/nvim-lspconfig")
Plug("hrsh7th/nvim-cmp")
Plug("hrsh7th/cmp-nvim-lsp")
Plug("hrsh7th/cmp-path")
Plug("hrsh7th/cmp-buffer")
-- TS
Plug("nvim-treesitter/nvim-treesitter")
-- line
Plug("vim-airline/vim-airline")
-- align
Plug("vim-scripts/Align")
-- colors
Plug("catppuccin/nvim")
-- FuzzyFinder
Plug("nvim-lua/plenary.nvim")
Plug("nvim-telescope/telescope.nvim")
-- Git
Plug("tpope/vim-fugitive")

vim.call("plug#end")

local g = vim.g
local opt = vim.opt
local cmd = vim.cmd

-- basic stuff
opt.syntax = "enable"
opt.number = true
opt.relativenumber = true

opt.colorcolumn = "80"
opt.wrap = false
opt.cursorline = true
opt.cursorlineopt = "both"
opt.mouse = ""
opt.hlsearch = true
opt.incsearch = true
opt.swapfile = false
opt.hidden = true
opt.termguicolors = true
opt.wrapscan = false

-- fold stuff
vim.wo.foldmethod = 'manual'
opt.foldenable = false

-- indent stuff
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.cindent = true
opt.cinoptions = "1s"

-- menu stuff
opt.wildmenu = true
opt.wildmode = 'full'
opt.wildoptions = ''

-- do not let quckifix to spawn where it wants
opt.switchbuf = "useopen"

-- remove numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    opt.relativenumber = false
    opt.number = false
  end
})

-- vim doesnt like compound literals
g.c_no_curly_error = true

-- mappings
g.mapleader = " "

vim.keymap.set('n', '<Leader>e', '<Cmd>Ex<CR>', { nowait = true, silent = true })
vim.keymap.set('n', '<Tab>', '<Cmd>bnext<CR>', { nowait = true, silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>bprevious<CR>', { nowait = true, silent = true })
vim.keymap.set('n', '<Leader>l', '<Cmd>ls<CR>', { nowait = true, silent = true })
vim.keymap.set('t', '<S-Tab>', '<C-\\><C-n>', { nowait = true })

local builtin = require('telescope.builtin')
local function man_pages()
  return builtin.man_pages({sections = {"2", "3"} });
end

vim.keymap.set('n', '<leader>gs', builtin.grep_string, { desc = 'Grep string under cursor' })
vim.keymap.set('n', '<leader>gl', builtin.live_grep, { desc = 'Grep' })
vim.keymap.set('n', '<leader>fm', man_pages, { desc = 'Find Man' })
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find file' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find buffer' })

-- man pages highlight links and i do not want this
cmd("highlight! link manItalic none");
-- highlight todo
vim.api.nvim_set_hl(0, '@text.note', { link = 'Todo' })

g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0
