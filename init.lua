vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

local Plug = vim.fn['plug#']
vim.call('plug#begin')

Plug('Shatur/neovim-ayu')

Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('junegunn/fzf')
Plug('junegunn/fzf.vim')

vim.call('plug#end')

local colors = require('ayu.colors')
colors.generate()

require('ayu').setup({
  overrides = {
    Normal = { bg = "None" },
    NormalFloat = { bg = "none" },
    ColorColumn = { bg = "None" },
    SignColumn = { bg = "None" },
    Folded = { bg = "None" },
    FoldColumn = { bg = "None" },
    CursorColumn = { bg = "None" },
    LineNr = { fg = colors.fg },
    VertSplit = { bg = "None" },
  }
})

require('ayu').colorscheme()

local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered()
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
  }, {
    { name = 'buffer' }
  })
})

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  soruces = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig')['pylsp'].setup {
  capabilities = capabilities
}

