local M = {}

M.global = {
  {
    "n",
    "<leader>ra",
    function()
      require("nvchad.lsp.renamer")()
    end,
    { desc = "LSP rename" },
  },
  {
    "n",
    "<leader>fm",
    function()
      require("conform").format({ async = true, lsp_format = "fallback" })
    end,
    { desc = "Format buffer" },
  },
  {
    "n",
    "<leader>ca",
    function()
      require("actions-preview").code_actions()
    end,
    { desc = "LSP code actions" },
  },
}

function M.apply(bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "gD", vim.lsp.buf.declaration, "LSP declaration")
  map("n", "gd", vim.lsp.buf.definition, "LSP definition")
  map("n", "K", vim.lsp.buf.hover, "LSP hover")
  map("n", "gi", vim.lsp.buf.implementation, "LSP implementation")
  map("n", "<C-k>", vim.lsp.buf.signature_help, "LSP signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "LSP add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "LSP remove workspace folder")
  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, "LSP list workspace folders")
  map("n", "<leader>D", vim.lsp.buf.type_definition, "LSP type definition")
  map("n", "gr", vim.lsp.buf.references, "LSP references")
  map("n", "<leader>z", vim.diagnostic.open_float, "Diagnostics float")
  map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
  map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>q", vim.diagnostic.setloclist, "Diagnostics list")
end

return M
