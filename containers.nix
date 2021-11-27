{
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
}
