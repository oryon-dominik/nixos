{ config, pkgs, ... }: {
  # Define a user account.
  users.users.oryon = {
    name = "oryon";
    description = "Oryon is one of the most conspicuous and recognizable constellations in the night sky. Or why (you're) (not?) on?";
    isNormalUser = true;
    
    createHome = true;  # are these compatible with the home-manager?
    home = "/home/oryon";
    
    extraGroups = [ "wheel" "docker" "networkmanager" "surface-control" ];
    shell = pkgs.fish;
    uid = 1337;

    # Specifies the hashed password for the user. hashedPassword overrides both password and passwordFile.
    # users.mutableUsers is false, you cannot change user passwords, they will
    # always be set according to the password options. To generate hashedPassword install 'mkpasswd' package and run 'mkpasswd -m sha-512'.
    hashedPassword = "$6$enbwiWgjUKpqv/HL$NRTNyKAMW.7GrfjF1nO5IfSAElJIrqLSGCDy5TzhnBMYbT9Jq9hsOJEOKZNk9sn4i/W2UH/7E/iIB/nKTMMdj.";

    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEs5sLtXnlkQL4Ue+I0H8quSvPOmILzm5qOr3Z8R1cwmvy0xUJgCsM9pfGebvL5BIlLvTDBP+f3XKY4xoufDRxQ= oryon@cyberise.de"
    ];
    
  };

  # TODO: implement & configure home-manager
  # home-manager.users.oryon = # ????  # --- import ./oryon.nix {};
  
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  # home.username = "oryon";
  # home.homeDirectory = "/home/oryon";

  # Packages that should be installed to the user profile.
  # home.packages = [

  # ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  # home.stateVersion = "21.11";

  # # Let Home Manager install and manage itself.
  # programs.home-manager.enable = true;

  # programs.emacs = {
  #   enable = true;
  #   extraPackages = epkgs: [
  #     epkgs.nix-mode
  #     epkgs.magit
  #   ];
  # };

  # programs.fish.enable = true;

  # programs.starship = {
  #   enable = true;
  #   enableFishIntegration = true;
  #   # Configuration written to ~/.config/starship.toml
  #   settings = {
  #     # add_newline = false;

  #     # character = {
  #     #   success_symbol = "[➜](bold green)";
  #     #   error_symbol = "[➜](bold red)";
  #     # };

  #     # package.disabled = true;
  #   };
  # };

  # programs.git = {
  #     enable = true;
  #     userName = "oryon-dominik";
  #     userEmail = "oryon@cyberise.de";
  #     extraConfig = {
  #     credential.helper = "${
  #         pkgs.git.override { withLibsecret = true; }
  #       }/bin/git-credential-libsecret";
  #   };
  # };

  # services.gpg-agent = {
  #   enable = true;
  #   defaultCacheTtl = 1800;
  #   enableSshSupport = true;
  # };


  # git clone https://github.com/repsac-by/gnome-shell-extension-quake-mode.git
  # cd gnome-shell-extension-quake-mode
  # gnome-extensions pack quake-mode@repsac-by.github.com --extra-source={quakemodeapp,util}.js
  # gnome-extensions install quake-mode@repsac-by.github.com.shell-extension.zip

}
