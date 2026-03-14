return {
  {
    'echasnovski/mini.nvim',
    config = function()
      local move = require 'mini.move'
      local files = require 'mini.files'
      local git = require 'mini.git'
      local indentscope = require 'mini.indentscope'
      local icons = require 'mini.icons'
      local misc = require 'mini.misc'
      move.setup {
        mappings = {
          left = '<C-h>',
          right = '<C-l>',
          up = '<C-k>',
          down = '<C-j>',
        } }
      indentscope.setup()
      icons.setup()
      files.setup {
        mappings = {
          close = '<C-c>'
        },
        windows = {
          preview = true,
          width_preview = 40,
          width_focus = 30,
          width_nofocus = 10,
        }
      }
      git.setup()
      vim.keymap.set("n", "-", MiniFiles.open)
      misc.setup()
      misc.setup_auto_root()
    end
  }
}
