-- set colorscheme to onedark with protected call
local status, onedark = pcall(require, "onedark")
if not status then
  return
end


onedark.setup {
  style = 'deep'
}

onedark.load()