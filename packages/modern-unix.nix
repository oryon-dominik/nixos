{ config, pkgs, ... }: {
  # --- Modern Unix Packages --------------------------------------------------
  # inspired by: https://github.com/ibraheemdev/modern-unix

  # Search for packages installed in system profile:  # $ nix search <pkgname>
  environment.systemPackages = with pkgs; [
    duf  # Disk Usage/Free Utility - https://github.com/muesli/duf
    tldr  # Help pages for command-line tools - https://github.com/tldr-pages/tldr
    gping  # Ping, but with a graph - https://github.com/orf/gping
    procs  # Replacement for ps - https://github.com/dalance/procs
    dogdns  # command-line DNS client - https://github.com/ogham/dog
    # to be continued..
  ];
