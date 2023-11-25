-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Discord: https://discord.com/invite/Xb9B4Ny

lvim.plugins = {
  { 'tpope/vim-rsi' },

  -- {
  --   'sainnhe/gruvbox-material',
  --   priority = 1010,
  --   config = function()
  --     vim.g.gruvbox_material_background = 'hard'      -- Options: 'soft', 'medium', 'hard'
  --     -- vim.g.gruvbox_material_foreground = 'hard'   -- Options: 'soft', 'medium', 'hard'
  --     vim.g.gruvbox_material_palette = 'material'     -- Options: 'material', 'mix', 'original'
  --     vim.g.gruvbox_material_enable_bold = 1          -- Options: 0, 1
  --     vim.g.gruvbox_material_dim_inactive_windows = 1 -- Options: 0, 1
  --     vim.g.gruvbox_material_visual = 'grey background'
  --     vim.g.gruvbox_material_menu_selection_background =
  --     'grey'                                     -- Options: 'grey', 'red', 'orange', 'yellow', 'green', 'aqua', 'blue', 'purple'
  --     vim.g.ruvbox_material_ui_contrast = 'high' -- Options: 'low', 'high'
  --     lvim.colorscheme = "gruvbox-material"
  --     require 'lualine'.setup { options = { theme = 'gruvbox-material' } }
  --   end
  -- },
  -- {
  --   'NLKNguyen/papercolor-theme',
  --   config = function()
  --     lvim.colorscheme = "papercolor"
  --   end
  -- },
  -- {
  --   'Mofiqul/dracula.nvim',
  --   config = function()
  --     lvim.colorscheme = "dracula"
  --   end
  -- },
  {
    'joshdick/onedark.vim',
    config = function()
      lvim.colorscheme = "onedark"
    end
  },
  { "justinmk/vim-sneak" },

  { "tpope/vim-surround" },

  { 'dwcoates/project-term' },
  { 'dwcoates/project-session' },

  { 'mbbill/undotree' },

  { 'ThePrimeagen/harpoon' },

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
      { 'j-hui/fidget.nvim',       tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    'christoomey/vim-tmux-navigator',
    event = 'VimEnter', -- Load on VimEnter event
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    -- dependencies = {
    --   'nvim-treesitter/nvim-treesitter-textobjects',
    -- },
    build = ':TSUpdate',
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    commit = "e1e670a", --- This is supposed to fix the cpp issue?
    config = function()
      require 'nvim-treesitter.configs'.setup {
        textobjects = {
          select = {
            enable = true,
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,
            keymaps = {
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["as"] = "@class.outer",
              ["is"] = "@class.inner",
              ["ac"] = "@conditional.outer",
              ["ic"] = "@conditional.inner",
              ["ad"] = "@loop.outer",
              ["id"] = "@loop.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["ia"] = "@parameter.inner",
              ["aa"] = "@parameter.outer",
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V',  -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
            include_surrounding_whitespace = true,
          },
          move = {
            enable = true,
            set_jumps = false, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]["] = "@function.outer",
              ["]f["] = "@function.outer",
              ["]d["] = "@loop.outer",
              ["]s["] = "@class.outer",
              ["]c["] = "@conditional.outer",
              ["]b["] = "@block.outer",
              ["]a["] = "@parameter.outer",
            },
            goto_next_end = {
              ["]]"] = "@function.outer",
              ["]f]"] = "@function.outer",
              ["]d]"] = "@loop.outer",
              ["]s]"] = "@class.outer",
              ["]c]"] = "@conditional.outer",
              ["]b]"] = "@block.outer",
              ["]a]"] = "@parameter.outer",
            },
            goto_previous_start = {
              ["[["] = "@function.outer",
              ["[f["] = "@function.outer",
              ["[d["] = "@loop.outer",
              ["[s["] = "@class.outer",
              ["[c["] = "@conditional.outer",
              ["[b["] = "@block.outer",
              ["[a]"] = "@parameter.outer",
            },
            goto_previous_end = {
              ["[]"] = "@function.outer",
              ["[f]"] = "@function.outer",
              ["[d]"] = "@loop.outer",
              ["[s]"] = "@class.outer",
              ["[c]"] = "@conditional.outer",
              ["[b]"] = "@block.outer",
              ["[a]"] = "@parameter.outer",
            },
            goto_next = {
              ["]F"] = "@function.outer",
              ["]C"] = "@conditional.outer",
              ["]D"] = "@loop.outer",
              ["]S"] = "@class.outer",
              ["]B"] = "@block.outer",
              ["]A"] = "@parameter.outer",
            },
            goto_previous = {
              ["[F"] = "@function.outer",
              ["[C"] = "@conditional.outer",
              ["[D"] = "@loop.outer",
              ["[S"] = "@class.outer",
              ["[B"] = "@block.outer",
              ["[A"] = "@parameter.outer",
            },
          },
          lsp_interop = {
            enable = true,
            border = 'none',
            peek_definition_code = {
              ["<leader>hdf"] = "@function.outer",
              ["<leader>hdc"] = "@class.outer",
              ["<leader>hda"] = "@parameter.outer",
            },
          },
        },
      }
    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
  },

  { 'glepnir/dashboard-nvim' },
}

