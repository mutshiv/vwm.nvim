local M = {}

local win = function(buf, opts)
    return vim.api.nvim_open_win(buf, true, opts)
end

local i_win
local main_buf
local i_buf

M.main_win = function()
    local height = 30
    local width = 100

    local opts = {
        relative = 'editor',
        border = 'rounded',
        title = 'Main Window',
        row = math.floor((vim.o.columns - height) / 2),
        col = math.floor((vim.o.lines - width) / 2),
        width = width,
        height = height,
    }

    main_buf = vim.api.nvim_create_buf(false, true)

    _ = win(main_buf, opts)
    --  vim.api.nvim_buf_set_lines(main_buf, -1, -1, false, { 'Main Window', 'Enter your Text here... ' })

    vim.api.nvim_buf_set_option(main_buf, 'modifiable', true)

    Color_text()
end

M.input_win = function()
    if i_win and vim.api.nvim_win_is_valid(i_win) then
        vim.api.nvim_set_current_win(i_win)
        vim.nvim_win_set_cursor(i_win, { 1, 0 })
        vim.cmd("startinsert")
    else

        local opts = {
            relative = 'editor',
            border = 'single',
            style = 'minimal',
            title = 'Input Window',
            row = math.floor((vim.o.columns - 50) / 2),
            col = math.floor((vim.o.lines - 1) / 2),
            width = 50,
            height = 1,
        }
        i_buf = vim.api.nvim_create_buf(false, true)

        i_win = vim.api.nvim_open_win(i_buf, false, opts)
        vim.api.nvim_buf_set_option(i_buf, 'modifiable', true)

        print("The inspect output for input_win" .. tostring(vim.inspect(i_win)))

        vim.nvim_win_set_cursor(i_win, { 1, 0 })
        vim.cmd("startinsert")
    end
end

M.send_to_main_win = function()
    local input_text = vim.api.nvim_buf_get_lines(i_buf, 0, 1, false)[1]

    if input_text and #input_text > 0 then
        vim.api.nvim_buf_set_option(main_buf, 'modifiable', true)
        vim.api.nvim_buf_set_lines(main_buf, -1, -1, false, { input_text })
        --vim.api.nvim_buf_add_highlight(main_buf, -1, 'colouring', input_text, 0, -1)
        vim.api.nvim_buf_set_option(main_buf, 'modifiable', false)

        vim.api.nvim_win_close(i_win, true)
    else
        print("No text provided...")
    end
end

Color_text = function()
    vim.api.nvim_set_hl(0, 'colouring', { fg = '#ffffff', bg = '#000000', bold = true })
end

return M
