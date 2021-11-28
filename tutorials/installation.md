# nixos installation

Using an iso [from here](https://releases.nixos.org/?prefix=nixos/).

1. Setup the keyboard.

    ```sh
    sudo loadkeys de
    ```

2. Booting should have installed ethernet.

    ```sh
    # identify your interface name
    ip a
    # connect to wifi
    wpa_supplicant -B -i {interface} -c <(wpa_passphrase '{SSID}' '{key}')
    ```

3. Partitions on UEFI with `parted` (pretending the device is `/dev/sda`, you can check it with `lsblk`).

I'm ignoring the warning `Warning: The resulting partition is not properly aligned for best performance.` 
here, because [I don't know better](https://rainbow.chard.org/2013/01/30/how-to-align-partitions-for-best-performance-using-parted/).

    ```sh
    parted /dev/sda -- mklabel gpt
    # root
    parted /dev/sda -- mkpart primary 1024MiB -16GiB
    # swap
    parted /dev/sda -- mkpart primary linux-swap -16GiB 100%
    # boot
    parted /dev/sda -- mkpart ESP fat32 1MiB 1024MiB
    parted /dev/sda -- set 3 esp on
    ```

4. Format and label your disks.

    ```sh
    mkfs.ext4 -L system /dev/sda1
    mkswap -L swap /dev/sda2
    mkfs.fat -F 32 -n boot /dev/sda3
    ```

5. Mount 'em.

    ```sh
    mount /dev/disk/by-label/system /mnt
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/boot /mnt/boot
    swapon /dev/sda2
    ```

6. Clone your config.

    ```sh
    nixos-generate-config --root /mnt
    mv /mnt/etc/nixos /mnt/etc/nixos.backup
    nix-env --install git
    git clone https://github.com/oryon-dominik/nixos /mnt/etc/nixos/
    cp /mnt/etc/nixos.backup/hardware-configuration.nix /mnt/etc/nixos/hardware-configuration.nix
    ```

7. Machine config.

Only keep the necessary machine settings for your device. Comment out useless parts.

    ```sh
    nano /mnt/etc/nixos/configuration.nix
    ```

    ```sh
    imports = [
    # Device specific hardware configuration (change this to your device)
    ./machines/default  # <-----
    # ./machines/surface
    # ./machines/raspberry
    ...
    ]
    ```

If something goes wrong you can't fix, reboot and mount (5) again.

    ```sh
    mount /dev/disk/by-label/system /mnt
    mount /dev/disk/by-label/boot /mnt/boot
    swapon /dev/sda2
    nano /mnt/etc/nixos/configuration.nix
    ```

8. Install

    ```sh
    nixos-install
    reboot

If you want to implement changes after succesfull installation, build a new config with the next boot.

    ```sh
    nixos-rebuild boot
    ```


9.  SSH-Key for github-access.

When logged into your user-account.

    mkdir -p ~/.ssh
    ssh-keygen -t ecdsa -b 521 -f ~/.ssh/id_ecdsa_GITHUB -C "oryon@cyberise.de/nixos" -q -N ""
    echo "Add this key to your GITHUB ssh-keys to gain access:"
    echo (lolcat ~/.ssh/id_ecdsa_GITHUB.pub)


10. Extras

## Interactive exploration of the config.

    nix repl '<nixpkgs/nixos>'  # quit with ctrl+d or ':q'


## Restricting access

To limit which users can perform Nix operations, you can use the permissions on the directory /nix/var/nix/daemon-socket.
 For instance, if you want to restrict the use of Nix to the members of a group called nix-users, do

    chgrp nix-users /nix/var/nix/daemon-socket
    chmod ug=rwx,o= /nix/var/nix/daemon-socket

This way, users who are not in the nix-users group cannot connect to the Unix domain socket /nix/var/nix/daemon-socket/socket,
 so they cannot perform Nix operations.
