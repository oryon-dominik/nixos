{ pkgs, ... }: {
  # Define a user account.
  users.users.oryon = {
    name = "oryon";
    description = "Oryon is one of the most conspicuous and recognizable constellations in the night sky. Or why (you're) (not?) on?";
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "networkmanager"];  # "surface-control"
    shell = pkgs.fish;
    uid = 1337;
    home = "/home/oryon";
    
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEs5sLtXnlkQL4Ue+I0H8quSvPOmILzm5qOr3Z8R1cwmvy0xUJgCsM9pfGebvL5BIlLvTDBP+f3XKY4xoufDRxQ= oryon@cyberise.de"
    ];
    
  };
  users.groups.cyberise.gid = 1337;  # a group named cyberise shall exist.
  # users.mutableUsers = false;

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      zoxide init fish | source
      mcfly init fish | source
      starship init fish | source
    '';
  }

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    # Configuration written to ~/.config/starship.toml
    settings = {
      # add_newline = false;

      # character = {
      #   success_symbol = "[➜](bold green)";
      #   error_symbol = "[➜](bold red)";
      # };

      # package.disabled = true;
    };
  };


  # home-manager.users.oryon = { pkgs, ... }: {
  # home.packages = [ pkgs.duf pkgs.httpie ];  # packages to install in the home directory of the user.
  # programs.bash.enable = true;
}
