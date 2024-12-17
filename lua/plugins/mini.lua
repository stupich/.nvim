return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local statusline = require 'mini.statusline'
      local move = require 'mini.move'
      local pairs = require 'mini.pairs'
      local indentscope = require 'mini.indentscope'
      statusline.setup { use_icons = true }
      move.setup {
        mappings = {
          left = '<C-h>',
          right = '<C-l>',
          up = '<C-k>',
          down = '<C-j>',
        } }
      pairs.setup {}
      indentscope.setup()
    end
  }
}
