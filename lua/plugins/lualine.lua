return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      local snail = require 'config.snail'
      local mysnail = snail.new_snail()
      local snailopts = snail.default_opts
      local function walksnail()
        mysnail = snail.walk(mysnail, snailopts)
        return snail.show(mysnail, snailopts)
      end
      require('lualine').setup {
        options = { theme = 'moonfly' },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename' },
          lualine_x = { { walksnail }, 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' }
        }
      }
    end
  },
  {
    'lewis6991/gitsigns.nvim',
  }
}
