{ config, pkgs, ... }:

let
    unstable = import (
        builtins.fetchTarball {
        url = "https://github.com/nixos/nixpkgs/archive/21.11-pre.tar.gz";
        sha256 = "E0F1C7064D20B23E799C43DF05B7FB99EADE72D28C988FE4ACD8A8B8D15B8AF1";
        }
    )
    { config = config.nixpkgs.config; };

in {
    imports = [ # Include the results of the hardware scan.
        "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/microsoft/surface"
        ./hardware-configuration.nix
    ];

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "serenity"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    environment.sessionVariables = rec {
        CONFIG_SERIAL_DEV_BUS = "y";
        CONFIG_SERIAL_DEV_CTRL_TTYPORT = "y";
    };

    # Set your time zone.
    time.timeZone = "Europe/Berlin";

    # The global useDHCP flag is deprecated, therefore explicitly set to false here.
    # Per-interface useDHCP will be mandatory in the future, so this generated config
    # replicates the default behaviour.
    networking.useDHCP = false;
    networking.interfaces.wlp1s0.useDHCP = true;

    # Configure network proxy if necessary
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Select internationalisation properties.
    i18n.defaultLocale = "de_DE.UTF-8";
    console = {
        earlySetup = true;
        font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
        packages = with pkgs; [ terminus_font ];
        keyMap = "de";
    };

    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the GNOME Desktop Environment.
    services.xserver.displayManager.gdm.enable = true;
    services.xserver.desktopManager.gnome.enable = true;

    # Configure keymap in X11
    services.xserver.layout = "de";
    services.xserver.xkbOptions = "eurosign:e";

    # Enable CUPS to print documents.
    # services.printing.enable = true;

    # Enable sound.
    # sound.enable = true;
    # hardware.pulseaudio.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    # services.xserver.libinput.enable = true;

    # Define a user account. Don't forget to set a password with ‘passwd’.
    # users.users.jane = {
    #   isNormalUser = true;
    #   extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    # };

    # List packages installed in system profile. To search, run:
    # $ nix search wget
    environment.systemPackages = with pkgs; [
        #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        #   wget
        #   firefox
        gitMinimal
        unstable.iptsd
    ];

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "21.11-pre"; # Did you read the comment?
}
