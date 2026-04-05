require("oil").setup({
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    watch_for_changes = true,
    view_options = {show_hidden = true},
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", {noremap = true})
