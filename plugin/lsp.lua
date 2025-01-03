local cmp = require('cmp')
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- nvim-cmp setup
cmp.setup({
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<CR>'] = cmp.mapping.confirm({ select = false })
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'buffer' },
  }),
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    -- clear all predefined mappings, like 'K' for hover
    vim.cmd("mapclear <buffer>")
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end

    if client.supports_method('textDocument/inlayHint') then
      vim.lsp.inlay_hint.enable(true);
    end

    -- Mappings.
    local opts = { buffer = args.buf, noremap = true, silent = true }
    vim.keymap.set({ 'n', 'v' }, '<Leader>F', function() vim.lsp.buf.format({ async = true }) end, opts)
    vim.keymap.set('n', '<Leader>D', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', '<Leader>d', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Leader>k', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Leader>S', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<Leader>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Leader>R', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<Leader>f', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<Leader>pe', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
    vim.keymap.set('n', '<Leader>ne', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
    vim.keymap.set('n', '<Leader>q', vim.diagnostic.setloclist, opts)
  end,
})

lspconfig.clangd.setup({
  cmd = { "clangd", },
  filetypes = { "c", "cpp" },
  capabilities = capabilities,
})

lspconfig.lua_ls.setup({
  cmd = { "lua-language-server" },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc') then
        return
      end
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
          -- Depending on the usage, you might want to add additional paths here.
          -- "${3rd}/luv/library"
          -- "${3rd}/busted/library",
        }
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        -- library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  },
  capabilities = capabilities,
})
