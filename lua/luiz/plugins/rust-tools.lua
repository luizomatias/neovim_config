-- import lspconfig plugin safely
local status, rust_tool = pcall(require, "rust-tools")
if not rust_tool then
	return
end

local keymap = vim.keymap -- for conciseness


rust_tool.setup({
    server = {
      on_attach = function(_, bufnr)
        -- Hover actions
        keymap.set("n", "<C-space>", rust_tool.hover_actions.hover_actions, { buffer = bufnr })
        -- Code action groups
        keymap.set("n", "<Leader>a", rust_tool.code_action_group.code_action_group, { buffer = bufnr })
      end,
    },
  })