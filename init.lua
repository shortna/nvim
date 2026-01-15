local vim = vim
local g = vim.g
local opt = vim.opt
local Plug = vim.fn['plug#']

vim.call('plug#begin')
Plug('tjdevries/colorbuddy.nvim')
Plug("jesseleite/nvim-noirbuddy")
Plug("Saghen/blink.cmp")
Plug("nvim-lua/plenary.nvim")
Plug("RRethy/base16-nvim")
Plug("nvim-telescope/telescope.nvim")
Plug("mbbill/undotree")
Plug("jpalardy/vim-slime")
Plug("nvim-treesitter/nvim-treesitter")
Plug('nyoom-engineering/oxocarbon.nvim')
Plug("tpope/vim-fugitive")
vim.call('plug#end')

local telescope_builtin = require("telescope.builtin");
g.mapleader = " "
vim.keymap.set('n', '<Leader>ve', '<Cmd>Ex<CR>', { silent = true })
vim.keymap.set('n', '<Tab>', '<Cmd>bnext<CR>', { silent = true })
vim.keymap.set('n', '<S-Tab>', '<Cmd>bprevious<CR>', { silent = true })
vim.keymap.set('n', '<Leader>vbl', '<Cmd>ls<CR>', { silent = true })
vim.keymap.set('t', '<S-Tab>', '<C-\\><C-n>', { nowait = true })

vim.keymap.set('n', '<leader>tgs', telescope_builtin.grep_string, { desc = 'Grep string under cursor' })
vim.keymap.set('n', '<leader>tgl', telescope_builtin.live_grep, { desc = 'Grep' })
vim.keymap.set('n', '<leader>tff', telescope_builtin.find_files, { desc = 'Find file' })
vim.keymap.set('n', '<leader>tfb', telescope_builtin.buffers, { desc = 'Find buffer' })
vim.keymap.set('n', '<leader>ut', vim.cmd.UndotreeToggle)

vim.keymap.set('n', '<leader>mu', ':m-2<CR>')
vim.keymap.set('n', '<leader>md', ':m+1<CR>')

vim.keymap.set('v', '<leader>mu', [[:m'<-2<CR>gv=gv]])
vim.keymap.set('v', '<leader>md', [[:m'>+1<CR>gv=gv]])

vim.keymap.set('n', '<leader>dv', [["_dd]])
vim.keymap.set('n', '<leader>yp', [["+yy]])

-- basic stuff
opt.syntax = "enable"
opt.number = true
opt.relativenumber = true

opt.colorcolumn = "120"
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
opt.foldmethod = "indent"
opt.foldenable = true

-- indent stuff
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4

-- menu stuff
opt.wildmenu = true
opt.wildmode = 'full'
opt.spell = true
opt.spelllang = "en_us"

-- remove numbers in terminal
vim.api.nvim_create_autocmd('TermOpen', {
    callback = function()
        opt.relativenumber = false
        opt.number = false
    end
})
-- vim doesn't like compound literals
g.c_no_curly_error = true

-- persistent undo
opt.undofile = true

-- if file changed outside of vim reread it
opt.autoread = true
opt.fixendofline = false

-- lua is enough
g.loaded_node_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
g.loaded_python3_provider = 0

-- netrw
g.netrw_winsize = 30
g.netrw_banner = 0

vim.cmd("colorscheme base16-everforest-dark-hard")
