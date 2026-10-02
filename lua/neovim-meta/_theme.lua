local palette = require("gruvbox").palette

require("gruvbox").setup({
    italic = { strings = false, comments = false },
    overrides = {
        LspReferenceRead  = { bg = palette.dark2 },
        LspReferenceText  = { bg = palette.dark2 },
        LspReferenceWrite = { bg = palette.dark2 },
        SignColumn = { bg = "NONE" }
    }
})

require("tokyonight").setup({
    styles = {
        comments = { italic = false },
        keywords = { italic = false },
    }
})

vim.cmd("colorscheme gruvbox")
