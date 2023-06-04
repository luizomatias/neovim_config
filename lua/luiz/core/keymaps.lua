-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local api = vim.api -- for conciseness
---------------------
-- General Keymaps
---------------------

-- use jk to exit insert mode
keymap.set("i", "nnn", "<ESC>")

-- leave terminal mode
api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

-- tab
api.nvim_set_keymap("n", "<Tab>", "<cmd>BufferLineCycleNext<cr>", {})
api.nvim_set_keymap("n", "<leader><Tab>", "<cmd>BufferLineCyclePrev<cr>", {})
api.nvim_set_keymap("n", "<leader>cr", "<cmd>BufferLineCloseRight<cr>", {})
api.nvim_set_keymap("n", "<leader>cp", "<cmd>BufferLinePickClose<cr>", {})
api.nvim_set_keymap("n", "<leader>cl", "<cmd>BufferLineCloseLeft<cr>", {})
-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close currlit window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

--terminl
keymap.set("n", "<leader>tt", ":terminal<CR>") --  open terminal

----------------------
-- Plugin Keybinds
----------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>") -- list available help tags
api.nvim_set_keymap("n", "<leader>di", "<cmd>Telescope diagnostics<CR>", {}) -- open diagnostics

-- python debug
api.nvim_set_keymap("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", {}) -- open diagnostics
keymap.set("n", "<leader>dpr", "<cmd>lua require('dap-python').test_method()<cr>") -- Test Method DAP