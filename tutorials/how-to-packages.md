# Packages on nixos

> "The main command for package management is nix-env. You can use it to install,
> upgrade, and erase packages, and to query what packages are installed or are
> available for installation."

## Install, Uninstall, Upgrade.

    # By default nixos uses a source deployment model (build everything including the compiler from scratch..), so this takes longer than you might expect.
    # nixOS can automatically skip building from source and instead use a binary cache as well (we'll come to this later).

    # by default nixos installs packages from a binary-cache: = https://cache.nixos.org/

    # Nixos uses a sqlite for information on the packages.
    ls -l --all --human-readable /nix/var/nix/db

    nix-env [-i] --install firefox
    nix-env [-e] --uninstall firefox

    nix-env -u [--upgrade] some-packages

    nix-env -f ~/foo.nix -i '.*'  # To install all derivations in the Nix expression foo.nix

    nix-env -qaP \*  # what packages are available?
    nix-env -qaP '*' --description  # list some packages

    nix-env -f '<nixpkgs>' -iA sway  # install sway
    ```

## Generations & Rollbacks.

    nix-env --list-generations
    nix-env --rollback  # <- previous generation
    nix-env --switch-generation <no>

Remove old packages:

    # delete all old generations of your profile
    nix-env --delete-generations old  # all old
    nix-env --delete-generations <no1> <no2> <no3> <..>  # certain generations
    nix-env --delete-generations 14d  # all older 14 days

    # garbage collect the nix store
    nix-store --gc

    # The behaviour of the garbage collector is affected by the keep-derivations
    # (default: true) and keep-outputs (default: false) options in the Nix
    # configuration file. 
    # While you are developing it may make sense to keep outputs to ensure that
    # rebuild times are quick.

    # Delete all store paths unused by current generations of each profile:
    nix-collect-garbage [--delete-old] [-d] [--dry-run] [--delete-older-than 30d]


## Profiles

> allow different users to have different configurations, and to do atomic upgrades and rollbacks

    nix-env --switch-profile /nix/var/nix/profiles/default
    nix-env --switch-profile /nix/var/nix/profiles/<whatevernameyouwant>
    # ensure ~/.nix-profile/bin is on path (that's what /nix/etc/profile.d/nix.sh does)

## [Channels](https://channels.nixos.org/)

    nix-channel --add https://channels.nixos.org/nixos-21.05
    # or: https://channels.nixos.org/nixos-unstable
    nix-channel --add https://channels.nixos.org/nixpkgs-21.05-darwin
    
    # update the channels..
    nix-channel --update
    
    # then upgrade packages
    nix-env -u

## nix shell

Run a shell in which the specified packages are available

    nix shell nixpkgs#youtube-dl

(https://nixos.org/manual/nix/unstable/command-ref/new-cli/nix3-shell.html)


## other stuff

get the store location of a binary

    readlink -f (which dog)

