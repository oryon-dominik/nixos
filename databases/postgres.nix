{ config, pkgs, ... }: {
  
  # postgreSQL
  # https://nixos.org/manual/nixos/stable/index.html#module-postgresql
  # $ systemctl status postgresql.service 
  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql_14;
  # By default, PostgreSQL stores its databases in /var/lib/postgresql/$psqlSchema. Override:
  # services.postgresql.dataDir = "/data/postgresql";

  services.postgresql.extraPlugins = with pkgs.postgresql_14.pkgs; [
    # pg_repack
    # postgis
  ];
}
