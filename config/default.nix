{ ... }: {
  environment.etc = {
    "per-user/.config/alacritty/alacritty.yml".text = pkgs.fetchurl {
      url = https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/alacritty/alacritty.yml;
    };

     "per-user/.config/starship/starship.toml".text = pkgs.fetchurl {
      url = https://raw.githubusercontent.com/oryon-dominik/dotfiles/master/common/starship/starship.toml;
    };

    # "per-user/.config/git/.gitconfig".text = import ./dotfiles/gitconfig.nix {};
    # "per-user/.config/fish/fish.config".text = import ./dotfiles/fish.nix {};

  };
  system.activationScripts.extraUserActivation.text = ''

    ln -sfn /etc/per-user/.config/git/ ~/

    mkdir -p ~/.config/alacritty/
    ln -sfn /etc/per-user/.config/alacritty ~/.config/alacritty

    mkdir -p ~/.config/fish/
    ln -sfn /etc/per-user/.config/fish/ ~/.config/fish/
    ln -sfn /etc/per-user/.config/starship/ ~/.config/

  '';
}
