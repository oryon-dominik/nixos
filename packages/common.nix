{ config, pkgs, ... }: {
# --- Packages --------------------------------------------------------------

  # Search for packages installed in system profile:  # $ nix search <pkgname>
  environment.systemPackages = with pkgs; [
    gitMinimal
    man
    # if config.services.xserver.enable then
    #       [ firefox
    #         thunderbird
    #       ]
    #     else
    #       [ ];

    # (pkgs.emacs.override { gtk = pkgs.gtk3; }) ];  # override emacs gtk2 with gtk3
    # or as a function:
    # (pkgs.emacs.overrideAttrs (oldAttrs: {
    #     name = "emacs-25.0-pre";
    #     src = /path/to/my/emacs/tree;
    #   }))

  ];
}
