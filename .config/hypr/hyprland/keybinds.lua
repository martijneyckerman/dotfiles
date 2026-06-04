-- Variables
local ipc       = "qs -c noctalia-shell ipc call"
local term      = "ghostty"
local monitor   = "hyprmon"
local launcher  = "vicinae toggle"

-- Core window / session
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + Delete", hl.dsp.exit())
hl.bind("SUPER + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("SUPER + Return", hl.dsp.exec_cmd(term))
hl.bind("SUPER + Space", hl.dsp.exec_cmd(launcher))
hl.bind("SUPER + A", hl.dsp.window.float({ action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))
hl.bind("SUPER + P", hl.dsp.window.pseudo())
hl.bind("SUPER + Y", hl.dsp.window.pin())
hl.bind("SUPER + SHIFT + P", hl.dsp.exec_cmd(term .. " --title=hyprmon -e " .. monitor))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region"))

-- Focus (vim hjkl)
hl.bind("SUPER + H", hl.dsp.focus({ direction = "l" }))
hl.bind("SUPER + L", hl.dsp.focus({ direction = "r" }))
hl.bind("SUPER + K", hl.dsp.focus({ direction = "u" }))
hl.bind("SUPER + J", hl.dsp.focus({ direction = "d" }))

-- Move window (vim hjkl)
hl.bind("SUPER + SHIFT + H", hl.dsp.window.move({ direction = "l" }))
hl.bind("SUPER + SHIFT + L", hl.dsp.window.move({ direction = "r" }))
hl.bind("SUPER + SHIFT + K", hl.dsp.window.move({ direction = "u" }))
hl.bind("SUPER + SHIFT + J", hl.dsp.window.move({ direction = "d" }))

-- Mouse drag / resize
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind("SUPER + SHIFT + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind("SUPER + SHIFT + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Workspaces (1-9, 0 -> ws 10)
for i = 1, 10 do
    local key = i % 10
    hl.bind("SUPER + " .. key, hl.dsp.focus({ workspace = i }))
    hl.bind("SUPER + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))               -- follows
    hl.bind("SUPER + ALT + " .. key, hl.dsp.window.move({ workspace = i, follow = false })) -- silent
end

-- Special / scratchpad
hl.bind("SUPER + S", hl.dsp.workspace.toggle_special("special"))
hl.bind("SUPER + ALT + S", hl.dsp.window.move({ workspace = "special:special", follow = false }))

-- Noctalia IPC
hl.bind("SUPER + C", hl.dsp.exec_cmd(ipc .. " controlCenter toggle"))
hl.bind("SUPER + Comma", hl.dsp.exec_cmd(ipc .. " settings toggle"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(ipc .. " launcher clipboard"))
hl.bind("SUPER + CTRL + Q", hl.dsp.exec_cmd(ipc .. " sessionMenu lock"))
hl.bind("SUPER + Backspace", hl.dsp.exec_cmd(ipc .. " sessionMenu toggle"))

-- Media / brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(ipc .. " volume increase"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(ipc .. " volume decrease"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(ipc .. " volume muteOutput"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(ipc .. " brightness increase"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(ipc .. " brightness decrease"), { locked = true, repeating = true })
