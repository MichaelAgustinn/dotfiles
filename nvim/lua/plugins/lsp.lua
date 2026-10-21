return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      opts.servers = opts.servers or {}

      opts.servers.intelephense = {
        capabilities = capabilities,
      }

      opts.servers.lua_ls = {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim", "hl" },
            },
          },
        },
      }

      return opts
    end,
  },
}
