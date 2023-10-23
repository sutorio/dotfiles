-- vim:fileencoding=utf-8:foldmethod=marker
-- =============================================================================
-- IDE setup: LSP functionality, completions, snippets, formatting etc.
-- =============================================================================
-- {{{ Aliases
-- =============================================================================
local lspconfig = require("lspconfig")
local lsp_defaults = lspconfig.util.default_config
-- }}}
-- =============================================================================
-- {{{ LSP server custom rules (overrides defaults)
-- =============================================================================
local deno_ls_custom_config = function()
  lspconfig.denols.setup({
    root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  })
end

local emmet_ls_custom_config = function()
  lspconfig.emmet_ls.setup({
    -- The Emmet language server requires hints re. which extensions it
    -- should provide completions for. I only care about HTML/HTML templating
    filetypes = {
      "html",
      "heex",
      "eex",
      "njk",
    },
  })
end

local jsonls_custom_config = function()
  lspconfig.jsonls.setup({
    settings = {
      json = {
        schemas = require("schemastore").json.schemas(),
      },
    },
  })
end

local lua_ls_custom_config = function()
  lspconfig.lua_ls.setup({
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        completion = {
          callSnippet = "Replace",
        },
        diagnostics = {
          enable = true,
          -- The Lua language server is being used for Neovim stuff,
          -- globals listed relate to Neovim development.
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file("", true),
          maxPreload = 10000,
          preloadFileSize = 10000,
          checkThirdParty = false,
        },
        telemetry = { enable = false },
      },
    },
  })
end

local tsserver_custom_config = function()
  lspconfig.tsserver.setup({
    root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json"),
    single_file_support = false,
  })
end
-- =============================================================================
-- {{{ Formatters
-- =============================================================================
require("conform").setup({
  formatters_by_ft = {
    css = { "prettierd" },
    lua = { "stylua" },
    javascript = { "deno_fmt" },
    typescript = { "deno_fmt" },
    markdown = { "deno_fmt" },
    json = { "deno_fmt" },
    jsonc = { "deno_fmt" },
  },
})
-- }}}
-- =============================================================================
-- {{{ Completions setup
-- =============================================================================
local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  },
  mapping = cmp.mapping.preset.insert({
    -- Enter key confirms completion item
    ["<CR>"] = cmp.mapping.confirm({ select = false }),

    -- Ctrl + space triggers completion menu
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})
-- }}}
-- =============================================================================
-- {{{ LSP: config functions
-- =============================================================================
local InitDiagnosticsUi = function()
  local diagnostics = {
    Error = "",
    Hint = "",
    Information = "",
    Question = "",
    Warning = "",
  }

  local signs = {
    { name = "DiagnosticSignError", text = diagnostics.Error },
    { name = "DiagnosticSignWarn", text = diagnostics.Warning },
    { name = "DiagnosticSignHint", text = diagnostics.Hint },
    { name = "DiagnosticSignInfo", text = diagnostics.Info },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(
      sign.name,
      { texthl = sign.name, text = sign.text, numhl = sign.name }
    )
  end

  -- LSP handlers configuration
  local config = {
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
    },

    diagnostic = {
      -- virtual_text = { severity = vim.diagnostic.severity.ERROR },
      virtual_text = false,
      signs = {
        active = signs,
      },
      underline = true,
      update_in_insert = false,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    },
  }

  vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    callback = function()
      vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end,
    desc = "Open a diagnostic popup under the cursor",
  })

  vim.diagnostic.config(config.diagnostic)
  -- NOTE: this is being handled by noice.nvim
  -- vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, config.float)
  -- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, config.float)
end

local InitHighlighting = function(client, bufnr)
  if client.server_capabilities.documentHighlightProvider then
    -- Set up an augroup for LSP highlighting...
    local lsp_highlight_grp =
      vim.api.nvim_create_augroup("LspDocumentHighlight", { clear = true })

    -- ...then apply
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = function()
        vim.schedule(vim.lsp.buf.document_highlight)
      end,
      group = lsp_highlight_grp,
      buffer = bufnr,
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = function()
        vim.schedule(vim.lsp.buf.clear_references)
      end,
      group = lsp_highlight_grp,
      buffer = bufnr,
    })
  end
end

local InitFormatting = function(client)
  -- NOTE: I give up. The built in formatting works...sometimes. Most of the time
  -- it's an ultra-frustrating garbage fire.
  client.server_capabilities.document_formatting = true
  client.server_capabilities.document_range_formatting = true

  vim.keymap.set("n", "<leader>ef", function()
    require("conform").format({ lsp_fallback = true })
  end, { desc = "format document" })
end

-- }}}
-- =============================================================================
-- {{{ Copilot setup
-- =============================================================================
local SetupCopilot = function()
    -- TODO: tweak this. In particular, I want copilot to start/stop on-demand.
    --       The server takes a while to start, so just setting up straightaway
    --       is gonna make NVim hang to fuck.
    --       See: https://github.com/zbirenbaum/copilot.lua
    require('copilot').setup()
end
-- }}}
-- =============================================================================
-- {{{ LSP: finalise setup
-- =============================================================================

InitDiagnosticsUi()
SetupCopilot()

lsp_defaults.capabilities = vim.tbl_deep_extend(
  "force",
  lsp_defaults.capabilities,
  require("cmp_nvim_lsp").default_capabilities()
)

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local buffer = event.buf
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    local opts = { buffer = buffer }

    -- stylua: ignore start
    vim.keymap.set("n", "K",    vim.lsp.buf.hover,           opts)
    vim.keymap.set("n", "gd",   vim.lsp.buf.definition,      opts)
    vim.keymap.set("n", "gD",   vim.lsp.buf.declaration,     opts)
    vim.keymap.set("n", "gi",   vim.lsp.buf.implementation,  opts)
    vim.keymap.set("n", "go",   vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr",   vim.lsp.buf.references,      opts)
    vim.keymap.set("n", "gs",   vim.lsp.buf.signature_help,  opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename,          opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action,     opts)
    vim.keymap.set("n", "gl",   vim.diagnostic.open_float,   opts)
    vim.keymap.set("n", "[d",   vim.diagnostic.goto_prev,    opts)
    vim.keymap.set("n", "]d",   vim.diagnostic.goto_next,    opts)
    -- stylua: ignore end

    InitHighlighting(client, buffer)
    InitFormatting(client)
  end,
})

local default_setup = function(server)
  lspconfig[server].setup({})
end

require("mason").setup({})
require("mason-lspconfig").setup({
  ensure_installed = {},
  handlers = {
    default_setup,
    denols = deno_ls_custom_config,
    emmet_ls = emmet_ls_custom_config,
    jsonls = jsonls_custom_config,
    lua_ls = lua_ls_custom_config,
    tsserver = tsserver_custom_config,
  },
})
-- }}}
-- =============================================================================
