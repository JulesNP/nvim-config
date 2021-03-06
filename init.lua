vim.cmd([[
    if has('win32')
        set shell=pwsh " Your shell must be powershell
        let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
        let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
        set shellquote= shellxquote=
    endif

    augroup packer_user_config
        autocmd!
        autocmd BufWritePost init.lua source <afile> | PackerCompile
    augroup end

    augroup CursorLine
        au!
        au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
        au WinLeave * setlocal nocursorline
        au TermOpen * setlocal nonumber norelativenumber nobuflisted signcolumn=auto
        au FileType help setlocal signcolumn=auto
    augroup end

    augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank({ timeout=300 })
    augroup end
]])

-- Install packer
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    local packer_bootstrap = fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
end

require("packer").startup(function(use)
    use("wbthomason/packer.nvim") -- Packer itself

    -- tpope's plugins
    use("tpope/vim-fugitive") -- Git commands in nvim
    use("tpope/vim-repeat") -- enable repeating supported plugin maps with "."
    use("tpope/vim-rhubarb") -- Fugitive-companion to interact with github
    use("tpope/vim-speeddating") -- use CTRL-A/CTRL-X to increment dates, times, and more
    use("tpope/vim-surround") -- quoting/parenthesizing made simple
    use("tpope/vim-unimpaired") -- Pairs of handy bracket mappings

    -- Themes
    use("gruvbox-community/gruvbox")

    use({ "kevinhwang91/nvim-bqf", ft = "qf" }) -- Better quickfix window in Neovim.
    -- UI to select things (files, grep results, open buffers...)
    use({ "nvim-telescope/telescope.nvim", requires = { "nvim-lua/plenary.nvim" } })
    use({ "stevearc/dressing.nvim" }) -- Neovim plugin to improve the default vim.ui interfaces
    -- ??? Highlight, list and search todo comments in your projects
    use({ "folke/todo-comments.nvim", requires = "nvim-lua/plenary.nvim" })
    -- A blazing fast and easy to configure neovim statusline written in pure lua
    use({ "hoob3rt/lualine.nvim", requires = { "kyazdani42/nvim-web-devicons", opt = true } })
    -- A snazzy bufferline for Neovim
    use({ "akinsho/bufferline.nvim", requires = "kyazdani42/nvim-web-devicons" })
    -- Delete Neovim buffers without losing window layout
    use("famiu/bufdelete.nvim")
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

    -- Completion sources
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-calc")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-emoji")
    use("quangnguyen30192/cmp-nvim-tags")
    use("lukas-reineke/cmp-rg")

    use("ray-x/lsp_signature.nvim")
    use("saadparwaiz1/cmp_luasnip")
    use("L3MON4D3/LuaSnip") -- Snippets plugin
    use("rafamadriz/friendly-snippets") -- Set of preconfigured snippets for different languages.
    use("onsails/lspkind-nvim") -- vscode-like pictograms for neovim lsp completion items
    use("norcalli/nvim-colorizer.lua") -- The fastest Neovim colorizer
    use("dstein64/nvim-scrollview") -- ????A Neovim plugin that displays interactive vertical scrollbars.
    use("lukas-reineke/virt-column.nvim") -- Display a character as the colorcolumn.
    -- A file explorer tree for neovim written in lua
    use({ "kyazdani42/nvim-tree.lua", requires = "kyazdani42/nvim-web-devicons" })
    use("akinsho/toggleterm.nvim") -- A neovim lua plugin to help easily manage multiple terminal windows.
    use("wellle/targets.vim") -- Vim plugin that provides additional text objects
    use("justinmk/vim-sneak") -- The missing motion for Vim ????
    use("chaoren/vim-wordmotion") -- More useful word motions for Vim
    use("windwp/nvim-ts-autotag") -- Use treesitter to auto close and auto rename html tag
    use("windwp/nvim-autopairs") -- A super powerful autopair for Neovim. It supports multiple characters.
    use("numToStr/Comment.nvim") -- ???? ???? // Smart and powerful comment plugin for neovim.
    use("vim-scripts/ReplaceWithRegister") -- Replace text with the contents of a register.
    use("PhilT/vim-fsharp") -- Basic F# support for (Neo)Vim ????
    use("OrangeT/vim-csharp") -- Enhancement's to Vim's C-Sharp Functionality
    use("digitaltoad/vim-pug") -- Vim Pug (formerly Jade) template engine syntax highlighting and indention
    -- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
    use({ "jose-elias-alvarez/null-ls.nvim", requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" } })
    use("ludovicchabant/vim-gutentags") -- A Vim plugin that manages your tag files
    use("folke/which-key.nvim") -- ???? Create key bindings that stick.
    use("andymass/vim-matchup") -- even better % ???? navigate and highlight matching words
    use({ "folke/trouble.nvim", requires = "kyazdani42/nvim-web-devicons" })

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require("packer").sync()
    end
end)

-- Show title
vim.o.title = true

-- Clipboard support
vim.o.clipboard = "unnamedplus"

-- Automatically load file changes from disk
vim.o.autoread = true

--Incremental live completion with preview
vim.o.inccommand = "split"

-- Number stuff
vim.wo.relativenumber = true
vim.wo.number = true
vim.o.numberwidth = 2

--Enable mouse mode
vim.o.mouse = "a"

-- Keep 8 lines above/below cursor
vim.o.scrolloff = 3

vim.opt.linebreak = true

--Save undo history
vim.opt.undofile = true

-- Indentation stuff
vim.o.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0
vim.opt.expandtab = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Fix split behaviour how I like it
vim.o.splitbelow = true
vim.o.splitright = true

-- Since we have lualine, no need to show the mode twice
vim.o.showmode = false

vim.wo.signcolumn = "yes"

vim.o.guifont = "Iosevka Medium:h16"

--Set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.gruvbox_italic = 1
vim.g.gruvbox_contrast_dark = "hard"
vim.cmd([[
  set background=dark
  colorscheme gruvbox
]])

-- Remove background colour if running on Windows Terminal (for transparency effect)
if os.getenv("WT_SESSION") then
    vim.cmd([[au VimEnter * highlight Normal guibg=0]])
end

--Set statusbar
require("lualine").setup({
    options = {
        icons_enabled = true,
        theme = "auto",
        -- component_separators = {'???', '???'},
        -- section_separators = {'???', '???'},
        disabled_filetypes = {},
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff" },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "diagnostics", sources = { "nvim_diagnostic" } } },
        lualine_y = { "encoding", "fileformat", "filetype" },
        lualine_z = { "location" },
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
    },
    tabline = {},
    extensions = { "nvim-tree", "fugitive", "quickfix", "toggleterm" },
})

-- bufferline setup
require("bufferline").setup({
    highlights = {
        buffer_selected = { gui = "bold" },
        diagnostic_selected = { gui = "bold" },
        info_selected = { gui = "bold" },
        info_diagnostic_selected = { gui = "bold" },
        warning_selected = { gui = "bold" },
        warning_diagnostic_selected = { gui = "bold" },
        error_selected = { gui = "bold" },
        error_diagnostic_selected = { gui = "bold" },
    },
    options = {
        close_command = function(bufnum)
            require("bufdelete").bufdelete(bufnum, true)
        end,
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and "??? " or "??? "
            return " " .. icon .. count
        end,
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "Directory",
                text_align = "left",
            },
        },
        show_close_icon = false,
    },
})

