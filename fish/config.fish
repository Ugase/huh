if status is-interactive
end
function fish_greeting
    fastfetch
end
export PAGER='most'
export BROWSER='zen-browser'
alias ls="eza -lhA"
alias edit_fish="nvim ~/.config/fish/config.fish"
set huh $HOME/huh_project/
set -U pure_enable_single_line_prompt true
export PATH="~/.local/bin:~/.pbin:/home/denzel/.cargo/bin/:$PATH"