lvim.keys.normal_mode["<leader>sP"] = ":Telescope projects<CR>"

-- turn off highlighting from a search after escape
vim.api.nvim_set_keymap('n', '<Esc>', '<Esc>:noh<CR>', { noremap = true, silent = true })

-- Keep cursor in middle of screen when using C-d/C-u
lvim.keys.normal_mode["<C-d>"] = "<C-d>zz"
lvim.keys.normal_mode["<C-u>"] = "<C-u>zz"

-- Move selected lines down or up in visual mode
lvim.keys.visual_mode["J"] = ":m '>+1<CR>gv=gv"
lvim.keys.visual_mode["K"] = ":m '<-2<CR>gv=gv"

function OpenTelescopeBuffers()
  vim.cmd("Telescope buffers")
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, false, true), "n", true)
end

-- Bind the function to a key, e.g., <leader>b
-- Telescope keybinding to find recently opened files
lvim.keys.normal_mode["<leader>x"] = ":lua OpenTelescopeBuffers()<CR>"
lvim.keys.normal_mode["<leader>r"] = ":Telescope recentfiles<CR>"

-- lvim.builtin.which_key.mappings["r"] = { ":Telescope recentfiles<CR>", "Recent Files" } --FIXME: should replace impl above
-- lvim.keys.visual_mode["<leader>x"] = [[":lua <C-r>"<CR>"]] --FIXME: This doesn't work

-- Diagnostic keymaps
lvim.keys.normal_mode["[d"] = ":lua vim.diagnostic.goto_prev()<CR>"
lvim.keys.normal_mode["]d"] = ":lua vim.diagnostic.goto_next()<CR>"
lvim.keys.normal_mode["<leader>e"] = ":lua vim.diagnostic.open_float()<CR>"
lvim.keys.normal_mode["<leader>q"] = ":lua vim.diagnostic.setloclist()<CR>"

lvim.builtin.which_key.mappings["s"]["r"] = { ":Telescope lsp_references<CR>", "Symbol References" }

vim.api.nvim_create_augroup("AutoFormatAfterSurround", { clear = true })

vim.api.nvim_create_autocmd({ "TextChanged", "InsertLeave" }, {
  group = "AutoFormatAfterSurround",
  callback = function()
    -- Check if LSP is attached and formatting is supported
    local clients = vim.lsp.buf_get_clients()
    for _, client in pairs(clients) do
      if client.resolved_capabilities and client.resolved_capabilities.document_formatting then
        -- Trigger LSP formatting
        vim.lsp.buf.formatting_sync()
        break
      end
    end
  end
})

vim.api.nvim_create_augroup("AutoReloadExternalChanges", { clear = true })
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = "AutoReloadExternalChanges",
  pattern = "*",
  callback = function()
    if vim.fn.filereadable(vim.fn.expand('%')) == 1 then
      if vim.fn.getbufvar(vim.fn.bufnr('%'), '&mod') == 1 then
        return
      end
      local buf = vim.api.nvim_get_current_buf()
      local win = vim.api.nvim_get_current_win()
      -- Save the cursor position
      local cursor = vim.api.nvim_win_get_cursor(win)
      -- Reload the file
      vim.api.nvim_buf_call(buf, function()
        vim.cmd('silent! e!')
      end)
      -- Restore the cursor position
      vim.api.nvim_win_set_cursor(win, cursor)
    end
  end
})

