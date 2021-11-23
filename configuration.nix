# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

# all configuration options are described in the doc's appendix https://nixos.org/manual/nixos/stable/options.html


{ config, pkgs, ... }: {

  imports = [
    # device specific hardware configuration (change this to your device)
    ./machines/surface

    # TODO: services ./services.nix
    # TODO: vpn ./vpn.nix
    # TODO: gnome ./gnome.nix
    # TODO: common_packages ./common-packages.nix

    ./networking.nix

    # Users - Don't forget to set a password with 'passwd'.
    ./users/oryon.nix
  ];

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    earlySetup = true;
    font = "${pkgs.terminus_font}/share/consolefonts/ter-132n.psf.gz";
    packages = with pkgs; [ terminus_font ];
    keyMap = "de";
  };

  # ================ SERVICES =========================================================================================

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;  # it's hardly recommended to use this with gnome
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  # services.xserver.windowManager.i3.enable = true;
  # Configure keymap in X11
  services.xserver.layout = "de";
  # services.xserver.xkbVariant = "neo";
  services.xserver.xkbOptions = "eurosign:e";
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;


  # services.gnome.core-utilities.enable = false;  # disable all the gnome-apps
  # If you’d only like to omit a subset of the core utilities, you can use
  # environment.gnome.excludePackages. Note that this mechanism can only
  # exclude core utilities, games and core developer tools.

  # It is also possible to disable many of the core services. For example, if you do not need indexing files, you can disable Tracker with:
  # services.gnome.tracker-miners.enable = false;
  # services.gnome.tracker.enable = false;

  # services.gnome.core-developer-tools.enable = true;

  # If you want to use GNOME Wayland session on Nvidia hardware, you need to enable:
  # services.xserver.displayManager.gdm.nvidiaWayland = true;

  # Icon themes and GTK themes don’t require any special option to install in
  # NixOS. You can add them to environment.systemPackages and switch to them
  # with GNOME Tweaks. If you’d like to do this manually in dconf, change the
  # values of the following keys:
  #   /org/gnome/desktop/interface/gtk-theme
  #   /org/gnome/desktop/interface/icon-theme
  # in dconf-editor

  # 17.5. Shell Extensions
  # Most Shell extensions are packaged under the gnomeExtensions attribute.
  # Some packages that include Shell extensions, like gnome.gpaste, don’t have
  # their extension decoupled under this attribute.
  # You can install them like any other package:
  # environment.systemPackages = [
  #   gnomeExtensions.dash-to-dock
  #   gnomeExtensions.gsconnect
  #   gnomeExtensions.mpris-indicator-button
  # ];
  # Unfortunately, we lack a way for these to be managed in a completely
  # declarative way. So you have to enable them manually with an Extensions
  # application. It is possible to use a GSettings override for this on
  # org.gnome.shell.enabled-extensions, but that will only influence the
  # default value.

  # 17.6. GSettings Overrides
  # Majority of software building on the GNOME platform use GLib’s GSettings
  # system to manage runtime configuration. For our purposes, the system
  # consists of XML schemas describing the individual configuration options,
  # stored in the package, and a settings backend, where the values of the
  # settings are stored. On NixOS, like on most Linux distributions, dconf
  # database is used as the backend. GSettings vendor overrides can be used to
  # adjust the default values for settings of the GNOME desktop and apps by
  # replacing the default values specified in the XML schemas. Using overrides
  # will allow you to pre-seed user settings before you even start the session.
  # Warning: Overrides really only change the default values for GSettings keys
  # so if you or an application changes the setting value, the value set by the
  # override will be ignored. Until NixOS’s dconf module implements changing
  # values, you will either need to keep that in mind and clear the setting
  # from the backend using dconf reset command when that happens, or use the
  # module from home-manager. You can override the default GSettings values
  # using the services.xserver.desktopManager.gnome.extraGSettingsOverrides
  # option. Take note that whatever packages you want to override GSettings
  # for, you need to add them to
  # services.xserver.desktopManager.gnome.extraGSettingsOverridePackages.
  # You can use dconf-editor tool to explore which GSettings you can set.
  # 17.6.1. Example
  # services.xserver.desktopManager.gnome = {
  #   extraGSettingsOverrides = ''
  #     # Change default background
  #     [org.gnome.desktop.background]
  #     picture-uri='file://${pkgs.nixos-artwork.wallpapers.mosaic-blue.gnomeFilePath}'

  #     # Favorite apps in gnome-shell
  #     [org.gnome.shell]
  #     favorite-apps=['org.gnome.Photos.desktop', 'org.gnome.Nautilus.desktop']
  #   '';

  #   extraGSettingsOverridePackages = [
  #     pkgs.gsettings-desktop-schemas # for org.gnome.desktop
  #     pkgs.gnome.gnome-shell # for org.gnome.shell
  #   ];
  # };

  # postgreSQL
  # services.postgresql.enable = true;
  # services.postgresql.package = pkgs.postgresql_11;
  # By default, PostgreSQL stores its databases in
  # /var/lib/postgresql/$psqlSchema. You can override this using
  # services.postgresql.dataDir, e.g.
  # services.postgresql.dataDir = "/data/postgresql";




  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "alice";
  # services.xserver.autorun = false;  # -> systemctl start display-manager.service

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  services.sshd.enable = true;
  services.sshd.passwordAuthentication = true;
  services.sshd.permitRootLogin = "without-password";

  # enable the Apache HTTP Server with /webroot as the document root:
  # services.httpd.enable = true;
  # services.httpd.adminAddr = "alice@example.org";
  # services.httpd.virtualHosts.localhost.documentRoot = "/webroot";
  # services = {
  #     httpd = {
  #       enable = true;
  #       adminAddr = "alice@example.org";
  #       virtualHosts = {
  #         localhost = {
  #           documentRoot = "/webroot";
  #         };
  #       };
  #     };
  #   };
  # let
  #   commonConfig =
  #     { adminAddr = "alice@example.org";
  #       forceSSL = true;
  #       enableACME = true;
  #     };
  # in
  # {
  #   services.httpd.virtualHosts =
  #     { "blog.example.org" = (commonConfig // { documentRoot = "/webroot/blog.example.org"; });
  #       "wiki.example.org" = (commonConfig // { documentRoot = "/webroot/wiki.example.com"; });
  #     };
  # }



  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  # hardware.pulseaudio.enable = true;


  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #   wget
    gitMinimal  #firefox

    # if config.services.xserver.enable then
    #       [ pkgs.firefox
    #         pkgs.thunderbird
    #       ]
    #     else
    #       [ ];


  ];
  # environment.systemPackages = [ (pkgs.emacs.override { gtk = pkgs.gtk3; }) ];  # override emacs gtk2 with gtk3
  # or as a function
  # environment.systemPackages = [
  #   (pkgs.emacs.overrideAttrs (oldAttrs: {
  #     name = "emacs-25.0-pre";
  #     src = /path/to/my/emacs/tree;
  #   }))
  # ];


  # services.postgresql.package = pkgs.postgresql_10;

  environment.sessionVariables = rec {
    CONFIG_SERIAL_DEV_BUS = "y";
    CONFIG_SERIAL_DEV_CTRL_TTYPORT = "y";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Display manager SWAY
  # programs.sway.enable = true;


  # nixos-containers
  # there shall be a container named database running PostgreSQL
  # containers.database =
  #   { config =
  #       { config, pkgs, ... }:
  #       { services.postgresql.enable = true;
  #       services.postgresql.package = pkgs.postgresql_9_6;
  #       };
  #   };
  # containers.database.autoStart = true
  # containers.database = {
  #   privateNetwork = true;
  #   hostAddress = "192.168.100.10";
  #   localAddress = "192.168.100.11";
  # };
  # for external networking see: https://nixos.org/manual/nixos/stable/index.html#sec-container-networking

  # If you are using Network Manager, you need to explicitly prevent it from managing container interfaces:
  # networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];

  # Enable auto-upgrades.
  # system.autoUpgrade.enable = true;
  # system.autoUpgrade.allowReboot = true;
  # system.autoUpgrade.channel = https://nixos.org/channels/nixos-21.11;

  # auto-garbage-collection
  # nix.gc.automatic = true;
  # nix.gc.dates = "03:15";


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}
