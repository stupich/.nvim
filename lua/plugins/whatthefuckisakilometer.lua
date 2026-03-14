return {
  {
    "Eandrju/cellular-automaton.nvim",
    config = function()
      vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")
    end
  },
  {
    "sahaj-b/brainrot.nvim",
    event = "VeryLazy",
    opts = {
      disable_phonk = true,
      sound_enabled = true
    }
  }
}
