-- basic options
vim.opt.completeopt = { "menu", "menuone", "noinsert" }
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"
vim.opt.expandtab = true
vim.opt.fillchars = {
    eob = "·",
    foldclose= "",
    foldopen = "",
    foldsep  = "",
}
vim.opt.diffopt:append("foldcolumn:1")
vim.opt.foldcolumn = "auto:1"
vim.opt.keywordprg = ":help"
vim.opt.list = true
vim.opt.listchars = { tab = "  ", trail = "·" }
vim.opt.number = true
vim.opt.numberwidth = 3
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.timeoutlen = 500

-- functions
function create_alias(alias, cmd)
    vim.cmd(string.format(
        "cnoreabbrev <expr> %s getcmdtype() == ':' && getcmdline() ==# '%s' ? '%s' : '%s'",
        alias, alias, cmd, alias
    ))
end

local function map(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { noremap = true })
end

local function toggle_loclist()
    local loc = vim.fn.getloclist(0, { winid = 0, size = 0 })
    vim.cmd((loc.winid > 0) and "lclose" or (loc.size > 0) and "lopen" or "echo 'No locations'")
end

local function toggle_quickfix()
    local qf = vim.fn.getqflist({ winid = 0 })
    vim.cmd((qf.winid > 0) and "cclose" or "copen")
end

function buffer_close(opts)
    local cur = vim.api.nvim_get_current_buf()

    if not (opts and opts.bang) and vim.bo[cur].modified then
        vim.notify("Buffer is modified (use ! to override).", vim.log.levels.WARN)
        return
    end

    local new
    for _, win in ipairs(vim.fn.win_findbuf(cur)) do
        local prev = vim.api.nvim_win_call(win, function() return vim.fn.bufnr("#") end)

        if prev == -1 or prev == cur or not vim.api.nvim_buf_is_loaded(prev) then
            prev = nil

            local loaded = vim.fn.getbufinfo({ buflisted = 1, bufloaded = 1 })
            table.sort(loaded, function(a, b) return a.lastused > b.lastused end)

            for _, buf in ipairs(loaded) do
                if buf.bufnr ~= cur then
                    prev = buf.bufnr
                    break
                end
            end

            if not prev then
                new = new or vim.api.nvim_create_buf(true, false)
                prev = new
            end
        end

        pcall(vim.api.nvim_win_set_buf, win, prev)
    end

    if vim.api.nvim_buf_is_valid(cur) then
        vim.api.nvim_buf_delete(cur, { force = true, unload = true })
    end
    if vim.api.nvim_buf_is_valid(cur) then vim.bo[cur].buflisted = false end
end

-- commands & aliases
vim.api.nvim_create_user_command("Bclose", buffer_close, { bang = true })
create_alias("bx", "Bclose")

create_alias("wc", "w\\|wincmd c")
create_alias("wd", "w\\|bd")
create_alias("wx", "w\\|Bclose")

-- basic maps
map({ "n", "t" }, "<m-h>", "<cmd>wincmd h<cr>")
map({ "n", "t" }, "<m-j>", "<cmd>wincmd j<cr>")
map({ "n", "t" }, "<m-k>", "<cmd>wincmd k<cr>")
map({ "n", "t" }, "<m-l>", "<cmd>wincmd l<cr>")

map("n", "<leader>c", "<cmd>wincmd c<cr>")
map("n", "<leader>d", "<cmd>bd<cr>")
map("n", "<leader>D", "<cmd>bd!<cr>")
map("n", "<leader>l", toggle_loclist)
map("n", "<leader>n", "<cmd>enew<cr>")
map("n", "<leader>q", toggle_quickfix)
map("n", "<leader>s", "<cmd>sp<cr>")
map("n", "<leader>v", "<cmd>vs<cr>")
map("n", "<leader>w", function() vim.wo.wrap = not vim.wo.wrap end)
map("n", "<leader>x", buffer_close)
map("n", "<leader>X", function() buffer_close({ bang = true }) end)
map("n", "<leader>y", "\"+y")
map("v", "<leader>y", "\"+y")
map("n", "<leader>Y", "\"+Y")

map("n", "<leader>t", "<cmd>tabnew<cr>")
map("n", "[t", "<cmd>tabprev<cr>")
map("n", "[T", "<cmd>tabfirst<cr>")
map("n", "]t", "<cmd>tabnext<cr>")
map("n", "]T", "<cmd>tablast<cr>")

map("n", "zr", "<cmd>spellr<cr>")
map("n", "<leader>z", "<cmd>setlocal spell! spell?<cr>")

map("i", "jk", "<esc>")
map("i", "kj", "<esc>")

-- terminal
map("t", "<esc><esc>", "<c-\\><c-n>")

vim.api.nvim_create_autocmd({ "TermOpen", "BufEnter" }, { pattern = "*",
    callback = function() if vim.bo.buftype == "terminal" then vim.cmd("startinsert") end end
})

-- diagnostics
vim.diagnostic.config({
    signs = { text = {
        [ vim.diagnostic.severity.ERROR ] = "",
        [ vim.diagnostic.severity.WARN  ] = "",
        [ vim.diagnostic.severity.INFO  ] = "",
        [ vim.diagnostic.severity.HINT  ] = "",
    } },
    severity_sort = true,
})
