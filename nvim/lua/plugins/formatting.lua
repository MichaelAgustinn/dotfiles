return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        php = { "pint", "php_cs_fixer" },

        blade = { "blade-formatter" },

        dart = { "dart_format" },

        javascript = { "prettier" },
        typescript = { "prettier" },

        lua = { "stylua" },
      },
    },
  },
}
