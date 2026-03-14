require("config.lazy")


--neovide specific stuff

if vim.g.neovide then
    vim.o.cmdheight = 0
    vim.g.neovide_cursor_hack = true
    vim.g.neovide_padding = -10 
    vim.g.neovide_scale_factor = 1.0
    local change_scale_factor = function(delta)
        vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-+>", function()
        change_scale_factor(1.05)
    end)
    vim.keymap.set("n", "<C-->", function()
        change_scale_factor(1 / 1.05)
    end)
    vim.keymap.set("n", "<C-=>", function()
        vim.g.neovide_scale_factor = 1.0
    end)
    vim.keymap.set('v', '<M-c>', '"+y')    -- Copy
    vim.keymap.set('n', '<M-v>', '"+P')    -- Paste normal mode
    vim.keymap.set('v', '<M-v>', '"+P')    -- Paste visual mode
    vim.keymap.set('c', '<M-v>', '<C-R>+') -- Paste command mode
end
--options
vim.opt.scrolloff = 14
vim.opt.sidescrolloff = 80
vim.o.winborder = "rounded"
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.signcolumn = "yes"
vim.opt.colorcolumn = "80"
vim.lsp.set_log_level("ERROR")

--keymaps
vim.keymap.set('n', "<leader><leader>x", ":source<CR>")
vim.keymap.set("n", "<c-j>", "<c-w><c-j>")
vim.keymap.set("n", "<c-k>", "<c-w><c-k>")
vim.keymap.set("n", "<c-l>", "<c-w><c-l>")
vim.keymap.set("n", "<c-h>", "<c-w><c-h>")
vim.keymap.set("n", "<M-h>", "<c-w>5<")
vim.keymap.set("n", "<M-l>", "<c-w>5>")
vim.keymap.set("n", "<M-k>", "<C-W>+")
vim.keymap.set("n", "<M-j>", "<C-W>-")
vim.keymap.set("n", "J", "mzJ'z")
vim.keymap.set("n", "<leader>ut", "<cmd>UndotreeToggle<CR>")
vim.keymap.set("n", "<C-d>", "<C-d>zzzv")
vim.keymap.set("n", "<C-u>", "<C-u>zzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("v", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+y$")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<C-c>", "<cmd>nohlsearch<CR>")


vim.api.nvim_create_user_command('ItsTimeToGoToBed', function()
    vim.cmd('terminal mpv --vo=tct --really-quiet ~/Videos/areyare.mp4')
end, {})
vim.api.nvim_create_autocmd('textyankpost', {
    desc = 'Highlight',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
