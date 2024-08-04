return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Completion Sources
    {'hrsh7th/cmp-nvim-lsp'},               -- LSP completion
    {'hrsh7th/cmp-nvim-lua'},               -- Custom lua for terminal mode
    {'hrsh7th/cmp-buffer'},                 -- For things in the current buf
    {'hrsh7th/cmp-path'},                   -- For filesystem paths
    {'hrsh7th/cmp-cmdline' },               -- Terminal mode completion
    {'saadparwaiz1/cmp_luasnip'},           -- Completion for LuaSnip
    {'hrsh7th/cmp-nvim-lsp-signature-help'},-- Emphasizes current param when calling functions

    -- Snippets engine
    {'L3MON4D3/LuaSnip'},
  },
  lazy = false,
  config = function()
    -- And you can configure cmp even more, if you want to.
    local cmp = require('cmp')
    local luasnip = require('luasnip')

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),

        -- Remove Enter key mapping for confirmation
        ['<CR>'] = function(fallback)
          fallback()
        end,

        -- Tab to autocomplete
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),

        -- Arrow keys navigation
        ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
        ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      }),
      sources = {
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'luasnip' },
        { name = 'buffer' },
      },
    })

    -- Terminal completion
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' }
      }, {
        { name = 'cmdline' }
      })
    })
  end
}

