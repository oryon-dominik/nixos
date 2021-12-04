#!/usr/bin/env fish

echo "Installing static dotfiles into the users config..."
mkdir -p ~/.config

# fish
mkdir -p ~/.config/fish/functions
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/fish/config.fish --output ~/.config/fish/config.fish
xh --download https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/fish/aliases.fish --output ~/.config/fish/aliases.fish
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

# Python
# fallback:
# nix-env -iA nixos.python310
# nix-env -iA nixos.python310Packages.pip
# nix-env -iA nixos.python310Packages.argcomplete

# git clone https://github.com/pyenv/pyenv.git ~/.pyenv
# pyenv install 3.10.0
# pyenv global 3.10.0
# pyenv rehash
# python -m pip install --user pipx
# python -m pipx ensurepath
# python -m pipx completions
# python -m pipx install virtualfish
# vf install compat_aliases

# curl -sSL https://install.python-poetry.org | python3 -

# fish extensions
# curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
# fisher install jethrokuan/fzf  # fuzzy finder :)
# fisher install dracula/fish  # dracula colors
# fisher install daenney/pyenv  # pyenv support for fish
# fisher install edc/bass  # bash wrapper for fish, -> $ bass <bash commmand>
