if status is-interactive
end
set fish_greeting
function fish_prompt
    powerline $status
end
alias ls="eza -SlhA"
alias edit_fish="nvim ~/.config/fish/config.fish"
export PATH="~/.local/bin:~/.pbin:$PATH"
fastfetch
