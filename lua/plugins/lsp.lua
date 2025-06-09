return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      {
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            { path = "${3rd}/luv/library", words = { "vim%.uv" } },
          },
        }
      },
    },
    opts = { servers = { tailwindcss = {}, pyright = {}, lua_ls = {}, zls = {}, rust_analyzer = {}, gopls = {}, gdscript = {}, intelephense = {}, ts_ls = {}, clangd = {} } },
    config = function(_, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        -- config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
        vim.diagnostic.config({ virtual_text = { current_line = true } })
        vim.cmd [[set completeopt+=menuone,noselect,popup]]
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(ev)
            local client = vim.lsp.get_client_by_id(ev.data.client_id)
            if client:supports_method('textDocument/completion') and client.name ~= 'minuet' then
              local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
              client.server_capabilities.completionProvider.triggerCharacters = chars
              vim.lsp.completion.enable(true, client.id, ev.buf, {
                autotrigger = true,
              })
            end
          end,
        })
      end
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {},
    opts = {
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = false, cpp = false }
        local lsp_format_opt
        if disable_filetypes[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'never'
        else
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        zig = { 'zig fmt' },
      },
    },
  },
}
