if status is-interactive
end
function fish_greeting
    fastfetch
end
export PAGER='less'
export BROWSER='firefox'
alias ls="eza -lhA --group-directories-first"
alias edit_fish="nano ~/.config/fish/config.fish"
set huh $HOME/huh_project/
export PATH="$HOME/.local/bin:~/.pbin:/home/denzel/.cargo/bin/:$PATH"
zoxide init --cmd cd fish | source
