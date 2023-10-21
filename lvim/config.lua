-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny



lvim.colorscheme = 'gruvbox'

lvim.plugins = {
  {'tpope/vim-rsi'},

  {"justinmk/vim-sneak"},

  {'dwcoates/project-term'},

  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },

  {
  'marko-cerovac/material.nvim',
    priority = 1010,
    config = function()
      vim.cmd.colorscheme 'material'
      vim.g.material_style = "deep ocean"
      -- require('material').set()
    end
  },

  {'mbbill/undotree'},

  {'ThePrimeagen/harpoon'},

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    'christoomey/vim-tmux-navigator',
    event = 'VimEnter',  -- Load on VimEnter event
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  { 'glepnir/dashboard-nvim' },
}

vim.g.material_style = "darker" -- Choose your style: 'darker', 'lighter', 'palenight', 'oceanic', etc.

-- require('material').setup({
--   contrast = true,
--   borders = false,
--   -- ... (other configurations)
-- })

-- Then set the colorscheme
--vim.cmd[[colorscheme material]]



-- require('nvim-treesitter.config').setup {
--   ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'vimdoc', 'vim' },

--   auto_install = true,

--   highlight = { enable = true },
--   indent = { enable = true },
--   incremental_selection = {
--     enable = true,
--     keymaps = {
--       init_selection = '<c-space>',
--       node_incremental = '<c-space>',
--       scope_incremental = '<c-s>',
--       node_decremental = '<M-space>',
--     },
--   },
--   textobjects = {
--     select = {
--       enable = true,
--       lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
--       keymaps = {
--         -- You can use the capture groups defined in textobjects.scm
--         ['aa'] = '@parameter.outer',
--         ['ia'] = '@parameter.inner',
--         ['af'] = '@function.outer',
--         ['if'] = '@function.inner',
--         ['ac'] = '@class.outer',
--         ['ic'] = '@class.inner',
--       },
--     },
--     move = {
--       enable = true,
--       set_jumps = true, -- whether to set jumps in the jumplist
--       goto_next_start = {
--         [']m'] = '@function.outer',
--         [']]'] = '@class.outer',
--       },
--       goto_next_end = {
--         [']M'] = '@function.outer',
--         [']['] = '@class.outer',
--       },
--       goto_previous_start = {
--         ['[m'] = '@function.outer',
--         ['[['] = '@class.outer',
--       },
--       goto_previous_en = {
--         ['[M'] = '@function.outer',
--         ['[]'] = '@class.outer', 
--       },
--     },
--     swap = {
--       enable = true,
--       swap_next = {
--         ['<leaer>a'] = '@parameter.inner',
--       },
--       swap_previous = {
--         ['<leader>A'] = '@parameter.inner',
--       },
--     },
--   },
-- }

lvim.keys.normal_mode["<leader>sP"] = ":Telescope projects<CR>"

-- Keep cursor in middle of screen when using C-d/C-u
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

-- Move selected lines down or up in visual mode
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

-- Telescope keybinding to find recently opened files
lvim.keys.normal_mode["<leader>r"] = ":Telescope recentfiles<CR>"
lvim.keys.normal_mode["<leader>x"] = ":Telescope buffers<CR>"
-- lvim.keys.visual_mode["<leader>x"] = [[":lua <C-r>"<CR>"]] --FIXME: This doesn't work

-- Diagnostic keymaps
lvim.keys.normal_mode["[d"] = ":lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["]d"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["<leader>e"] = ":lua vim.diagnostic.open_float()<CR>"
lvim.keys.normal_mode["<leader>q"] = ":lua vim.diagnostic.setloclist()<CR>"
lvim.keys.normal_mode["<leader>b"] = ':Telescope current_buffer_fuzzy_find<CR>'


lvim.keys.normal_mode["gR"] = ":Telescope lsp_references<CR>"

-- local cmp = require'cmp'
-- cmp.setup({
--   mapping = {
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },
-- })

-- Harpoon keymaps
lvim.keys.normal_mode["<leader>hm"] = ":lua require('harpoon.mark').add_file()<CR>"
lvim.keys.normal_mode["<leader>ht"] = ":lua require('harpoon.ui').toggle_quick_menu()<CR>"
-- require('harpoon.ui').swap()

-- Add 'dofile ("/path/to/this/file")' to ~/.config/lvim/config.lua to use this file
-- https://fnune.com/2021/11/20/nuking-most-of-my-vimrc-and-just-using-lunarvim/
vim.opt.cmdheight = 2 -- more space in the neovim command line for displaying messages
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hidden = true -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = false -- highlight all matches on previous search pattern
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.smartcase = true -- smart case
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.wrap = false -- display lines as one long line
vim.opt.relativenumber = true -- Show line numbers relative to the current line
vim.opt.number = true -- Show the actual current line number
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2 -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2 -- insert 2 spaces for a tab

vim.cmd([[
  " Make j & k behave as expected in line wrap mode
  nnoremap j gj
  nnoremap k gk
  " H and L go to the top and bottom of the screen. This makes them play nicely 
  " with scrolloff.
  nnoremap H H7k
  vnoremap H H7k
  nnoremap L L7j
  vnoremap L L7j
  " Map enter to ':' (Begin and end commands with the same key) (except in the
  " quickfix window)
  nnoremap <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : ':'
]])

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.cpp", "*.h" },
  -- Set tab size to 4 for cpp files
  command = "setlocal ts=4 sw=4",
})

