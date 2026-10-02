require("oil").setup({
    columns = {
        "icon",
        -- "permissions",
        -- "size",
        -- "mtime",
    },
    confirmation = {border = "rounded"},
    view_options = {show_hidden = true},
    watch_for_changes = true,
})

vim.keymap.set("n", "-", "<cmd>Oil<cr>", {noremap = true})
