return {
  {
    "neovim/nvim-lspconfig",
    version = "^2",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c",
        "cpp",
        "java",
        "python",
        "bash",
        "rust",
        "toml",
      },
    },
  },
}
