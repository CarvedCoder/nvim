return {
  'nvimtools/none-ls.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim', -- Required by none-ls.nvim
    'nvimtools/none-ls-extras.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    local null_ls = require 'null-ls'
    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    -- Configure mason-null-ls first
    require('mason-null-ls').setup {
      ensure_installed = {
        'prettier',
        'stylua',
        'eslint_d',
        'shfmt',
        'checkmake',
        'ruff',
        'clangd',

      },
      automatic_installation = true,
    }

    -- Configure none-ls sources
    null_ls.setup {
      sources = {
        diagnostics.checkmake,

        formatting.prettier.with {
          filetypes = { 'html', 'json', 'yaml', 'markdown' },
        },

        formatting.stylua,

        formatting.shfmt.with {
          args = { '-i', '4' },
        },

        -- Use direct builtins instead of none-ls-extras requires
        diagnostics.ruff,
        formatting.ruff,
      },

      on_attach = function(client, bufnr)
        if client.supports_method 'textDocument/formatting' then
          vim.api.nvim_create_autocmd('BufWritePre', {
            group = vim.api.nvim_create_augroup('LspFormatting', {}),
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                async = false,
                filter = function(c)
                  return c.name == 'null-ls'
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
