return {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
        local lualine_theme = require('lualine.themes.tokyonight-night')
        lualine_theme.normal.c.bg = 'None'
        opts.options.component_separators = ''
        opts.options.section_separators = ''
        opts.options.theme = lualine_theme
        return opts
    end,
}
