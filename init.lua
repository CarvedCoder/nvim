-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.notify = require("notify")

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Transparent background

require("catppuccin").setup({
    transparent_background = true,
    integrations = {
        nvimtree = true,
    },
})

vim.cmd.colorscheme("catppuccin-mocha")

require("render-markdown").setup({
    completions = { lsp = { enabled = true } },
})

vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<C-s>", "<Esc>:w<CR>a")
