local use_native = vim.lsp and vim.lsp.config and vim.lsp.enable
local lspconfig = nil
if not use_native then
  lspconfig = require("lspconfig")
end
local cmp_nvim_lsp = require("cmp_nvim_lsp")
local lsp_keymaps = require("configs.lsp_keymaps")

local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem = {
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  documentationFormat = { "markdown", "plaintext" },
}

vim.diagnostic.config({
  signs = {
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    values = {
      Error = " ",
      Warn = " ",
      Hint = " ",
      Info = " ",
    },
  },
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  float = { border = "rounded" },
})

local function on_attach(client, bufnr)
  lsp_keymaps.apply(bufnr)

  if client.server_capabilities.documentHighlightProvider then
    local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = false })
    vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
    vim.api.nvim_create_autocmd("CursorHold", {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      group = group,
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end

  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = "rounded",
        source = "always",
        prefix = " ",
        scope = "cursor",
      })
    end,
  })
end

local servers = {
  clangd = {
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    init_options = {
      clangdFileStatus = true,
    },
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--completion-style=detailed",
      "--header-insertion=iwyu",
      "--query-driver=/opt/homebrew/bin/g++*,/opt/homebrew/bin/clang++*,/usr/bin/clang++",
    },
  },
  bashls = { filetypes = { "sh", "bash", "zsh" } },
  ruff = {
    filetypes = { "python" },
    init_options = {
      settings = {
        organizeImports = true,
      },
    },
  },
  pyright = {
    filetypes = { "python" },
    settings = {
      pyright = {
        disableOrganizeImports = true,
      },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = "workspace",
          useLibraryCodeForTypes = true,
        },
      },
    },
  },
  rust_analyzer = {
    filetypes = { "rust" },
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        check = { command = "clippy" },
        procMacro = { enable = true },
      },
    },
  },
  jdtls = { filetypes = { "java" } },
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.stdpath("config") .. "/lua"] = true,
          },
        },
        format = { enable = true },
      },
    },
  },
  html = { filetypes = { "html" } },
  cssls = { filetypes = { "css", "scss", "less" } },
  ts_ls = { filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
  emmet_ls = {
    filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
    init_options = {
      html = { options = { ["bem.enabled"] = true } },
    },
  },
  jsonls = { filetypes = { "json", "jsonc" } },
}

for server, config in pairs(servers) do
  local merged = vim.tbl_deep_extend("force", {
    on_attach = on_attach,
    capabilities = capabilities,
  }, config)

  if use_native then
    vim.lsp.config(server, merged)
    vim.lsp.enable(server)
  else
    lspconfig[server].setup(merged)
  end
end
