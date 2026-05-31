local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {noremap = true})
end

local scope = require("telescope.builtin")
map("n", "<leader>fb", scope.buffers)
map("n", "<leader>ff", scope.find_files)
map("n", "<leader>fg", scope.live_grep)
map("n", "<leader>fh", scope.help_tags)
map("n", "<leader>fm", scope.man_pages)
map("n", "<leader>fr", scope.resume)
