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

8. install

    ```sh
    nixos-install
    reboot
    # change passwords for root and your user logins
    passwd [options] [LOGIN]
