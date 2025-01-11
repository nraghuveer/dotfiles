require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "lua_ls", "gopls", "clangd", "terraformls", "zls", "pyright" }
})
require("ibl").setup()

vim.cmd("set scl=yes")
vim.cmd("set autoindent noexpandtab tabstop=4 shiftwidth=4 invlist")
vim.cmd("set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣")
vim.cmd("set list")

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspsaga').setup({
  symbol_in_winbar = {
    in_custom = false,
    enable = true,
    separator = ' ',
    show_file = true,
    file_formatter = ""
  },
})


-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local keymap = vim.keymap.set

    -- LSP finder - Find the symbol's definition
    -- If there is no definition, it will instead be hidden
    -- When you use an action in finder like "open vsplit",
    -- you can use <C-t> to jump back
    keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>")

    -- Code action
    keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>")

    -- Rename all occurrences of the hovered word for the entire file
    keymap("n", "<leader>vrn", "<cmd>Lspsaga rename<CR>")

    -- Rename all occurrences of the hovered word for the selected files
    -- keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>")

    -- Peek definition
    -- You can edit the file containing the definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "<leader>vpd", "<cmd>Lspsaga peek_definition<CR>")

    -- Go to definition
    keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
    -- Show references
    vim.keymap.set('n', 'gr', vim.lsp.buf.references)

    -- Peek type definition
    -- You can edit the file containing the type definition in the floating window
    -- It also supports open/vsplit/etc operations, do refer to "definition_action_keys"
    -- It also supports tagstack
    -- Use <C-t> to jump back
    keymap("n", "<leader>vpt", "<cmd>Lspsaga peek_type_definition<CR>")

    -- Go to type definition
    keymap("n", "<leader>vgt", "<cmd>Lspsaga goto_type_definition<CR>")


    -- Show line diagnostics
    -- You can pass argument ++unfocus to
    -- unfocus the show_line_diagnostics floating window
    keymap("n", "<leader>vdl", "<cmd>Lspsaga show_line_diagnostics<CR>")

    -- Show buffer diagnostics
    keymap("n", "<leader>vdb", "<cmd>Lspsaga show_buf_diagnostics<CR>")

    -- Show workspace diagnostics
    keymap("n", "<leader>vdw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")

    -- Show cursor diagnostics
    keymap("n", "<leader>vdc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

    -- Diagnostic jump
    -- You can use <C-o> to jump back to your previous location
    keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
    keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

    -- Diagnostic jump with filters such as only jumping to an error
    keymap("n", "[E", function()
      require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
    end)
    keymap("n", "]E", function()
      require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
    end)

    -- Toggle outline
    keymap("n", "<leader>vso", "<cmd>Lspsaga outline<CR>")

    -- Hover Doc
    -- If there is no hover doc,
    -- there will be a notification stating that
    -- there is no information available.
    -- To disable it just use ":Lspsaga hover_doc ++quiet"
    -- Pressing the key twice will enter the hover window
    keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

    -- If you want to keep the hover window in the top right hand corner,
    -- you can pass the ++keep argument
    -- Note that if you use hover with ++keep, pressing this key again will
    -- close the hover window. If you want to jump to the hover window
    -- you should use the wincmd command "<C-w>w"
    -- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")

    -- Call hierarchy
    keymap("n", "<leader>vci", "<cmd>Lspsaga incoming_calls<CR>")
    keymap("n", "<leader>vco", "<cmd>Lspsaga outgoing_calls<CR>")

    -- Floating terminal
    keymap({ "n", "t" }, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
  end,
})


-- python
require("lspconfig").pyright.setup {
  -- on_attach = require("lsp-format").on_attach,
  capabilities = capabilities,
  -- settings = {
  --   -- pyright = { autoImportCompletion = true, },
  --   python = {
  --     analysis = {
  --       -- autoSearchPaths = true, diagnosticMode = 'openFilesOnly', useLibraryCodeForTypes = true, typeCheckingMode = 'off'
  --     }
  --   }
  -- }
}




-- Lua
require("lspconfig").lua_ls.setup {
  on_attach = require("lsp-format").on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.stdpath "config" .. "/lua"] = true,
        },
      },
    },
  }
}

-- gopls
require("lsp-format").setup {}
require("lspconfig").gopls.setup {
  capabilities = capabilities,
  on_attach = require("lsp-format").on_attach,
  cmd = { "gopls", "serve" },
  filetypes = { "go", "gomod" },
  root_dir = require("lspconfig/util").root_pattern("go.work", "go.mod", ".git"),
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
}

--terraform
require('lspconfig').terraformls.setup {}

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.tf", "*.tfvars" },
  callback = function()
    vim.lsp.buf.format()
  end
})

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

