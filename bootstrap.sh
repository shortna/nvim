#!/bin/sh

TMUX_CONFIG=$(cat <<EOF
set -g default-terminal "screen-256color"
set-option -sa terminal-overrides ",xterm-kitty:RGB"
set -g history-limit 65536
set -g prefix C-j
set -g mouse on
set -g mode-keys vi
set -g base-index 1
set -g renumber-windows on
set -g set-clipboard external
set -g status "on"
set -g status-keys vi
set -g status-style bg=colour5,fg=colour7
set -g message-style bg=colour5,fg=colour7
set -g message-command-style bg=colour5,fg=colour7
set-window-option -g mode-style bg=colour5,fg=colour7
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'y' send -X copy-selection
bind-key -T copy-mode-vi 'Escape' send -X clear-selection
set -sg escape-time 10
set -g focus-events on
EOF
)

FISH_CONFIG=$(cat <<EOF 
# Disable greeting
set fish_greeting
# Show full directory names in prompt
set -U fish_prompt_pwd_dir_length 0
# Set informative VCS prompt (this may require fish_config being available interactively)
# If you're running in a non-interactive shell, this might not work
# You might want to set the prompt manually instead
fish_config prompt choose informative_vcs
# Use vi key bindings
fish_vi_key_bindings
set -U fish_color_command green
set -U fish_color_error red
set -U fish_color_param normal
set -U fish_color_quote yellow
# Aliases
alias la="ls -lAh --group-directories-first --color=auto"
alias ls="ls --group-directories-first --color=auto"
alias cdp="cd -"
alias scd="fzf-cd-widget"
alias cl="clear -x"
alias so="source"
alias cdb="cd .."
alias vim="nvim"
alias battery='echo (cat /sys/class/power_supply/BAT1/capacity)%'
set -Ux EDITOR nvim
EOF)

function install_progs() {
PROGS=(
    "git"
    "curl"
    "wget"
    "ninja-build"
    "gettext" 
    "cmake" 
    "build-essential"
    "python3-pip"
    "fish"
    "ripgrep"
    "fzf"
    "tmux"
    "kitty"
)

sudo apt update
for prog in "${PROGS[@]}"; do
    echo "Installing $prog..."
    sudo apt install -y "$prog"
done
}

function install_nvim() {
	NVIM_REPO="https://github.com/neovim/neovim/tree/v0.11.2"
	git clone "$NVIM_REPO"
	cd "$NVIM_REPO"
	make CMAKE_BUILD_TYPE=Release
	sudo make install
	cd ..
	# install plug
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

	# install config
	NVIM_CONFIG="nvim_config"
	git clone "https://github.com/shortna/nvim" "$NVIM_CONFIG"
	mkdir -p "~/.config"
	cp -r "$NVIM_CONFIG" "~/.config/nvim"
	# install plugins and exit
	nvim -c "PlugInstall | qall!" +q
}

install_progs()
install_nvim()

echo "$TMUX_CONFIG" > .tmux.conf
mkdir -p ~/.config/fish
echo "$FISH_CONFIG" >  ~/.config/fish/config.fish
mkdir -p ~/.config/kitty
echo "confirm_os_window_close 0
enable_audio_bell no
mouse_hide_wait 2
copy_on_select no" >  ~/.config/kitty/kitty.conf
