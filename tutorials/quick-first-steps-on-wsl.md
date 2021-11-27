# How-To nix - on WSL

NixOS on a Windows Machine and WSL2.  
Follow this [tutorial](https://github.com/Trundle/NixOS-WSL) and download the latest version and setup wsl to use it.  

Summarized:

    wsl --import NixOS <path_to_install>\NixOS\ <Downloads>\nixos-system-x86_64-linux.tar.gz --version 2
    wsl -d NixOS
    /nix/var/nix/profiles/system/activate
    <restart wsl>

Show your versions.

    cat /etc/os-release
    nix -vv --version
    nix-env --version

Starting with lessons from the [official manual](https://nixos.org/manual/nix/stable/) using [nix-env](https://www.mankier.com/1/nix-env).  
Quicklessons.

    # install and test
    nix-env -i hello
    which hello
    hello

    # uninstall
    nix-env -e hello

    # run a shell without install
    nix-shell -p hello
    exit

    # update all existing packages to new versions
    nix-channel --update nixpkgs
    nix-env -u '*'

    # if you don't like, rollback
    nix-env --rollback

    # ocasssionally collect your garbage...
    nix-collect-garbage -d

    # update the whole system
    nix-channel --update; nix-env -iA nixpkgs.nix nixpkgs.cacert; systemctl daemon-reload; systemctl restart nix-daemon
