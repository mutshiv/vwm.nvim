local M = {}

Win = function(buf, opts)
    vim.api.nvim_open_win(buf, 0, opts)
end

local buf = vim.api.nvim_create_buf(false, true)

M.buildUI = function()
    local height = 20
    local width = 100

    local opts = {
        relative = 'editor',
        border = 'rounded',
        title = 'Calc',
        row = math.floor((vim.o.columns - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        width = width,
        height = height,
    }

    Win(buf, opts)
    Color_text()
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "Hear hear..." })

    vim.ui.input({ prompt = 'Enter your text here...' }, function(input)
        Draw_input(input)
    end)
end

Draw_input = function(input_text)
    print("Draw input function called...")
    if input_text then
        vim.api.nvim_buf_set_lines(buf, -1, -1, false, { input_text })
        local line_number = vim.api.nvim_buf_line_count(buf) - 1
        vim.api.nvim_buf_add_highlight(buf, -1, 'colouring', line_number, 0, -1)
    else
        print("No text provided")
    end
end

Color_text = function()
    print("colouring function called...")
    vim.api.nvim_set_hl(0, 'colouring', { fg = '#fff000', bg = '#fff660', bold = true })
end

return M
