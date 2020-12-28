# installation

installation from minimal nixos iso, on a windows-10 hyper-V :)

1. setup the keyboard

    sudo loadkeys de

2. booting should have installed ethernet

    ip a
    # connect to wifi with:
    wpa_supplicant -B -i interface -c <(wpa_passphrase 'SSID' 'key')

3. partition your disk on UEFI with `parted`

    parted /dev/sda -- mklabel gpt
    # root
    parted /dev/sda -- mkpart primary 1024MiB -16GiB
    # swap
    parted /dev/sda -- mkpart primary linux-swap -16GiB 100%
    # boot
    parted /dev/sda -- mkpart ESP fat32 1MiB 1024MiB
    parted /dev/sda -- set 3 esp on

4. format your disks

    mkfs.ext4 -L nixos /dev/sda1
    mkswap -L swap /dev/sda2
    mkfs.fat -F 32 -n boot /dev/sda3

5. mount the disks

    mount /dev/disk/by-label/nixos /mnt
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/boot /mnt/boot
    swapon /dev/sda2

6. edit or create your config

    nixos-generate-config --root /mnt
    nano /mnt/etc/nixos/configuration.nix

7. add the hyper-v config

    ## hyper V ##
    # REQUIRED - see: https://github.com/nixos/nixpkgs/issues/9899
    boot.initrd.kernelModules = ["hv_vmbus" "hv_storvsc"];
    # RECOMMENDED
    # - use 800x600 resolution for text console, to make it easy to fit on screen
    boot.kernelParams = ["video=hyperv_fb:800x600"];  # https://askubuntu.com/a/399960
    # - avoid a problem with `nix-env -i` running out of memory
    boot.kernel.sysctl."vm.overcommit_memory" = "1"; # https://github.com/NixOS/nix/issues/421

    # UNKNOWN - not sure if below are needed; were suggested for VirtualBox and I used them
    boot.loader.grub.device = "/dev/sda";
    boot.initrd.checkJournalingFS = false;

8. install

    nixos-install
    reboot
    # change root password
    passwd
    useradd -m oryon
    passwd oryon
    
    # what packages are available?
    nix-env -qaP \*
    # install sway
    nix-env -f '<nixpkgs>' -iA sway




