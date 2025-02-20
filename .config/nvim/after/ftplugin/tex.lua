-- LaTeX render commands
vim.api.nvim_set_keymap("n", "<C-t>", ":!lualatex '" .. vim.fn.expand('%') .. "'<Enter>", {});
vim.api.nvim_set_keymap("n", "<C-y>", ":!bibtex '" .. vim.fn.expand('%'):sub(1, -5) .. "'<Enter>", {});
