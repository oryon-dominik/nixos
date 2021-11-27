{ config, pkgs, ... }: {

  # === X-SERVER ======================================================================================================
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Enable the GNOME Desktop Environment.
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.enable = true;  # it's hardly recommended to use GDM with gnome
  # Configure keymap in X11
  services.xserver.layout = "de";
  services.xserver.xkbOptions = "eurosign:e";

  # services.xserver.displayManager.autoLogin.enable = true;
  # services.xserver.displayManager.autoLogin.user = "oryon";
  # services.xserver.autorun = false;  # -> systemctl start display-manager.service

  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.displayManager.lightdm.enable = true;
  # services.xserver.windowManager.i3.enable = true;
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # === GNOME =========================================================================================================
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

  # Shell Extensions
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

  # GSettings Overrides
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
  # Example:
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

  # Sleepmodes..
  # systemd.targets.sleep.enable = false;
  # systemd.targets.suspend.enable = false;
  # systemd.targets.hibernate.enable = false;
  # systemd.targets.hybrid-sleep.enable = false;


  # === SSH ===========================================================================================================
  # https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/networking/ssh/sshd.nix
  services.sshd.enable = true;
  services.openssh.passwordAuthentication = false;
  services.openssh.permitRootLogin = "no";

  # === HTTPD =========================================================================================================
  # enable the Apache HTTP Server with /webroot as the document root:
  # services.httpd.enable = true;
  # services.httpd.adminAddr = "me@example.org";
  # services.httpd.virtualHosts.localhost.documentRoot = "/webroot";
  # let
  #   commonConfig =
  #     { adminAddr = "me@example.org";
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

  # === XRDP ==========================================================================================================
  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "startplasma-x11";
  networking.firewall.allowedTCPPorts = [ 3389 ];
  # Soon: services.xrdp.openFirewall = true;


}
