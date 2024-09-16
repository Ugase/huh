if status is-interactive
end
set fish_greeting

set hydro_multiline true
set hydro_color_pwd 7aa2f7
set hydro_color_duration ff9e64
set hydro_cmd_duration_threshold 0

alias ls="eza -SlhA"
alias edit_fish="nvim ~/.config/fish/config.fish"
export PATH="~/.local/bin:~/.pbin:$PATH"
fastfetch
