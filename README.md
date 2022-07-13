RPI Docker Compose stack including the following:

- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [nefarious](https://github.com/lardbit/nefarious)
- [jackett](https://github.com/Jackett/Jackett)
- [samba](https://github.com/dperson/samba)
- [plex](https://docs.linuxserver.io/images/docker-plex)
- [pihole](https://github.com/pi-hole/pi-hole)
	
The base RPI image is [Ubuntu Server](https://ubuntu.com/download/raspberry-pi), specifically for the [raspberry pi 32-bit](https://ubuntu.com/download/raspberry-pi/thank-you?version=22.04&architecture=server-armhf+raspi).

Download the [flash](https://github.com/hypriot/flash) tool to write the image.  Include *user-data* and a *network-config* to configure things like users and a static ip address.

Something like:
 
    flash --userdata user-data.yml --file network-config https://cdimage.ubuntu.com/releases/22.04/release/ubuntu-22.04-preinstalled-server-armhf+raspi.img.xz

## Debugging with LXC and cloud-init

	sudo lxc launch ubuntu:focal rpi --config=user.user-data="$(cat user-data.yml)"
	sudo lxc shell rpi

Inside the instance:

	cloud-init status --wait

# Further Configuration

## External Hard Drive

Add something like this to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    nofail,x-systemd.device-timeout=1ms          0       2

## Run

All docker containers will already be running on boot.


## Pihole

It's necessary to disable the existing dns server to run pihole:

    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
