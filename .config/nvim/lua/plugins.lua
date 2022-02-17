-- https://github.com/wbthomason/packer.nvim#quickstart
-- git clone https://github.com/wbthomason/packer.nvim\
-- ~/.local/share/nvim/site/pack/packer/start/packer.nvim

-- This file can be loaded by calling `lua require('plugins')` from your init.vim
vim.api.nvim_set_keymap("n", "gtd", ":Neorg keybind norg core.norg.qol.todo_items.todo.task_done", { silent = true })
vim.api.nvim_set_keymap("n", "gtu", ":Neorg keybind norg core.norg.qol.todo_items.todo.task_undone", { silent = true })
vim.api.nvim_set_keymap("n", "gtp", ":Neorg keybind norg core.norg.qol.todo_items.todo.task_pending", { silent = true })
vim.api.nvim_set_keymap("n", "gtt", ":Neorg keybind norg core.norg.qol.todo_items.todo.task_cycle", { silent = true })

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
--   -- Packer can manage itself
--   use 'wbthomason/packer.nvim'
--   -- support
--   use 'nvim-lua/plenary.nvim'
--   -- function
--   use 'preservim/nerdtree'
--   use 'rbgrouleff/bclose.vim'
--   use 'francoiscabrol/ranger.vim'
--   use { 'vhyrro/neorg', requires = { 'nvim-lua/plenary.nvim' }, config = function()
-- 	  require('neorg').setup {
-- 		  load = {
-- 		  	["core.defaults"] = {}, -- Load all the default modules
-- 		  	["core.norg.concealer"] = {} -- Enhances the text editing experience by using icons
-- 		  },
-- 		  -- Tells neorg where to load community provided modules. If unspecified, this is the default
-- 		  community_module_path = vim.fn.stdpath("cache") .. "/neorg_community_modules"
-- 	}
--   end}
--   -- input
--   use 'tpope/vim-surround'
--   use 'preservim/nerdcommenter'
--   use 'terryma/vim-multiple-cursors'
--   -- appearance
--   use 'itchyny/lightline.vim'
--   use 'joshdick/onedark.vim'
--   use 'drewtempelmeyer/palenight.vim'
--   use 'Yggdroot/indentLine'
--   -- language support
--   use 'neovim/nvim-lspconfig'
end)
