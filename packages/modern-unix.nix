{ config, pkgs, ... }: {
  # --- Modern Unix Packages --------------------------------------------------
  # inspired by: https://github.com/ibraheemdev/modern-unix

  dogWithPriority = pkgs.dogdns.override {meta.priority = "1";};

  # Search for packages installed in system profile:  # $ nix search <pkgname>
  environment.systemPackages = with pkgs; [

    starship  # shell prompt - https://starship.rs/
    # ! exa has been aliased to ls
    exa  # modern ls - https://github.com/ogham/exa
    bat  # cat clone with syntax highlighting - https://github.com/sharkdp/bat
    delta  # highlighting for diff - https://github.com/dandavison/delta

    mcfly  # fly through your shell history - https://github.com/cantino/mcfly
    fzf  # command-line fuzzy finder - https://github.com/junegunn/fzf
    zoxide  # smarter cd command - https://github.com/ajeetdsouza/zoxide

    procs  # Replacement for ps - https://github.com/dalance/procs
    bottom  # (btm) graphical system/process monitor - https://github.com/ClementTsang/bottom
    gtop  # System monitoring dashboard for terminal - https://github.com/aksakalli/gtop

    broot  # grahpical directory trees - https://github.com/Canop/broot
    du-dust  # instant overview of which directories are using disk - https://github.com/bootandy/dust
    duf  # Disk Usage/Free Utility - https://github.com/muesli/duf

    silver-searcher  # (ag) "the silver searcher" code searching tool - https://github.com/ggreer/the_silver_searcher
    ripgrep  # (rg) grep on steroids - https://github.com/BurntSushi/ripgrep
    fd  # find entries in your filesystem - https://github.com/sharkdp/fd

    hyperfine  # CLI benchmarks - https://github.com/sharkdp/hyperfine
    sd  # find & replace - https://github.com/chmln/sd
    jq  # JSON processor - https://github.com/stedolan/jq
    choose  # field selection from content - https://github.com/theryangeary/choose
    grex  # build regexes from CLI-tests https://github.com/pemistahl/grex
    tokei  # statistics about your code - https://github.com/XAMPPRocky/tokei

    # gping  # Ping, but with a graph - https://github.com/orf/gping  # FIXME: broken on nixos for now
    xh  # send HTTP requests - https://github.com/ducaale/xh
    curlie  # curl wrapper - https://github.com/rs/curlie
    bandwhich  # current network utilization - https://github.com/imsnif/bandwhich

    tealdeer  # (tldr) Help pages for command-line tools, rust implementation of tldr - https://github.com/dbrgn/tealdeer
    cheat  # CLI cheatsheet - https://github.com/cheat/cheat

    # to be continued..
  ]
  ++ [
    # other packages
    dogWithPriority  # command-line DNS client - https://github.com/ogham/dog
  ];
}
