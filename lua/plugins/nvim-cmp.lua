return {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

        'hrsh7th/vim-vsnip',
        'hrsh7th/vim-vsnip-integ',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
    opts = {
      sources = {
        {
          name = 'path',
          option = {
            trailing_slash = true,
          },
        },
      },
    },
  }
