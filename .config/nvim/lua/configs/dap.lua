local function safe_require(name)
  local ok, mod = pcall(require, name)
  if not ok then
    vim.schedule(function()
      vim.notify("DAP: failed to load " .. name .. ". Run :Lazy sync", vim.log.levels.WARN)
    end)
    return nil
  end
  return mod
end

local mason_dap = safe_require("mason-nvim-dap")
if not mason_dap then
  return
end

mason_dap.setup({
  ensure_installed = { "codelldb", "debugpy" },
  automatic_installation = true,
})

local dap = safe_require("dap")
if not dap then
  return
end
local dapui = safe_require("dapui")

local dapvt = safe_require("nvim-dap-virtual-text")
if dapvt then
  dapvt.setup({ commented = true })
end

if dapui then
  dapui.setup({
    icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
    controls = { enabled = true },
  })
end

-- Adapters (from Mason)
local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
local codelldb = mason_bin .. "/codelldb"
local debugpy = mason_bin .. "/debugpy-adapter"

if vim.fn.executable(codelldb) == 1 then
  dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
      command = codelldb,
      args = { "--port", "${port}" },
    },
  }
end

if vim.fn.executable(debugpy) == 1 then
  dap.adapters.python = {
    type = "executable",
    command = debugpy,
    args = {},
  }
end

-- Configurations
local function program_path()
  return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
end

local cpp_cfg = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = program_path,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
  },
}

dap.configurations.cpp = cpp_cfg
dap.configurations.c = cpp_cfg
dap.configurations.rust = cpp_cfg

dap.configurations.python = {
  {
    name = "Launch file",
    type = "python",
    request = "launch",
    program = "${file}",
    pythonPath = function()
      return vim.fn.exepath("python3") or "python3"
    end,
  },
}

-- Auto open/close UI

if dapui then
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end

  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end

  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end
