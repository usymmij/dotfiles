-- Typst render
vim.api.nvim_set_keymap("n", "<C-p>", ":!typst compile '" .. vim.fn.expand('%') .. "'<Enter>", {});
