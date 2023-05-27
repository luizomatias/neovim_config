-- import buffer plugin safely
local status, buffer = pcall(require, "bufferline")
if not status then
  return
end

buffer.setup(
    {options = {
        diagnostics = "nvim_lsp",
    }
}
)
