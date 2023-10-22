-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  {'tpope/vim-rsi'},

  {"justinmk/vim-sneak"},

  {"tpope/vim-surround"},

  {'dwcoates/project-term'},
  {'dwcoates/project-session'},

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

vim.g.material_style = "deep ocean" -- Choose your style: 'darker', 'lighter', 'palenight', 'oceanic', etc.

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


-- Harpoon keymaps
lvim.keys.normal_mode["<leader>hm"] = ":lua require('harpoon.mark').add_file()<CR>"
lvim.keys.normal_mode["<leader>ht"] = ":lua require('harpoon.ui').toggle_quick_menu()<CR>"

-- Add 'dofile ("/path/to/this/file")' to ~/.config/lvim/config.lua to use this file
-- https://fnune.com/2021/11/20/nuking-most-of-my-vimrc-and-just-using-lunarvim/
vim.opt.cmdheight = 1 -- more space in the neovim command line for displaying messages
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

-- Go to next merge conflict marker
-- Currently >>>> is not included because it occurs in template-heavy C++ code
-- Need to use <BAR> since vim sees | as command separator when parsing .vimrc
lvim.builtin.which_key.mappings["n"] = { "j/\\V\\(<<<<\\)\\|\\(====\\)\\|\\(||||\\)<CR>", "which_key_ignore" }
lvim.builtin.which_key.mappings["N"] = { "k?\\V\\(<<<<\\)\\|\\(====\\)\\|\\(||||\\)<CR>", "which_key_ignore" }

lvim.lsp.installer.setup.automatic_servers_installation = true

lvim.builtin.which_key.mappings["/"] = { ":Telescope current_buffer_fuzzy_find<CR>", "Search buffer text" }
lvim.builtin.which_key.mappings["?"] = { ":Telescope lsp_document_symbols<CR>", "Search buffer symbols" }

-- Define a function to execute the selected text as Lua code
local function send_to_lua()
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

lvim.builtin.telescope.defaults.layout_config.width = 0.60
lvim.builtin.telescope.defaults.layout_config.preview_cutoff = 75

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', { noremap = true, silent = true })

-- FIXME:
-- vim.builtin.lsp.mappings["g"]["d"] = { ':echo "hello, world"<CR>', "Goto Definon!" }

vim.api.nvim_set_keymap('n', '<leader>t', ':t<CR>', { noremap = true, silent = true })

vim.o.autochdir = true

require('projectterm')
require('project-session')

lvim.keys.normal_mode["<leader>X"] = ":ProjectTerm<CR>"

vim.api.nvim_set_keymap('n', '<leader>km', '<cmd>lua require("telescope.builtin").keymaps({ layout_config = { width = 0.7, height = 0.5 }, color_devicons = true, sorting_strategy = "ascending" })<CR>', { noremap = true, silent = true, desc = "Show keymaps" })

-- lvim.builtin.which.key_mappings["d"] = ":echo 'hello, world'"

lvim.builtin.which_key.mappings["s"]["r"] = { ":Telescope lsp_references<CR>", "Symbol References" }

function toggle_lazygit()
  local Terminal = require('toggleterm.terminal').Terminal
  local lazygit = Terminal:new({
    cmd = "lazygit",
    hidden = true,
    direction = 'float',
    float_opts = {
      border = 'curved',
      width = 220,
      height = 60
    },
-- require('harpoon.ui').swap()
    on_open = function(term)
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>lua toggle_lazygit()<CR>', { noremap = true, silent = true })
    end,
  })
  lazygit:toggle()
end
vim.cmd("command! LazyGit lua toggle_lazygit()")
lvim.builtin.which_key.mappings["g"]["g"] = { ":LazyGit<CR>", "LazyGit Status" }

lvim.builtin.which_key.mappings["f"] = { ":Telescope git_files<CR>", "Search Project Files" }

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "javascript", "rust", "zig", "cpp", "json", "yaml", "bash" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  -- auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = {},

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    --
    -- disable = { "c", "rust" },
    --
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    -- disable = function(lang, buf)
    --     local max_filesize = 100 * 1024 -- 100 KB
    --     local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
    --     if ok and stats and stats.size > max_filesize then
    --         return true
    --     end
    -- end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
