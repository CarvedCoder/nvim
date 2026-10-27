return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "main",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "MunifTanjim/nui.nvim",
    },
    config = function()
        require("neo-tree").setup({})
        vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle<CR>")
    end,
}
