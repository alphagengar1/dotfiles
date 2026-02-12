local lazy_plugins = {
  -- UI
  {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    config = function()
      require("configs.lualine")
    end,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = function()
      return require("configs.notify")
    end,
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-cmdline",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    opts = function()
      return require("configs.noice")
    end,
  },
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    config = function()
      require("configs.alpha")
    end,
  },

  -- Navigation
  {
    "ggandor/leap.nvim",
    enabled = true,
    keys = require("configs.leap").keys,
    config = function()
      require("configs.leap").setup()
    end,
  },

  -- LSP UI
  {
    "aznhe21/actions-preview.nvim",
    event = "LspAttach",
    config = function(_, opts)
      require("actions-preview").setup(opts)
    end,
    opts = function()
      return require("configs.code_actions")
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = function()
      require("configs.cmp")
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_lua").load({ paths = vim.fn.stdpath("config") .. "/lua/lua_snippets" })
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },
  { "saadparwaiz1/cmp_luasnip", event = "InsertEnter" },
  { "hrsh7th/cmp-nvim-lsp", event = "InsertEnter" },
  { "hrsh7th/cmp-buffer", event = "InsertEnter" },
  { "hrsh7th/cmp-path", event = "InsertEnter" },

  -- Package management
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("mason").setup(opts)
      vim.api.nvim_create_user_command("MasonInstallAll", function()
        vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
      end, {})
      vim.g.mason_binaries_list = opts.ensure_installed
    end,
    opts = function()
      return require("configs.mason")
    end,
  },

  -- Dev tools
  {
    "ptdewey/yankbank-nvim",
    dependencies = "kkharji/sqlite.lua",
    event = "VeryLazy",
    opts = function()
      return require("configs.yankbank")
    end,
  },
  {
    "kawre/leetcode.nvim",
    cmd = "Leet",
    build = ":TSUpdate html",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = function()
      return require("configs.leetcode")
    end,
  },
  {
    "xeluxee/competitest.nvim",
    ft = "cpp",
    event = "VeryLazy",
    dependencies = "MunifTanjim/nui.nvim",
    config = function(_, opts)
      require("competitest").setup(opts)
    end,
    opts = function()
      return require("configs.competitest")
    end,
  },

  -- Debugger (lazy)
  {
    "mfussenegger/nvim-dap",
    module = { "dap", "dapui" },
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "jay-babu/mason-nvim-dap.nvim",
    },
    config = function()
      require("configs.dap")
    end,
  },

}

return lazy_plugins
