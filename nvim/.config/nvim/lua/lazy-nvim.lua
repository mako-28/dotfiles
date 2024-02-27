local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        ensure_installed = {
          "bash",
          "c",
          "css",
          "csv",
          "diff",
          "dockerfile",
          "gitcommit",
          "gitignore",
          "go",
          "html",
          "java",
          "javascript",
          "json",
          "lua",
          "python",
          "sql",
          "toml",
          "typescript",
          "vim",
          "vimdoc",
          "query"
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
    end,
    event = 'BufRead',
  },
  {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "Shougo/ddc-source-lsp",
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = {
      ensure_installed = {
        "efm",
        "gopls",
        "tsserver",
        "lua_ls",
        "yamlls",
        "jsonls",
        "jdtls",
        "rust_analyzer",
        "cssls",
        "eslint",
        "emmet_language_server",
        "typos_lsp",
        "marksman",
      },
      automatic_installation = true,
    },
  },
  {
    "williamboman/mason.nvim",
    config = {
      ui = {
        border = "single",
        icons = {
          package_installed = " ",
          package_pending = "↻ ",
          package_uninstalled = " ",
        },
      },
    },
  },
  {'brenoprata10/nvim-highlight-colors'},
})

