-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.del("n", "<leader>ft")

vim.keymap.set("n", "<leader>ft", function()
    require("toggleterm.terminal").Terminal:new({ direction = "float" }):toggle()
end, { desc = "Toggle floating terminal (ToggleTerm)" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

vim.keymap.set({ "n", "t" }, "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle terminal" })
