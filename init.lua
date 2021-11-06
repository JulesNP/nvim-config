-- If running from Windows, set shell to powershell
vim.cmd([[
if has('win32')
    set shell=powershell " Your shell must be powershell
    let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    set shellquote= shellxquote=
endif
]])

-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end

  augroup Comment
    autocmd FileType fsharp setlocal commentstring=//\ %s
  augroup end

  augroup Vista
    autocmd bufenter * if winnr("$") == 1 && vista#sidebar#IsOpen() | execute "normal! :q!\<CR>" | endif
  augroup end

  augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
  augroup end
]],
  false
)

local use = require("packer").use
require("packer").startup(function()
  use("wbthomason/packer.nvim") -- Packer itself

  -- tpope's plugins
  use("tpope/vim-commentary") -- "gc" to comment visual regions/lines
  use("tpope/vim-fugitive") -- Git commands in nvim
  use("tpope/vim-repeat") -- enable repeating supported plugin maps with "."
  use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
  use("tpope/vim-speeddating") -- use CTRL-A/CTRL-X to increment dates, times, and more
  use("tpope/vim-surround") -- quoting/parenthesizing made simple
  use("tpope/vim-unimpaired") -- Pairs of handy bracket mappings

  -- Themes
  use("gruvbox-community/gruvbox")
  use("joshdick/onedark.vim")
  use("overcache/NeoSolarized")

  -- UI to select things (files, grep results, open buffers...)
  use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
  use("liuchengxu/vista.vim") -- 🌵 Viewer & Finder for LSP symbols and tags
  -- ✅ Highlight, list and search todo comments in your projects
  use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
  -- A blazing fast and easy to configure neovim statusline written in pure lua
  use({ "hoob3rt/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
  -- Add indentation guides even on blank lines
  use("lukas-reineke/indent-blankline.nvim")
  -- Add git related info in the signs columns and popups
  use({ "lewis6991/gitsigns.nvim", requires = { "nvim-lua/plenary.nvim" } })
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
  -- Additional textobjects for treesitter
  use("nvim-treesitter/nvim-treesitter-textobjects")
  -- Collection of configurations for built-in LSP client
  use({ "neovim/nvim-lspconfig", "williamboman/nvim-lsp-installer" })
  use("hrsh7th/nvim-cmp") -- Autocompletion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use("hrsh7th/cmp-path")
  use("hrsh7th/cmp-buffer")
  use("hrsh7th/cmp-calc")
  use("hrsh7th/cmp-nvim-lua")
  use("hrsh7th/cmp-emoji")
  use("ray-x/cmp-treesitter")
  use("ray-x/lsp_signature.nvim")
  use("saadparwaiz1/cmp_luasnip")
  use("L3MON4D3/LuaSnip") -- Snippets plugin
  use("rafamadriz/friendly-snippets") -- Set of preconfigured snippets for different languages.
  use("onsails/lspkind-nvim") -- vscode-like pictograms for neovim lsp completion items
  use("norcalli/nvim-colorizer.lua") -- The fastest Neovim colorizer
  use("dstein64/nvim-scrollview") -- 📍A Neovim plugin that displays interactive vertical scrollbars.
  -- A file explorer tree for neovim written in lua
  use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
  use("akinsho/toggleterm.nvim") -- A neovim lua plugin to help easily manage multiple terminal windows.
  use("justinmk/vim-sneak") -- The missing motion for Vim 👟
  use("chaoren/vim-wordmotion") -- More useful word motions for Vim
  use("windwp/nvim-ts-autotag") -- Use treesitter to auto close and auto rename html tag
  use("windwp/nvim-autopairs") -- A super powerful autopair for Neovim. It supports multiple characters.
  use({
    "glacambre/firenvim",
    run = function()
      vim.fn["firenvim#install"](0)
    end,
  })
  use({ "ionide/Ionide-vim", run = "make fsautocomplete" })
  -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
  use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
end)

-- Show title
vim.o.title = true

-- Clipboard support
vim.o.clipboard = "unnamedplus"

-- Automatically load file changes from disk
vim.o.autoread = true

-- True color support
vim.o.termguicolors = true

--Incremental live completion (note: this is now a default on master)
vim.o.inccommand = "nosplit"

-- Number stuff
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.numberwidth = 2

--Do not save when switching buffers (note: this is now a default on master)
vim.o.hidden = true

--Enable mouse mode
vim.o.mouse = "a"

-- Setting colorcolumn. This is set because of
-- this (https://github.com/lukas-reineke/indent-blankline.nvim/issues/59)
-- indent-blankline bug.
vim.o.colorcolumn = "9999"

-- Keep 8 lines above/below cursor
vim.o.scrolloff = 3

--Save undo history
vim.opt.undofile = true

-- Indentation stuff
vim.o.breakindent = true
vim.o.smartindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Fix split behaviour how I like it
vim.o.splitbelow = true
vim.o.splitright = true

-- Since we have lualine, no need to show the mode twice
vim.o.showmode = false

-- Disable line numbers in terminal
vim.api.nvim_exec([[autocmd TermOpen * setlocal nonumber norelativenumber nobuflisted signcolumn=auto]], false)

-- Disable sign column in help
vim.api.nvim_exec([[autocmd FileType help setlocal signcolumn=auto]], false)

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = "yes"

-- Set font if running in firenvim
if vim.g.started_by_firenvim then
  vim.o.guifont = "Iosevka Term:h12"
else
  vim.o.guifont = "Iosevka:h16"
end

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.onedark_terminal_italics = 2
vim.g.gruvbox_italic = 1
vim.g.neosolarized_italic = 1
vim.cmd([[colorscheme gruvbox]])

-- Remove background colour if running on Windows Terminal (for transparency effect)
if os.getenv("WT_SESSION") then
  vim.cmd([[au VimEnter * highlight Normal guibg=0]])
end

--Set statusbar
require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "auto",
    -- component_separators = {'', ''},
    -- section_separators = {'', ''},
    disabled_filetypes = {},
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { "filename" },
    lualine_x = {
      { "diagnostics", sources = { "nvim_lsp" } },
      "encoding",
      "fileformat",
      "filetype",
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = { "nvim-tree", "fugitive", "quickfix", "toggleterm" },
})

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--Remap for dealing with word wrap
vim.api.nvim_set_keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)

-- Y yank until the end of line  (note: this is now a default on master)
vim.api.nvim_set_keymap("n", "Y", "y$", { noremap = true })

-- Sneak
vim.api.nvim_set_keymap("n", "<leader>s", "<Plug>Sneak_s", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>S", "<Plug>Sneak_S", { silent = true })
vim.api.nvim_set_keymap("x", "<leader>s", "<Plug>Sneak_s", { silent = true })
vim.api.nvim_set_keymap("x", "<leader>S", "<Plug>Sneak_S", { silent = true })
vim.api.nvim_set_keymap("o", "<leader>s", "<Plug>Sneak_s", { silent = true })
vim.api.nvim_set_keymap("o", "<leader>S", "<Plug>Sneak_S", { silent = true })

vim.api.nvim_set_keymap("", "f", "<Plug>Sneak_f", { silent = true })
vim.api.nvim_set_keymap("", "F", "<Plug>Sneak_F", { silent = true })
vim.api.nvim_set_keymap("", "t", "<Plug>Sneak_t", { silent = true })
vim.api.nvim_set_keymap("", "T", "<Plug>Sneak_T", { silent = true })
vim.api.nvim_del_keymap("s", "f")
vim.api.nvim_del_keymap("s", "F")
vim.api.nvim_del_keymap("s", "t")
vim.api.nvim_del_keymap("s", "T")

--Map blankline
vim.g.indent_blankline_char = "┊"
vim.g.indent_blankline_filetype_exclude = { "help", "packer" }
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_char_highlight = "LineNr"
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_use_treesitter = true

-- nvim-tree setup
vim.g.nvim_tree_indent_markers = 1
vim.api.nvim_set_keymap("n", "<leader>v", "<Cmd>Vista!!<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
vim.cmd([[
let g:nvim_tree_window_picker_exclude = {
  \   'filetype': [
  \     'notify',
  \     'packer',
  \     'qf',
  \     'vista'
  \   ],
  \   'buftype': [
  \     'terminal'
  \   ]
  \ }
]])
require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- todo-comments setup
require("todo-comments").setup({})

-- toggleterm
require("toggleterm").setup({
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 10
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = "1", -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = true,
  direction = "horizontal",
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell, -- change the default shell
  -- This field is only relevant if direction is set to 'float'
  float_opts = {
    -- The border key is *almost* the same as 'nvim_open_win'
    -- see :h nvim_open_win for details on borders however
    -- the 'curved' border is a custom border type
    -- not natively supported but implemented in this plugin.
    border = "single",
    width = 80,
    height = 40,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
})

-- My convenience mappings
vim.api.nvim_set_keymap("n", "<leader>/", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>p", '"_dP', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "y", "ygv<Esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-c>", "y", { noremap = true })

vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-r>+", { noremap = true })

vim.api.nvim_set_keymap("t", "<C-q>", [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap("t", "jk", [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap("t", "kj", [[<C-\><C-n>]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], { noremap = true })

vim.api.nvim_set_keymap("n", "<C-h>", [[<C-W>h]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", [[<C-W>j]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", [[<C-W>k]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", [[<C-W>l]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-S-v>", "a<C-r>+", { noremap = true })

-- Autopairs setup
require("nvim-autopairs").setup({
  check_ts = true,
})

-- Colorizer setup
require("colorizer").setup({
  "*",
  css = { rgb_fn = true },
})

-- nvim-scrollview settings
vim.g.scrollview_column = 1

-- Gitsigns
require("gitsigns").setup({})

-- Telescope
local telescope = require("telescope")
telescope.setup({})
--Add telescope shortcuts
vim.api.nvim_set_keymap(
  "n",
  "<leader>ff",
  [[<cmd>lua require('telescope.builtin').find_files()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fg",
  [[<cmd>lua require('telescope.builtin').live_grep()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fb",
  [[<cmd>lua require('telescope.builtin').buffers()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fh",
  [[<cmd>lua require('telescope.builtin').help_tags()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>fz",
  [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>bi",
  [[<cmd>lua require('telescope.builtin').builtin()<CR>]],
  { noremap = true, silent = true }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>?",
  [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]],
  { noremap = true, silent = true }
)

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  autotag = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  matchup = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },
  },
})

-- LSP settings
local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
  vim.api.nvim_buf_set_keymap(
    bufnr,
    "n",
    "<leader>fo",
    [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]],
    opts
  )
  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.formatting()' ]])
  if client.resolved_capabilities.document_formatting then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
    capabilities = capabilities,
  }

  -- (optional) Customize the options passed to the server
  if server.name == "sumneko_lua" then
    -- Custom lua setup
    -- make runtime files discoverable to the server
    local runtime_path = vim.split(package.path, ";")
    table.insert(runtime_path, "lua/?.lua")
    table.insert(runtime_path, "lua/?/init.lua")
    opts.settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          -- Setup your lua path
          path = runtime_path,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
        },
        -- Do not send telemetry data containing a randomized but unique identifier
        telemetry = {
          enable = false,
        },
      },
    }
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/ADVANCED_README.md
  server:setup(opts)
end)

-- Ionide configuration
vim.g["fsharp#lsp_auto_setup"] = 0
vim.g["fsharp#fsi_window_command"] = "bel 10new"
vim.g["fsharp#fsi_keymap"] = "custom"
vim.g["fsharp#fsi_keymap_toggle"] = "<leader>i"
vim.g["fsharp#fsi_keymap_send"] = "<leader>o"
require("ionide").setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- null-ls configuration
local null_ls = require("null-ls")
null_ls.config({
  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.stylua.with({
      extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
    }),
    null_ls.builtins.hover.dictionary,
  },
})
require("lspconfig")["null-ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menu,menuone,preview,noinsert"
vim.g.completion_matching_strategy_list = { "exact", "substring", "fuzzy" }

-- luasnip setup
local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()

-- lspkind setup
local lspkind = require("lspkind")

-- nvim-cmp setup
local cmp = require("cmp")
cmp.setup({
  formatting = {
    format = lspkind.cmp_format({}),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
      else
        fallback()
      end
    end,
    ["<C-n>"] = function(fallback)
      if luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<C-p>"] = function(fallback)
      if luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
      else
        fallback()
      end
    end,
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = false }),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "buffer" },
    { name = "calc" },
  },
})

-- signature_lsp
require("lsp_signature").setup({
  bind = true,
  extra_trigger_chars = { "(", "[", "{", " ", "," },
  hint_enable = false,
  handler_opts = {
    border = "none",
  },
})
