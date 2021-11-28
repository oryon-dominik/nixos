{ config, pkgs, ... }: {

  # === HOSTS =================================================================
  networking.hostName = "serenity";
  # networking.extraHosts =
  # ''
  #   127.0.0.2 other-localhost
  #   10.0.0.1 server
  # '';

  # === WIFI ==================================================================
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  # If you are using WPA2 -> generate a pskRaw key using wpa_passphrase
  # $ wpa_passphrase {SSID} {PASS}
  # networking.wireless.networks = {
  #   ssid = {  # replace with your SSID & PASS
  #     psk = "secret";
  #   };
  #   free.wifi = {};            # Public wireless network
  # };

  # surface fixes for off-powering wifi?!
  # networking.networkmanager.connection.wifi.powersave = 2;
  # networking.networkmanager.device.wifi.scan-rand-mac-address = false;


  # === FIREWALL ==============================================================
  # networking.firewall.enable = true;
  # networking.firewall.allowPing = false;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];

  # === DHCP ==================================================================
  # Dynamic Host Configuration Protocol
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP is mandatory, so this replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.wlp1s0.useDHCP = true;

  # === PROXY =================================================================
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

}
