#!/usr/bin/env bash
# ghq-session.sh — pick a ghq repo (or home) and jump into a tmux session

HOME_OPTION="~ [home]"

selected=$(
    (
        printf '%s\n' "$HOME_OPTION"
        ghq list
    ) |
        fzf \
            --prompt "session> " \
            --header "select repo | ESC = plain shell" \
            --height 50% \
            --reverse \
            --no-info
)

# ESC or empty — fall through to plain shell
if [[ -z "$selected" ]]; then
    exec zsh
fi

if [[ "$selected" == "$HOME_OPTION" ]]; then
    session_name="home"
    session_dir="$HOME"
else
    session_dir="$(ghq root)/$selected"
    # sanitize: replace / and . with -
    session_name=$(printf '%s' "$selected" | sed 's|[/.]|-|g')
fi

if ! tmux has-session -t "=$session_name" 2>/dev/null; then
    tmux new-session -d -s "$session_name" -c "$session_dir"
fi

if [[ -n "$TMUX" ]]; then
    exec tmux switch-client -t "=$session_name"
else
    exec tmux attach-session -t "=$session_name"
fi
