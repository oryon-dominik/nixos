# nixos installation

Installation from minimal nixos iso

1. setup the keyboard

    ```sh
    sudo loadkeys de
    ```

2. booting should have installed ethernet

    ```sh
    ip a
    # connect to wifi with:
    wpa_supplicant -B -i {interface} -c <(wpa_passphrase '{SSID}' '{key}')
    ```

3. partition your disk (pretending it's `/dev/sda`, you can check it with `lsblk`) on UEFI with `parted`

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

4. format your disks

    ```sh
    mkfs.ext4 -L system /dev/sda1
    mkswap -L swap /dev/sda2
    mkfs.fat -F 32 -n boot /dev/sda3
    ```

5. mount the disks

    ```sh
    mount /dev/disk/by-label/system /mnt
    mkdir -p /mnt/boot
    mount /dev/disk/by-label/boot /mnt/boot
    swapon /dev/sda2
    ```

6. edit or create your config

    ```sh
    nixos-generate-config --root /mnt
    nix-env --install git
    git clone https://github.com/oryon-dominik/nixos /mnt/etc/nixos/
    nano /mnt/etc/nixos/configuration.nix  # import the correct machine settings for your device :)
    ```

7. machine config

    ```sh
    
    # see .. https://github.com/oryon-dominik/nixos/blob/master/configuration.nix
    ```

if something goes wrong you can't fix, reboot and mount again

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
    # change root password
    passwd
