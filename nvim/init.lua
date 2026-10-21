-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.keymap.set("c", "w!!", "w !sudo tee % > /dev/null", { desc = "Save as root" })
