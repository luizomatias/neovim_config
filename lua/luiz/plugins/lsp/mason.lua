-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
	return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
	return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
	return
end

-- enable mason
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		"lua_ls",
		"emmet_ls",
		"rust_analyzer",
		"pyre",
		"pyright",
		"pylyzer",
		"sourcery",
		"pylsp",
		"ruff_lsp",
		"golangci_lint_ls",
		"gopls",
		"jsonls",
		"yamlls",
		"dockerls",
		"docker_compose_language_service",
		"marksman",
		"prosemd_lsp",
		"remark_ls",
		"zk",
	},
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"stylua", -- lua formatter
		"eslint_d", -- ts/js linter
		"autoflake", -- flake8,
		"autopep8",
		"black",
		"rustfmt",
		"rustywind",
		"flake8",
		"golangci-lint",
		"mypy",
		"pylint",
		"pyproject-flake8",
		"pyre",
		"rstcheck",
		"yamllint"
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
