
# nixos on hyper-V

If you're using a hyper-V VM, create a more performant virtual disk with

```powershell
New-VHD -Path D:\systems\hyperV\nixos.vhdx -SizeBytes 100GB -Dynamic -BlockSizeBytes 1MB
```

Read the [best-practices for linux on hyper-v](https://docs.microsoft.com/de-de/windows-server/virtualization/hyper-v/best-practices-for-running-linux-on-hyper-v)  
As well as the [nix-os hyper-v tutorial](https://github.com/NixOS/nixos-hardware/tree/master/microsoft/hyper-v)  

Setup the ssh-deamon to manipulate the config files via ssh later on

    sudo systemctl start sshd

We don't want to type sudo before every command, so..

    sudo su

Carefully follow the [installation steps](https://nixos.org/nixos/manual/index.html#sec-installation).  
Install the [partitioning with UEFI](https://nixos.org/nixos/manual/index.html#sec-installation-partitioning-UEFI).  
Now [format the disks](https://nixos.org/nixos/manual/index.html#sec-installation-partitioning-formatting) 
(for the hyper-v variant add the option `-G 4096` : `mkfs.ext4 -L nixos /dev/sda1 -G 4096`)  

Follow the [installation tutorial](https://nixos.org/nixos/manual/index.html#sec-installation-installing) till step 5 to complete installation and disk setup.  

Example:

```bash
# partitions
parted /dev/sda -- mklabel gpt
parted /dev/sda -- mkpart primary 1024MiB -16GiB
parted /dev/sda -- mkpart primary linux-swap -16GiB 100%
parted /dev/sda -- mkpart ESP fat32 1MiB 1024MiB
parted /dev/sda -- set 3 boot on
# formatting
mkfs.ext4 -L nixos /dev/sda1  # or on hyperV: `mkfs.ext4 -L nixos /dev/sda1 -G 4096`
mkswap -L swap /dev/sda2
swapon /dev/sda2
mkfs.fat -F 32 -n boot /dev/sda3
# installation
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
swapon /dev/sda2

nixos-generate-config --root /mnt
```

Now edit the `/mnt/etc/nixos/configuration.nix` (nano or vi) and paste

```/etc/nixos/configuration.nix

## HYPER-V
# REQUIRED - see: https://github.com/nixos/nixpkgs/issues/9899
boot.initrd.kernelModules = ["hv_vmbus" "hv_storvsc"];
# RECOMMENDED
# - use 800x600 resolution for text console, to make it easy to fit on screen
boot.kernelParams = ["video=hyperv_fb:800x600"];  # https://askubuntu.com/a/399960
# - avoid a problem with `nix-env -i` running out of memory
boot.kernel.sysctl."vm.overcommit_memory" = "1"; # https://github.com/NixOS/nix/issues/421

# german keyboard
console.keyMap = "de";

# add git to be able to clone the repo
environment.systemPackages = with pkgs; [
    vim gitMinimal
];

```

`nixos-install`

Set the root password

`reboot`...

German keys.

```bash
loadkeys de
```

FIXME: x-server and hyper-v non functional for now..
