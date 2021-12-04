#!/usr/bin/env fish

echo "Installing static dotfiles into the users config..."
mkdir -p ~/.config

# fish
mkdir -p ~/.config/fish/functions
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/fish/config.fish --output ~/.config/fish/config.fish
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/fish/functions/last_command_as_sudo.fish --output ~/.config/fish/functions/last_command_as_sudo.fish

# alacritty
mkdir -p ~/.config/alacritty
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/alacritty/alacritty.yml --output ~/.config/alacritty/alacritty.yml
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/alacritty/bindings.yml --output ~/.config/alacritty/bindings.yml
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/alacritty/dracula.yml --output ~/.config/alacritty/dracula.yml
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/alacritty/hints.yml --output ~/.config/alacritty/hints.yml

# git
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/git/.gitconfig --output ~/.config/.gitconfig

# starship
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/starship/starship.toml --output ~/.config/starship.toml
