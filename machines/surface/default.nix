{ config, lib, pkgs, modulesPath, ... }:

{
  imports = [
    # Microsoft Surface package for nixos
    "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/microsoft/surface"
    # Include the results of the hardware scan.
    ../../hardware-configuration.nix
  ];

  boot {
    initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    # kernelModules = mkBefore [ "kvm-intel" ]; # will load before any other kernel modules..
    extraModulePackages = [ ];

    loader {  # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

  };

  fileSystems {
    "/" = {
      device = "/dev/disk/by-label/system";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
  };

  swapDevices =[
      { device = "/dev/disk/by-label/swap"; }
    ];

  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  # high-resolution display
  hardware.video.hidpi.enable = lib.mkDefault true;
}
