return {
    setup = function()
        -- `pcall` is used to suppress errors, which is fine because it only
        -- means the augroup doesn't exist anyway.
        pcall(vim.api.nvim_del_augroup_by_name, 'nvim.progress')
    end,
}
