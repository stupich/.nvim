return {
  {
    "Saghen/blink.cmp",
    version = '1.4.1',
    opts = {
      keymap = {
        preset = 'default',
        ['<C-n>'] = { 'show', 'select_next' },
      },
      completion = {
        ghost_text = { enabled = true },
        menu = {
          auto_show = false,
          border = 'single',
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 0 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        documentation = { auto_show = true, window = { border = 'single' }, },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
      },
      appearance = {
        nerd_font_variant = 'mono'
      },
      sources = {
        default = { 'lazydev', 'lsp', 'path' },
        providers = {
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
            -- make lazydev completions top priority (see `:h blink.cmp`)
            score_offset = 100,
          },
        },
      },
      signature = { enabled = true, window = { border = 'single' } }
    },
    fuzzy = { implementation = "prefer_rust" },

    -- allows extending the providers array elsewhere in your config
    -- without having to redefine it
    opts_extend = { "sources.default" }

  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      'Saghen/blink.cmp',
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
    opts = { servers = { lua_ls = {}, rust_analyzer = {}, qmlls = { cmd = { "qmlls6", "-E" } } } },
    config = function(_, opts)
      for server, config in pairs(opts.servers) do
        vim.lsp.config(server, config)
        vim.lsp.enable(server)
      end
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          vim.keymap.set('n', '<C-q>', function()
            if vim.diagnostic.config().virtual_lines then
              vim.diagnostic.config({ virtual_lines = false })
            else
              vim.diagnostic.config({ virtual_lines = { current_line = true } })
            end
          end
          )
          vim.keymap.set('n', '<M-d>', function()
            local new_state = not vim.diagnostic.config().virtual_lines.current_line
            vim.diagnostic.config({ virtual_lines = { current_line = new_state } })
          end
          )

          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting') then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
              buffer = args.buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end
      })
    end,
  },
  {
    "xzbdmw/colorful-menu.nvim",
    config = function()
      require('colorful-menu').setup({
        ls = {
          lua_ls = {
            extra_info_hl = "@comment",
            align_type_to_right = true,
            preserve_type_when_truncate = true,
          },
          rust_analyzer = {
            extra_info_hl = "@comment",
            align_type_to_right = true,
            preserve_type_when_truncate = true,
          },
        },
        fallback_highlight = "@variable",
        max_width = 60,
      })
    end
  },
}
