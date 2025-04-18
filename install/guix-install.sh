#!/bin/sh

umount -R /mnt

# mount the disk & create the subvolumes
mount LABEL=guix /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@gnu
btrfs subvolume create /mnt/@home
umount -R /mnt

# make the directories
mount LABEL=guix /mnt -osubvol=/@
mkdir -p /mnt/home
mkdir -p /mnt/gnu
mkdir -p /mnt/boot/efi

# mount all in the right place
mount LABEL=guix /mnt/home -osubvol=/@home
mount LABEL=guix /mnt/gnu -osubvol=/@gnu
mount LABEL=GUIX-EFI /mnt/boot/efi

### get the config files
wget https://raw.githubusercontent.com/jotix/guix-config/refs/heads/main/system-config.scm
wget https://raw.githubusercontent.com/jotix/guix-config/refs/heads/main/install/channels.scm
wget https://raw.githubusercontent.com/jotix/guix-config/refs/heads/main/install/signing-key.pub

### installation
herd start cow-store /mnt
guix archive --authorize < signing-key.pub
guix time-machine -C ./channels.scm -- system init ./system-config.scm /mnt --substitute-urls='https://ci.guix.gnu.org https://bordeaux.guix.gnu.org https://substitutes.nonguix.org'
