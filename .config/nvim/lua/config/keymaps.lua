-- Exit insert mode
vim.keymap.set("i", "jj", "<Esc>", { desc = "Esc" })

-- Yank to end of line
vim.keymap.set("n", "Y", "y$")

-- Center search result
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Prev search result and center" })

-- Center up & down movement
vim.keymap.set("n", "<C-u>", "<C-u>zzzv", { desc = "Center up" })
vim.keymap.set("n", "<C-d>", "<C-d>zzzv", { desc = "Center down" })
