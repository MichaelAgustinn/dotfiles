return {
  "mfussenegger/nvim-dap",
  opts = function()
    local dap = require("dap")

    dap.configurations.javascript = dap.configurations.javascript or {}

    table.insert(dap.configurations.javascript, {
      type = "pwa-node",
      request = "launch",
      name = "Debug Electron Main Process",
      runtimeExecutable = "${workspaceFolder}/node_modules/.bin/electron",
      runtimeArgs = { "." },
      rootPath = "${workspaceFolder}",
      cwd = "${workspaceFolder}",
      console = "integratedTerminal",
      internalConsoleOptions = "neverOpen",
    })
  end,
}
