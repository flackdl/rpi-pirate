RPI Docker Compose stack including the following:

- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [nefarious](https://github.com/lardbit/nefarious)
- [jackett](https://github.com/Jackett/Jackett)
- [samba](https://github.com/dperson/samba)
- [docker-autossh](https://github.com/flackdl/rpi-docker-autossh)
	
The base RPI image is best built from [hypriot](https://blog.hypriot.com/downloads/) since it's stripped down and supports Docker out of the box.

# Configuration

## External Hard Drive

Add to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    defaults          0       2

## Networking

For a static ip, add to `/etc/network/interfaces`:

	auto eth0
	iface eth0 inet static
	    address 192.168.1.222
	    netmask 255.255.255.0
	    gateway 192.168.1.1

## Run

First, copy `.env.template` to `.env` and update accordingly.  Also, you'll need the private ssh key in `id_rsa` for the autossh feature to work.

    # run via included script (includes time-outs)
    ./up.sh

    # run via straight up docker command
    docker-compose up -d
