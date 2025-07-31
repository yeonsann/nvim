require('config.lazy')

-- ====================================
--         config
-- ====================================
vim.g.mapleader = " "
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = menu, menuone, noselect
vim.opt.clipboard = unamed, unnamedplus

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.textwidth = 100

-- show line at column 80
vim.opt.colorcolumn = "100"

-- colorscheme
-- require('catppuccin').setup({
--     flavour = "frappe"
-- });
-- vim.cmd.colorscheme "catppuccin"

-- ====================================
--               keymaps
-- ====================================
vim.keymap.set('n', "gd", vim.lsp.buf.definition)
-- vim.keymap.set({'n', 'v'}, "ff", vim.lsp.buf.format)
vim.keymap.set({'n', 'v'}, "ff", function() 
    require("conform").format({ async = true, lsp_fallback=true})
end, { desc = "Format file or range"})
vim.keymap.set('n', "<C-n>", ':vsplit<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic" })

vim.keymap.set('n', '<C-u>', ':Neotree toggle reveal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-i>', ':Neotree focus<CR>', { noremap = true, silent = true })

-- code action
vim.keymap.set("n", "<C-k>", function()
    require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

-- TODO
vim.keymap.set('n', "<leader>td", ":TodoTelescope<CR>", { noremap = true, silent = true })

-- Toggling terminal
vim.keymap.set('n', "<C-t>", ":ToggleTerm<CR>", { noremap = true, silent = true })
vim.keymap.set('t', "<C-t>", "<Cmd>ToggleTerm<CR>", { noremap = true, silent = true })

-- ====================================
--           toggle term config
-- ====================================
require('toggleterm').setup {
    direction = 'float'
}



-- ====================================
--         telescope config
-- ====================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>jj', builtin.git_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })


-- ====================================
--         plugin config
-- ====================================
require('mini.icons').setup {}
require('mini.pairs').setup {}
require('mini.comment').setup {}
require('mini.statusline').setup {}
require('mini.indentscope').setup {}
require('mini.diff').setup {
    view = {
        style = 'sign'
    }
}
require('mini.cursorword').setup {}

require('nvim-ts-autotag').setup({
  opts = {
    -- Defaults
    enable_close = true, -- Auto close tags
    enable_rename = true, -- Auto rename pairs of tags
    enable_close_on_slash = false -- Auto close on trailing </
  },
  -- Also override individual filetype configs, these take priority.
  -- Empty by default, useful if one of the "opts" global settings
  -- doesn't work well in a specific filetype
  per_filetype = {
    ["html"] = {
      enable_close = true
    }
  }
})

require("conform").setup({
    formatters_by_ft = {
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    typescript = { "prettier" },
    javascript = { "prettier" },
  },
})


-- ====================================
--         lsp config
-- ====================================
--

require("mason").setup()
require("mason-lspconfig").setup {
    automatic_enable = {
        "lua_ls",
        "ts_ls",
        "pyright",
        "black",
        'jdtls',
        "cssls"
    }
}
require('flutter-tools').setup {}

-- Hide line numbers in terminal
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "setlocal nonumber norelativenumber signcolumn=no",
})
