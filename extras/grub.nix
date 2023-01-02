

# =============================================================================
# GRUB-THEME

# https://discourse.nixos.org/t/how-to-apply-the-breeze-grub-theme/4341

{ config, pkgs, ... }:

{
  boot.loader.grub = {
    extraConfig = "set theme=($drive2)${pkgs.breeze-grub}/grub/themes/breeze/theme.txt";
    # extraConfig = "set theme=${pkgs.plasma5.breeze-grub}/grub/themes/breeze/theme.txt";
    splashImage = null;
  };
}


# https://github.com/xypnox/dotfiles
