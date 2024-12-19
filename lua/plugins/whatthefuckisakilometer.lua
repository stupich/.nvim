return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup {
        columns = { "icon" },
        keymaps = {
          ["<C-h>"] = false,
        },
        view_options = {
          show_hidden = true,
        },
      }
      vim.keymap.set("n", "-", require("oil").toggle_float)
    end
  },
  {
    "Eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
    end
  }
}