-- Harpoon keymaps
lvim.keys.normal_mode["<leader>hm"] = ":lua require('harpoon.mark').add_file()<CR>"
lvim.keys.normal_mode["<leader>ht"] = ":lua require('harpoon.ui').toggle_quick_menu()<CR>"

-- Add 'dofile ("/path/to/this/file")' to ~/.config/lvim/config.lua to use this file
-- https://fnune.com/2021/11/20/nuking-most-of-my-vimrc-and-just-using-lunarvim/
vim.opt.cmdheight = 1          -- more space in the neovim command line for displaying messages
vim.opt.fileencoding = "utf-8" -- the encoding written to a file
vim.opt.hidden = true          -- required to keep multiple buffers and open multiple buffers
vim.opt.hlsearch = false       -- highlight all matches on previous search pattern
vim.opt.mouse = "a"            -- allow the mouse to be used in neovim
vim.opt.smartcase = true       -- smart case
vim.opt.termguicolors = true   -- set term gui colors (most terminals support this)
vim.opt.wrap = false           -- display lines as one long line
vim.opt.relativenumber = true  -- Show line numbers relative to the current line
vim.opt.number = true          -- Show the actual current line number
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.expandtab = true -- convert tabs to spaces
vim.opt.shiftwidth = 2   -- the number of spaces inserted for each indentation
vim.opt.tabstop = 2      -- insert 2 spaces for a tab

vim.cmd([[
  " Make j & k behave as expected in line wrap mode
  nnoremap j gj
  nnoremap k gk
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

vim.api.nvim_set_keymap('n', '<leader>km',
  '<cmd>lua require("telescope.builtin").keymaps({ layout_config = { width = 0.7, height = 0.5 }, color_devicons = true, sorting_strategy = "ascending" })<CR>',
  { noremap = true, silent = true, desc = "Show keymaps" })

-- lvim.builtin.which.key_mappings["d"] = ":echo 'hello, world'"

lvim.builtin.which_key.mappings["s"]["r"] = { ":Telescope lsp_references<CR>", "Symbol References" }

-- function toggle_lazygit()
--   local Terminal = require('toggleterm.terminal').Terminal
--   local lazygit = Terminal:new({
--     cmd = "lazygit",
--     hidden = true,
--     direction = 'float',
--     float_opts = {
--       border = 'curved',
--       width = 220,
--       height = 60
--     },
--     -- require('harpoon.ui').swap()
--     on_open = function(term)
--       vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>lua toggle_lazygit()<CR>', { noremap = true, silent = true })
--     end,
--   })
--   lazygit:toggle()
-- end
-- vim.cmd("command! LazyGit lua toggle_lazygit()")
-- lvim.builtin.which_key.mappings["g"]["g"] = { ":LazyGit<CR>", "LazyGit Status" }

lvim.builtin.which_key.mappings["f"] = { ":Telescope git_files<CR>", "Search Project Files" }

require 'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "typescript", "javascript", "rust", "zig", "cpp", "json",
    "yaml", "bash" },

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

lvim.builtin.cmp.setup = {
  enabled = true,
  preselect = vim.inspect(require('cmp').PreselectMode.Item),
  autocomplete = true,
  mapping = {
    confirm = "<CR>",
  },
}

require('lspconfig').bufls.setup {}

--FIXME: this breaks goto-xyz bindings. Is this even useful? Delete?
-- require('lspconfig').clangd.setup {
--   filetypes = { "c", "cpp" },
--   cmd = {
--     "clangd",
--     "--enable-config",
--     "--clang-tidy",
--   }
-- }

---FIXME: something interferring with this. Code runs, but highlight isn't changed. Hacky solution is to use `BufEnter` instead of `VimEnter`.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd('hi Visual guifg=#b6c0cf guibg=#313d4f')
    vim.cmd('hi Search guifg=#b6c0cf guibg=#313d4f')
  end,
})

-- vim.api.nvim_exec([[
-- augroup MyCustomHighlighting
--     autocmd!
--     autocmd VimEnter * hi Visual guifg=#02021c guibg=#656599
-- augroup END
--     autocmd VimEnter * hi Search guifg=#b6c0cf guibg=#080833
-- ]], false)

lvim.builtin.which_key.mappings["q"] = { ":qa<CR>" }

lvim.format_on_save.enabled = true
lvim.format_on_save.pattern = { "*.cpp", "*.h", "*.c", "*.lua", "*.py", "*.ts", "*.js", "*.go" }
