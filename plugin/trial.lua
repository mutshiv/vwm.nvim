local vwm = require('vwm')

vwm.setup = function(opts)
    opts = opts or {}

    vim.api.nvim_set_keymap('n', opts.map or '<leader>zw', '<cmd>lua require("vwm").main_win()<CR>',
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', opts.map or '<leader>zi', '<cmd>lua require("vwm").input_win()<CR>',
        { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', opts.map or '<leader>zs', '<cmd>lua require("vwm").send_to_main_win()<CR>',
        { noremap = true, silent = true })
end

vwm.setup()
