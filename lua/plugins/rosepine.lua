return {
  {
    "rose-pine/neovim",
    config = function()
      require("rose-pine").setup({
        styles = {
          italic = false,
          transparency = true,
        },
      })
      vim.cmd("colorscheme rose-pine")
    end
  }
}
