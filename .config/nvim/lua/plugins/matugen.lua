return {
    'RRethy/base16-nvim',
    lazy = false,  -- load immediately, not lazily
    priority = 1000, -- load before other plugins (same as colorscheme plugins)
    config = function()
        require('matugen').setup()
    end,
}
