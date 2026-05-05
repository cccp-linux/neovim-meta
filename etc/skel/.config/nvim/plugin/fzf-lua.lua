local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {noremap = true})
end

local fzf = require("fzf-lua")

map("n", "<leader>fa", fzf.global)
map("n", "<leader>fb", fzf.buffers)
map("n", "<leader>ff", fzf.files)
map("n", "<leader>fg", fzf.live_grep)
map("n", "<leader>fh", fzf.helptags)
map("n", "<leader>fm", fzf.manpages)
map("n", "<leader>fr", fzf.resume)
