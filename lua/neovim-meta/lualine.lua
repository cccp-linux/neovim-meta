local function debug_button(icon, cmd, hl_name, is_last)

    local hl = vim.api.nvim_get_hl(0, {name = hl_name, link = false})
    hl = string.format("#%06x", hl.fg or 0x999999)

    return {
        function() return icon end,
        cond = function() return vim.g.termdebug_is_running end,
        color = { fg = hl },
        on_click = function() vim.cmd(cmd) end,
        separator = "",
        padding = { left = 1, right = is_last and 1 or 0 },
    }
end

require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_b = {
            { "branch", icon = "󰊢" },
            { "diff", symbols = { modified = "≠" } },
            { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } }
        },
        lualine_c = { { "filename", symbols = { modified = "+", readonly = "󰍁" } } },
        lualine_x = {
            debug_button("", "Continue", "DiagnosticOk"),
            debug_button("", "Over",   "DiagnosticInfo"),
            debug_button("", "Step",   "DiagnosticInfo"),
            debug_button("", "Finish", "DiagnosticInfo"),
            debug_button("󱔕", "Until",  "DiagnosticInfo"),
            debug_button("", "Stop",   "DiagnosticError", true),
            "encoding",
            "fileformat",
            "filetype"
        }
    },
    tabline = {
        lualine_a = { { "buffers", symbols = { modified = "+" } } },
        lualine_z = { { "tabs",    symbols = { modified = "+" } } }
    }
})
