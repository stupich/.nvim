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
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local serv = { zls = { cmd = 'usr/bin/zls' }, gopls = {} }
      serv.capabilities = vim.tbl_deep_extend('force', {}, capabilities)
      vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename)
      vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action)
      require("lspconfig").pyright.setup {}
      require("lspconfig").lua_ls.setup {}
      require("lspconfig").gopls.setup(serv)
      require("lspconfig").rust_analyzer.setup {}
      require("lspconfig").zls.setup(serv)
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
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      "hrsh7th/cmp-buffer",
      { "L3MON4D3/LuaSnip", build = 'make install_jsregexp' },
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "onsails/lspkind.nvim",
    },
    config = function()
      local lspkind = require "lspkind"
      lspkind.init {}
      local cmp = require 'cmp'
      cmp.setup {
        completion = { completeopt = 'menu,menuone,noinsert' },
        mapping = cmp.mapping.preset.insert {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-y>'] = cmp.mapping.confirm { select = true },
        },
        sources = {
          { name = 'lazydev', group_index = 0, },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'buffer' },
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      }
      local ls = require "luasnip"
      ls.config.set_config {
        history = false,
        updateevents = "TextChanged,TextChangedI",
      }
      ls.config.setup {}
      vim.keymap.set({ "i", "s" }, "<c-l>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        end
      end, { silent = true })
      vim.keymap.set({ "i", "s" }, "<c-h>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end
  },
}
