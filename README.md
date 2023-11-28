RPI Docker-Compose stack including the following:

- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [nefarious](https://github.com/lardbit/nefarious)
- [jackett](https://github.com/Jackett/Jackett)
- [samba](https://github.com/dperson/samba)
- [plex](https://docs.linuxserver.io/images/docker-plex) (opt-in)
	
The base RPI image is [Ubuntu Server](https://ubuntu.com/download/raspberry-pi), specifically for the [raspberry pi 64-bit](https://ubuntu.com/download/raspberry-pi/thank-you?version=22.04.3&architecture=server-arm64+raspi).

## Customize

Extract image:

    xz -d ~/Downloads/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img.xz 

Create multiple loop devices for each partition of the image/iso:

    sudo partx -a -v ~/Desktop/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img

> /dev/loop23: partition #1 added

> /dev/loop23: partition #2 added

Mount the /boot partition:

    sudo mount /dev/loop23p1 /mnt/rpi

Copy cloud-init configs to /boot partition:

    sudo cp network-config /mnt/rpi/
    sudo cp user-data.yml /mnt/rpi/user-data

Unmount:

    umount /mnt/rpi

Write sd card:

    sudo dd if=~/Downloads/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img of=/dev/mmcblk0 status=progress bs=4M

# Further Configuration

SSH into device to manually configure other items.

## External Hard Drive

Add something like this to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    nofail,x-systemd.device-timeout=60s          0       2

## Plex
You can optionally populate a [claim](https://www.plex.tv/claim/) code in the env variables for automatic configuration.

## Run

All docker containers will already be running on boot.
