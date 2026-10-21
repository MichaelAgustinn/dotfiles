return {
  {
    "nvim-flutter/flutter-tools.nvim",
    lazy = false,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
    },
    opts = {
      ui = {
        border = "rounded",
      },
      decorations = {
        statusline = {
          app_version = true,
          device = true,
        },
      },
      lsp = {
        color = {
          enabled = true,
          background = false,
          foreground = true,
          virtual_text = true,
          virtual_text_str = "■",
        },
        settings = {
          showTodos = true,
          completeFunctionCalls = true,
          analysisServerExceptionsIncremental = true,
        },
      },
    },
  },
}
