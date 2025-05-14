require('config.lazy')

-- ====================================
--         config
-- ====================================
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.completeopt = menu, menuone, noselect
vim.g.mapleader = " "

vim.opt.clipboard = unamed, unnamedplus

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

vim.opt.wrap = false
vim.opt.swapfile = false

-- hide the cmdline behind the status bar
-- vim.opt.cmdheight=1
-- vim.opt.fillchars = { eob = ' ' }
--


vim.opt.textwidth = 100

-- colorscheme
require('catppuccin').setup({
    flavour = "frappe"
});
vim.cmd.colorscheme "catppuccin"


-- Hide line numbers in terminal
--
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    command = "setlocal nonumber norelativenumber signcolumn=no",
})


-- vim.keymap.set('n', "<C-k>", vim.lsp.buf.code_action)
vim.keymap.set('n', "gd", vim.lsp.buf.definition)
vim.keymap.set('n', "ff", vim.lsp.buf.format)
vim.keymap.set('n', "<C-n>", ':vsplit<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show diagnostic" })


vim.keymap.set('n', '<C-u>', ':Neotree toggle reveal<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-i>', ':Neotree focus<CR>', { noremap = true, silent = true })



-- code comments
require('todo-comments').setup {}
vim.keymap.set("x", "gcc", function() require("Comment.api").toggle.linewise(vim.fn.visualmode()) end,
    { noremap = true, silent = true })


-- code action
vim.keymap.set("n", "<C-k>", function()
    require("tiny-code-action").code_action()
end, { noremap = true, silent = true })

--
-- ====================================
--         telescope config
-- ====================================
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>jj', builtin.git_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })



--
-- TODO

vim.keymap.set('n', "<leader>td", ":TodoTelescope<CR>", { noremap = true, silent = true })

require('nvim-autopairs').setup {}


-- ====================================
--         lsp config
-- ====================================
--

-- HTML
vim.lsp.config['vscode-html-language-server'] = {
    cmd = { 'vscode-html-language-server', '--stdio' },
    filetypes = { 'html', 'templ' },
    single_file_support = true,
    settings = {},
    init_options = {
        provideFormatter = true,
        embeddedLanguages = { css = true, javascript = true },
        configurationSection = { 'html', 'css', 'javascript' },
    }
}

-- TYPESCRIPT LSP
require('lspconfig').ts_ls.setup {}
-- vim.lsp.config['typescript-language-server'] = {
-- 	cmd = { 'typescript-language-server', '--stdio' },
-- }
-- vim.lsp.enable('typescript-language-server')

-- LUA LSP
vim.lsp.config['luals'] = {
    cmd = { 'lua-language-server' },
    filetypes = { 'lua' }
}


require("mason").setup()

require("mason-lspconfig").setup {
    automatic_enable = {
        "lua_ls",
        "ts_ls"
    }
}


-- Set up nvim-cmp.
local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete()
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
    }, {
        { name = 'buffer' },
    })
})
