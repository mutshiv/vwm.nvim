local vwm = require('vwm')

vwm.setup = function(opts)
    opts = opts or {}

    vim.api.nvim_set_keymap('n', opts.map or '<leader>z', '<cmd>lua require("vwm").buildUI()<CR>',
        { noremap = true, silent = true })
end

vwm.setup()
