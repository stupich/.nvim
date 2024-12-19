return {
  {
    "Saghen/blink.cmp",
    version = 'v0.7.6',
    dependencies = {
      { "L3MON4D3/LuaSnip", build = 'make install_jsregexp' },
    },
    opts = {
      keymap = { preset = 'default' },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono'
      },

      sources = {
        default = { 'lazydev', 'lsp', 'path', 'luasnip', 'buffer' },
      },

      signature = { enabled = true }
    },
    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }

  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'saghen/blink.cmp',
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
    opts = { servers = { lua_ls = {}, zls = {}, rust_analyzer = {}, gopls = {} } },
    config = function(_, opts)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
      local lspconfig = require('lspconfig')
      for server, config in pairs(opts.servers) do
        -- passing config.capabilities to blink.cmp merges with the capabilities in your
        -- `opts[server].capabilities, if you've defined it
        config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
        lspconfig[server].setup(config)
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
        local disable_filetypes = { c = true, cpp = true }
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
