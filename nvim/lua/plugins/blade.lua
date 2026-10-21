return {
  -- Menambahkan dukungan syntax highlighting untuk Blade
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "php",
        "phpdoc",
        "html",
        "css",
      })
    end,
  },
  {
    "jwalton512/vim-blade",
  },
}
