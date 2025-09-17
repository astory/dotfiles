return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
    },
  },

  {
    "kassio/neoterm",
    config = function() vim.g.neoterm_default_mod = "vertical" end,
    lazy = false,
    keys = {
      { "<leader>tc", ":Tclear<cr>", desc = "Clear terminal" },
      { "<leader>to", ":Ttoggle<cr>", desc = "Toggle terminal" },
      { "<leader>tl", ":w<cr>:T dev test --include-branch-commits<cr>", desc = "Test local changes" },
      { "<leader>ty", ":w<cr>:T bin/srb typecheck<cr>", desc = "Sorbet typecheck" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({ signcolumn = false, numhl = true})
    end,
    event = { "CursorHold", "CursorHoldI" },
    keys = {
      { "<leader>ghs", ":Gitsigns stage_hunk<cr>", desc = "Git stage hunk" },
      { "<leader>ghu", ":Gitsigns undo_stage_hunk<cr>", desc = "Git undo stage hunk" },
      { "<leader>ghr", ":Gitsigns reset_hunk<cr>", desc = "Git reset hunk" },
      { "]h", ":Gitsigns next_hunk<cr>", desc = "Gitsigns: Go to next hunk" },
      { "[h", ":Gitsigns prev_hunk<cr>", desc = "Gitsigns: Go to prev hunk" },
      { "ah", ":<C-U>Gitsigns select_hunk<CR>", mode = {"o", "x"}, desc = "Text object for git hunks" },
    },
  },

-- This appears to break syntax highlighting
--  {
--    "Mofiqul/vscode.nvim",
--    config = function()
--      require("vscode").load()
--    end,
--  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = {
      "Mofiqul/vscode.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "vscode",
          path = 1, -- show relative file path
        }
      })
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "lua", "ruby", "vimdoc" },
        auto_install = false,
        highlight = { enable = true, },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
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
    end,
    build = ":TSUpdate",
  },

  {
    "rmagatti/goto-preview",
    event = "BufEnter",
    config = true,
    keys = {
      { "<leader>gp", ":lua require('goto-preview').goto_preview_definition()<cr>", desc = "Preview definition" },
    },
  },

  { "tpope/vim-bundler", ft = { "ruby", "eruby" } },
  { "tpope/vim-endwise", ft = { "ruby", "eruby" } },

  {
    "tpope/vim-fugitive",
    lazy = false,
    dependencies = { "tpope/vim-rhubarb" },
    keys = {
      { "<leader>gbl", ":Git blame<cr>", desc = "Git blame" },
      { "<leader>ghp", ":!/opt/dev/bin/dev open pr &<cr><cr>", desc = "Github PR" },
      { "<leader>gs", ":Git<cr>", desc = "Git status" },
      { "<leader>gbr", ":GBrowse<cr>", desc = "Git browse", mode = { "n", "v" } },
    },
  },

  {
    "tpope/vim-rails",
    keys = {
      { "<leader>s", ":A<cr>", desc = "Toggle test and code files" },
    },
  },

  { "tpope/vim-surround", event = { "BufReadPost", "BufNewFile" } },
  { "tpope/vim-unimpaired", event = { "BufReadPost", "BufNewFile" } },
  {
    "sindrets/diffview.nvim",
    lazy = false,
  },
  { "vim-ruby/vim-ruby", event = { "BufReadPost", "BufNewFile" } },

  {
    "vim-test/vim-test",
    lazy = false,
    config = function() vim.g["test#strategy"] = "neoterm" end,
    keys = {
      { "<leader>tf", ":w<cr>:TestFile<cr>", desc = "Test current file" },
      { "<leader>tn", ":w<cr>:TestNearest<cr>", desc = "Test current file" },
      { "<leader>ts", ":w<cr>:TestSuite<cr>", desc = "Test suite" },
      { "<leader>tt", ":w<cr>:TestLast<cr>", desc = "Rerun last test" },
    },
  },

  { "windwp/nvim-autopairs", event = "InsertEnter", opts = {} },
  "wsdjeg/vim-fetch",
  "ngmy/vim-rubocop",
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'BurntSushi/ripgrep',
      'nvim-telescope/telescope-live-grep-args.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
    lazy = false,
  },
}
