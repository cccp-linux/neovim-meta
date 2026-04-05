require("lualine").setup {
    sections= {
        lualine_b = {
            {"branch", icon = "󰊢"},
            {"diff", symbols = {modified = "≠"}},
            {"diagnostics", symbols = {error = " ", warn = " ", info = " ", hint = " "}}
        },
        lualine_c = { {"filename", symbols = {modified= "+", readonly= "󰍁"}} }
    },
    tabline = {
        lualine_a = { {"buffers", symbols = {modified = "+"}} },
        lualine_z = { {"tabs",    symbols = {modified = "+"}} }
    }
}
