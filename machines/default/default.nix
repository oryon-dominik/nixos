{ config, lib, ... }:

{
  imports = [
    # Always include the results of the hardware scan.
    ../../hardware-configuration.nix
  ];

  boot = {
    loader = {  # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };
}
