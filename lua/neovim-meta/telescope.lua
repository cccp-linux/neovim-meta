local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, {noremap = true})
end

require("telescope").setup({
    defaults = {
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
        find_files= { prompt_title = "Files",  preview_title = "Preview" },
        help_tags = { propmt_title = "Help",   preview_title = "Preview" },
        live_grep = { prompt_title = "Search", preview_title = "Preview" },
        man_pages = { prompt_title = "Man",    preview_title = "Preview" },

        lsp_document_symbols = {
            prompt_title = "Symbols",
            preview_title = "Preview",
            symbols = { "Class", "Constructor", "Enum", "Function", "Interface", "Module", "Method", "Struct" }
        },
        lsp_workspace_symbols = { prompt_title = "Workspace", preview_title = "Preview" },
    },
})
require("telescope").load_extension("fzf")

local builtin = require("telescope.builtin")
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>fm", builtin.man_pages)
map("n", "<leader>fr", builtin.resume)
map("n", "<leader>fs", builtin.lsp_document_symbols)
map("n", "<leader>fw", builtin.lsp_workspace_symbols)