--Remap space as leader key
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- trouble.nvim setup
require("trouble").setup({})
vim.api.nvim_set_keymap("n", "<leader>tt", "<Cmd>TroubleToggle<CR>", { noremap = true, silent = true })

-- indent-blankline setup
vim.opt.list = true
require("indent_blankline").setup({
    show_current_context = true,
    show_current_context_start = true,
    use_treesitter = true,
})

-- virt-column setup
require("virt-column").setup({ virtcolumn = "80" })

-- nvim-tree setup
vim.api.nvim_set_keymap("n", "<leader>n", "<Cmd>NvimTreeToggle<CR>", { noremap = true, silent = true })
require("nvim-tree").setup({
    update_focused_file = {
        enable = true,
    },
    filters = {
        dotfiles = true,
    },
    renderer = {
        indent_markers = {
            enable = true,
        },
    },
})

-- Comment.nvim setup
require("Comment").setup()

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

-- whichkey setup
require("which-key").setup({})

-- My convenience mappings
vim.api.nvim_set_keymap("i", "<C-S-v>", "<C-r>+", { noremap = true })
vim.api.nvim_set_keymap("i", "jk", "<Esc>", { noremap = true })
vim.api.nvim_set_keymap("i", "kj", "<Esc>", { noremap = true })

vim.api.nvim_set_keymap("n", "<C-S-v>", "a<C-r>+", { noremap = true })
vim.api.nvim_set_keymap("n", "<C-h>", [[<C-W>h]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-j>", [[<C-W>j]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-k>", [[<C-W>k]], { noremap = true })
vim.api.nvim_set_keymap("n", "<C-l>", [[<C-W>l]], { noremap = true })
vim.api.nvim_set_keymap("n", "<b", "<Cmd>BufferLineMovePrev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>/", "<Cmd>nohlsearch<Bar>diffupdate<CR><C-L>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>bd", "<Cmd>BufferLineSortByDirectory<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>be", "<Cmd>BufferLineSortByExtension<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>bp", "<Cmd>BufferLinePick<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>bx", "<Cmd>BufferLinePickClose<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gd", "<Cmd>Gdiffsplit<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gg", "<Cmd>Git<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gp", "<Cmd>Git push<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>gu", "<Cmd>Git pull<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", ">b", "<Cmd>BufferLineMoveNext<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "[b", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "]b", "<Cmd>BufferLineCycleNext<CR>", { noremap = true })

vim.api.nvim_set_keymap("t", "<C-h>", [[<C-\><C-n><C-W>h]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-j>", [[<C-\><C-n><C-W>j]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-k>", [[<C-\><C-n><C-W>k]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-l>", [[<C-\><C-n><C-W>l]], { noremap = true })
vim.api.nvim_set_keymap("t", "<C-q>", [[<C-\><C-n>]], { noremap = true })

vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S-c>", "y", { noremap = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "y", "ygv<Esc>", { noremap = true, silent = true })

-- Autopairs setup
require("nvim-autopairs").setup({
    fast_wrap = {},
})

-- Colorizer setup
require("colorizer").setup({
    "*",
    css = { rgb_fn = true },
})

-- nvim-scrollview settings
vim.g.scrollview_column = 1

-- Gitsigns
require("gitsigns").setup({
    signs = {
        add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
        change = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    },
    on_attach = function(bufnr)
        local function map(mode, lhs, rhs, opts)
            opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
        end

        -- Navigation
        map("n", "]c", "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", { expr = true })
        map("n", "[c", "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", { expr = true })

        -- Actions
        map("n", "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map("v", "<leader>hs", ":Gitsigns stage_hunk<CR>")
        map("n", "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("v", "<leader>hr", ":Gitsigns reset_hunk<CR>")
        map("n", "<leader>hS", "<cmd>Gitsigns stage_buffer<CR>")
        map("n", "<leader>hu", "<cmd>Gitsigns undo_stage_hunk<CR>")
        map("n", "<leader>hR", "<cmd>Gitsigns reset_buffer<CR>")
        map("n", "<leader>hp", "<cmd>Gitsigns preview_hunk<CR>")
        map("n", "<leader>hb", '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
        map("n", "<leader>tb", "<cmd>Gitsigns toggle_current_line_blame<CR>")
        map("n", "<leader>hd", "<cmd>Gitsigns diffthis<CR>")
        map("n", "<leader>hD", '<cmd>lua require"gitsigns".diffthis("~")<CR>')
        map("n", "<leader>td", "<cmd>Gitsigns toggle_deleted<CR>")

        -- Text object
        map("o", "ih", ":<C-U>Gitsigns select_hunk<CR>")
        map("x", "ih", ":<C-U>Gitsigns select_hunk<CR>")
    end,
})

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
        enable = true,
        additional_vim_regex_highlighting = false,
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
        lsp_interop = {
            enable = true,
            border = "none",
            peek_definition_code = {
                ["<leader>df"] = "@function.outer",
                ["<leader>dF"] = "@class.outer",
            },
        },
        select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
                -- You can use the capture groups defined in textobjects.scm
                ["a,"] = "@parameter.outer",
                ["i,"] = "@parameter.inner",
                ["ao"] = "@block.outer",
                ["io"] = "@block.inner",
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
                ["uc"] = "@comment.outer",
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

    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local opts = { noremap = true, silent = true }
    buf_set_keymap("n", "<leader>gb", "<Cmd>lua require('telescope.builtin').git_bcommits()<CR>", opts)
    buf_set_keymap("n", "<leader>gc", "<Cmd>lua require('telescope.builtin').git_commits()<CR>", opts)
    buf_set_keymap("n", "<leader>gs", "<Cmd>lua require('telescope.builtin').git_status()<CR>", opts)
    buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<Cmd>lua require('telescope.builtin').lsp_definitions()<CR>", opts)
    buf_set_keymap("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<CR>", opts)
    buf_set_keymap("n", "<M-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    buf_set_keymap("n", "<leader>D", "<cmd>lua require('telescope.builtin').lsp_type_definitions()<CR>", opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    buf_set_keymap("v", "<leader>ca", "<cmd>lua vim.lsp.buf.range_code_action()<CR>", opts)
    buf_set_keymap("n", "<leader>fr", "<cmd>lua require('telescope.builtin').lsp_references()<CR>", opts)
    buf_set_keymap("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float(nil, { source = 'always' })<CR>", opts)
    buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
    buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
    buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

    if client.name == "fsautocomplete" then
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
    end
    if client.resolved_capabilities.document_formatting then
        vim.api.nvim_buf_set_option(bufnr, "formatexpr", "v:lua.vim.lsp.formatexpr()")
        vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()")
        buf_set_keymap("n", "<space>fo", "<cmd>lua vim.lsp.buf.formatting_seq_sync()<CR>", opts)
    end
    if client.resolved_capabilities.document_range_formatting then
        buf_set_keymap("x", "<space>fo", "<cmd>lua vim.lsp.buf.range_formatting()<CR><ESC>", opts)
    end

    require("lsp_signature").on_attach({
        bind = true,
        handler_opts = {
            border = "none",
        },
        hint_enable = false,
    }, bufnr)
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

-- null-ls configuration
local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.prettier.with({
            extra_filetypes = { "pug" },
        }),
        null_ls.builtins.formatting.stylua.with({
            extra_args = { "--indent-type", "Spaces", "--indent-width", "2" },
        }),
        null_ls.builtins.hover.dictionary,
    },
    on_attach = on_attach,
    capabilities = capabilities,
})

-- luasnip setup
local luasnip = require("luasnip")
require("luasnip/loaders/from_vscode").lazy_load()

-- lspkind setup
local lspkind = require("lspkind")

local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
cmp.setup({
    experimental = {
        ghost_text = true,
    },
    formatting = {
        format = lspkind.cmp_format({
            with_text = true,
            menu = {
                luasnip = "[snip]",
                nvim_lua = "[lua]",
                nvim_lsp = "[lsp]",
                path = "[path]",
                emoji = "[emoji]",
                calc = "[calc]",
                tags = "[tags]",
                rg = "[rg]",
                cmdline = "[cmd]",
            },
        }),
    },
    snippet = {
        expand = function(args)
            require("luasnip").lsp_expand(args.body)
        end,
    },
    mapping = {
        ["<Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
                elseif luasnip.expand_or_jumpable() and has_words_before() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                else
                    fallback()
                end
            end,
        }),
        ["<S-Tab>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                else
                    cmp.complete()
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
                elseif luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
            s = function(fallback)
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                else
                    fallback()
                end
            end,
        }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }), { "i" }),
        ["<C-n>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t("<Down>"), "n", true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end,
        }),
        ["<C-p>"] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    vim.api.nvim_feedkeys(t("<Up>"), "n", true)
                end
            end,
            i = function(fallback)
                if cmp.visible() then
                    cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
                else
                    fallback()
                end
            end,
        }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({ i = cmp.mapping.close(), c = cmp.mapping.close() }),
        ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = false }), { "i", "s" }),
    },
    sources = {
        { name = "luasnip" },
        { name = "nvim_lua" },
        { name = "nvim_lsp" },
        { name = "path" },
        { name = "emoji" },
        { name = "calc" },
        { name = "rg", priority = -1, keyword_length = 3, max_item_count = 10 },
        { name = "tags", priority = -2, keyword_length = 3, max_item_count = 10 },
    },
})

-- Use buffer source for `/`
cmp.setup.cmdline("/", {
    sources = {
        { name = "buffer", opts = { keyword_pattern = [=[[^[:blank:]].*]=] } },
    },
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        { name = "cmdline" },
    }),
})

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "", fsharp = "" } }))
