-- LaTeX render commands
vim.api.nvim_set_keymap('n', '<C-p>', ":!lualatex '" .. vim.fn.expand '%' .. "'<Enter>", {})
vim.api.nvim_set_keymap('n', '<C-b>', ":!bibtex '" .. vim.fn.expand('%'):sub(1, -5) .. "'<Enter>", {})

-- make with control m
vim.api.nvim_set_keymap('n', '<C-m>', ':!make -j <Enter>', {})
