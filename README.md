RPI Docker Compose stack including the following:

- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [nefarious](https://github.com/lardbit/nefarious)
- [jackett](https://github.com/Jackett/Jackett)
- [samba](https://github.com/dperson/samba)
- [plex](https://docs.linuxserver.io/images/docker-plex)
	
The base RPI image is [Ubuntu Server](https://ubuntu.com/download/raspberry-pi), specifically for the [raspberry pi 64-bit](https://ubuntu.com/download/raspberry-pi/thank-you?version=22.04.3&architecture=server-arm64+raspi).

Download the [flash](https://github.com/hypriot/flash) tool to write the image.  Include *user-data* and a *network-config* to configure things like users and a static ip address.

Something like:
 
    flash --userdata user-data.yml --file network-config https://cdimage.ubuntu.com/releases/22.04.3/release/ubuntu-22.04.3-preinstalled-server-arm64+raspi.img.xz

## Debugging with LXC and cloud-init

	sudo lxc launch ubuntu:focal rpi --config=user.user-data="$(cat user-data.yml)"
	sudo lxc shell rpi

Inside the instance:

	cloud-init status --wait

# Further Configuration

## External Hard Drive

Add something like this to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    nofail,x-systemd.device-timeout=60s          0       2

## Plex
You can optionally populate a [claim](https://www.plex.tv/claim/) code in the env variables for automatic configuration.

## Run

All docker containers will already be running on boot.
