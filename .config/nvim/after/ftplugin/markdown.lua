-- table mode
vim.api.nvim_set_keymap('n', 'tm', ':TableModeToggle<Enter>', {})

-- rendering
vim.keymap.set('n', 'mp', ':MarkdownPreview<Enter>', {})
vim.keymap.set('n', 'mr', ':RenderMarkdown toggle<Enter>', {})
