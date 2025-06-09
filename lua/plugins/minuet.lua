return {
  'milanglacier/minuet-ai.nvim',
  config = function()
    require('minuet').setup {
      provider = 'codestral',
      provider_options = {
        api_key = "CODESTRAL_API_KEY",
      },
      lsp = {
        enabled_ft = { 'php', 'blade', 'lua', 'rust', 'cpp', 'aff' }
      },
      virtualtext = {
        keymap = {
          -- accept whole completion
          accept = '<C-l>',
          -- accept one line
          accept_line = '<C-a>',
          -- accept n lines (prompts for number)
          -- e.g. "A-z 2 CR" will accept 2 lines
          accept_n_lines = '<C-z>',
          -- Cycle to prev completion item, or manually invoke completion
          prev = '<C-p>',
          -- Cycle to next completion item, or manually invoke completion
          next = '<C-n>',
          dismiss = '<C-e>',
        },
      },
    }
  end
}