lvim.builtin.treesitter.indent = { enable = true, disable = { "cpp" } }
-- <Leader>; maps to dashboard by default, change that command to be <Leader> = instead
-- lvim.builtin.which_key.mappings["="] = lvim.builtin.which_key.mappings[";"]

-- Append ; to line with <Leader>; and use which_key_ignore to hide it from the menu
lvim.builtin.which_key.mappings[";"] = { "mvA;<ESC>`v", "which_key_ignore" }
-- Replace word under cursor with <Leader>r and use which_key_ignore to hide it from the menu
lvim.builtin.which_key.mappings["r"] = { "ciw", "which_key_ignore" }
lvim.builtin.which_key.mappings["t"] = { ":ClangdSwitchSourceHeader<CR>", "Toggle source/header" }
lvim.builtin.which_key.mappings["h"] = { "<cmd>set hlsearch!<CR>", "Toggle Highlight" }
-- Set filetypes that are autoformatted on save
lvim.format_on_save = {
  pattern = "*.lua"
}
--TODO: Detect os, then use + clipboard on linux
-- Move packer from leaderp to leaderP
lvim.builtin.which_key.mappings["P"] = lvim.builtin.which_key.mappings["p"]
lvim.builtin.which_key.mappings["y"] = { '"*y', "Copy to system clipboard" }
lvim.builtin.which_key.vmappings["y"] = { '"*y', "Copy to system clipboard" }
lvim.builtin.which_key.mappings["p"] = { '"*p', "Paste from system clipboard" }
-- Go to next merge conflict marker
-- Currently >>>> is not included because it occurs in template-heavy C++ code
-- Need to use <BAR> since vim sees | as command separator when parsing .vimrc
lvim.builtin.which_key.mappings["n"] = { "j/\\V\\(<<<<\\)\\|\\(====\\)\\|\\(||||\\)<CR>", "which_key_ignore" }
lvim.builtin.which_key.mappings["N"] = { "k?\\V\\(<<<<\\)\\|\\(====\\)\\|\\(||||\\)<CR>", "which_key_ignore" }
lvim.lsp.buffer_mappings.normal_mode['gh'] = { vim.lsp.buf.hover, "LSP Hover" }
lvim.lsp.installer.setup.automatic_installation = true
-- Define a function to execute the selected text as Lua code
function send_to_lua()
    -- Yank the selected text into the unnamed register
    vim.cmd('y')
    
    -- Get the yanked text from the unnamed register
    local code = vim.fn.getreg('"')
    
    -- Load and execute the code
    local func, err = load(code)
    if func then
        local ok, result = pcall(func)
        if ok then
            print("Result:", result)
        else
            print("Execution error:", result)
        end
    else
        print("Load error:", err)
    end
end

vim.cmd("command! -range SendToLua lua send_to_lua()")

lvim.keys.visual_mode["<leader>L"] = ":SendToLua<CR>"

lvim.builtin.telescope.defaults.layout_config.width = 0.60
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75


vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

vim.o.autochdir = true

require('projectterm')

lvim.keys.normal_mode["<leader>X"] = ":ProjectTerm<CR>"

vim.api.nvim_set_keymap('n', '<leader>km', '<cmd>lua require("telescope.builtin").keymaps({ layout_config = { width = 0.7, height = 0.5 }, color_devicons = true, sorting_strategy = "ascending" })<CR>', { noremap = true, silent = true, desc = "Show keymaps" })

-- lvim.builtin.which.key_mappings["d"] = ":echo 'hello, world'"

lvim.builtin.which_key.mappings["s"]["r"] = { ":Telescope lsp_references<CR>", "Symbol References" }

