local M = {}

function M.setup()
    require('base16-colorscheme').setup {
        -- Background tones
        base00 = '#000000',             -- Default Background
        base01 = '#110d1a',   -- Lighter Background (status bars)
        base02 = '#1a1428', -- Selection Background
        base03 = '#644c94',             -- Comments, Invisibles
        -- Foreground tones
        base04 = '#b58fff',  -- Dark Foreground (status bars)
        base05 = '#e8d8ff',          -- Default Foreground
        base06 = '#e8d8ff',          -- Light Foreground
        base07 = '#e8d8ff',       -- Lightest Foreground
        -- Accent colors
        base08 = '#ff6f9b',               -- Variables, XML Tags, Errors
        base09 = '#d8b4ff',            -- Integers, Constants
        base0A = '#c79aff',           -- Classes, Search Background
        base0B = '#b58fff',             -- Strings, Diff Inserted
        base0C = '#bd80ff',  -- Regex, Escape Chars
        base0D = '#ab80ff',   -- Functions, Methods
        base0E = '#b880ff', -- Keywords, Storage
        base0F = '#bc0039',     -- Deprecated, Embedded Tags
    }
end

-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
    'sigusr1',
    vim.schedule_wrap(function()
        package.loaded['matugen'] = nil
        require('matugen').setup()
    end)
)

return M
