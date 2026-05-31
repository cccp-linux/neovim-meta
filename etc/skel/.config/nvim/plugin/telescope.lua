local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {noremap = true})
end

require("telescope").setup({
    defaults = {
        borderchars = {
            prompt  = { "─", "│", "─", "│", "╭", "╮", "┤", "├" },
            results = { " ", "│", "─", "│", "│", "│", "╯", "╰" },
            preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        },
        layout_config = {
            horizontal = {
                preview_width = 0.6,
                prompt_position = "top",
            },
        },
        multi_icon = "",
        prompt_prefix = "   ",
        results_title = false,
        selection_caret = "▌ ",
        sorting_strategy = "ascending",
    },
    pickers = {
        buffers = {
            layout_config = {
                width = 50,
            },
            mappings = {
                i = { ["<C-x>"] = "delete_buffer" },
                n = { ["<C-x>"] = "delete_buffer" },
            },
            preview = false,
            results_title = "Ctrl+X to close buffer",
        },
    },
})

local builtin = require("telescope.builtin")
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fm", builtin.man_pages)
map("n", "<leader>fr", builtin.resume)
