# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# all configuration options are described in the doc's appendix https://nixos.org/manual/nixos/stable/options.html


{ config, pkgs, ... }: {

  imports = [
    # Device specific hardware configuration (change this to your device)
    # ./machines/default
    ./machines/surface
    # ./machines/raspberry

    # Packages
    ./packages/common.nix
    ./packages/modern-unix.nix
    # ./databases/postgres.nix
    # ./databases/postgres-update.nix

    # Network
    ./network.nix

    # Services
    ./services.nix

    # Users - Don't forget to set a password with 'passwd'.
    ./users/oryon

    # TODO: vpn ./vpn.nix
    # TODO: gnome ./gnome.nix
    # TODO: containers ./containers.nix
  ];

  # Localization
  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";

  # Shell
  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "de";
  };

  # Core support for devices connected via a serial port / TTY port controller support.
  environment.sessionVariables = rec {
    CONFIG_SERIAL_DEV_BUS = "y";
    CONFIG_SERIAL_DEV_CTRL_TTYPORT = "y";
  };

  # Common aliases for all users..
  environment.interactiveShellInit = ''
    alias ..='cd ..'
    alias cd..='cd ..'
    alias cd..='cd ..'
    alias cls='clear'

    alias ls='exa --group-directories-first --git-ignore'
    alias ll='exa --color-scale --long --header --group-directories-first'
    alias la='exa --all --color-scale --long --header --group-directories-first'
    alias lt='exa --tree --color-scale --group-directories-first'
    alias l='exa --all --color-scale --long --header --git --group-directories-first'

    alias ports='netstat -tulpen'
  '';


  powerManagement.enable = true;

  fonts = {
    enableFontDir = true;
    fonts = [ pkgs.nerdfonts ];
  };

  # nixpkgs = {
  #   config = { allowUnfree = true; allowBroken = false; };
  # };

  # nix.maxJobs = 32;
  # nix.buildCores = 4;


  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Display manager SWAY
  # programs.sway.enable = true;


  # --- System ----------------------------------------------------------------
  # Enable auto-garbage-collection:
  # nix.gc.automatic = true;
  # nix.gc.dates = "03:15";  # every night at 3:15 am

  # Enable auto-upgrades:
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;

  system.autoUpgrade.channel = https://nixos.org/channels/nixos-unstable;
  # nix-channel --add https://nixos.org/channels/nixos-21.11 nixos
  # nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
  # nix-channel --update

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
 