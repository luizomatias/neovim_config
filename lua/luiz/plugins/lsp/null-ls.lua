-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
  return
end

local setup_utils, utils = pcall(require, "lspconfig.util")
if not utils then
  return
end

-- config to pick the python from conda env
local function get_conda_env_name()
  local handle = io.popen("conda info --envs")
  local result = handle:read("*a")
  handle:close()

  local env_name = result:match("%*%s+([^%s]+)")

  return env_name
end

local function create_conda_linter_command(linter_name)
  return function()
    local env_name = get_conda_env_name()
    return utils.path.join(env_name, "bin", linter_name)
  end
end


-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- configure null_ls
null_ls.setup({
  -- setup formatters & linters
  sources = {
    --  to disable file types use
    --  "formatting.prettier.with({disabled_filetypes = {}})" (see null-ls docs)
    formatting.prettier, -- js/ts formatter
    formatting.stylua, -- lua formatter
    formatting.black, -- python formatter
    formatting.isort, -- python formatter
    formatting.autopep8, -- python formatter
    formatting.autoflake, -- python formatter
    formatting.rustfmt, -- rust formatter
    diagnostics.mypy.with({
      command = create_conda_linter_command("mypy"),
      diagnostics_format = "#{m} [#{c}]",
      args = { "--ignore-missing-imports" },
    }), -- python linter
    diagnostics.flake8.with({
      command = create_conda_linter_command("flake8"),
      diagnostics_format = "#{m} [#{c}]",
    }), -- python linter
    diagnostics.pylint.with({
      command = create_conda_linter_command("pylint"),
      diagnostics_format = "#{m} [#{c}]",
    }), -- python linter
    diagnostics.rstcheck, -- python linter
    diagnostics.eslint_d.with({ -- js/ts linter
      -- only enable eslint if root has .eslintrc.js (not in youtube nvim video)
      condition = function(utils)
        return utils.root_has_file(".eslintrc.js") -- change file extension if you use something else
      end,
    }),
  },
  -- configure format on save
  on_attach = function(current_client, bufnr)
    if current_client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({
            filter = function(client)
              --  only use null-ls for formatting instead of lsp server
              return client.name == "null-ls"
            end,
            bufnr = bufnr,
          })
        end,
      })
    end
  end,
})
