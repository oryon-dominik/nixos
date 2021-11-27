{ config, pkgs, ... }: {
# Major PostgreSQL upgrade requires PostgreSQL downtime and a few imperative steps to be called. To simplify this process, use the following NixOS module:

  containers.temp-pg.config.services.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
    ## set a custom new dataDir
    # dataDir = "/some/data/dir";
  };
  environment.systemPackages =
    let newpg = config.containers.temp-pg.config.services.postgresql;
    in [
      (pkgs.writeScriptBin "upgrade-pg-cluster" ''
        set -x
        export OLDDATA="${config.services.postgresql.dataDir}"
        export NEWDATA="${newpg.dataDir}"
        export OLDBIN="${config.services.postgresql.package}/bin"
        export NEWBIN="${newpg.package}/bin"

        install -d -m 0700 -o postgres -g postgres "$NEWDATA"
        cd "$NEWDATA"
        sudo -u postgres $NEWBIN/initdb -D "$NEWDATA"

        systemctl stop postgresql    # old one

        sudo -u postgres $NEWBIN/pg_upgrade \
          --old-datadir "$OLDDATA" --new-datadir "$NEWDATA" \
          --old-bindir $OLDBIN --new-bindir $NEWBIN \
          "$@"
      '')
    ];

# The upgrade process is: Rebuild nixos configuration with the configuration
# above added to your configuration.nix. Alternatively, add that into separate
# file and reference it in imports list. Login as root (sudo su -) Run
# upgrade-pg-cluster. It will stop old postgresql, initialize new one and
# migrate old one to new one. You may supply arguments like --jobs 4 and --link
# to speedup migration process. See
# https://www.postgresql.org/docs/current/pgupgrade.html for details. Change
# postgresql package in NixOS configuration to the one you were upgrading to,
# and change dataDir to the one you have migrated to. Rebuild NixOS. This
# should start new postgres using upgraded data directory. After upgrade you
# may want to ANALYZE new db.
}