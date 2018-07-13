RPI Docker Compose stack including the following:

- [ombi](https://github.com/tidusjar/Ombi)
- [sonarr](https://github.com/Sonarr/Sonarr)
- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [samba](https://github.com/dperson/samba)
- [jackett](https://github.com/Jackett/Jackett)
	
I built the RPI images from [hypriot](https://blog.hypriot.com/downloads/).

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

First, copy `.env.template` to `.env` and update accordingly.

    # run via included script (includes time-outs)
    ./up.sh

    # run via straight up docker command
    docker-compose up -d

## Caveats

Ombi couldn't retrieve any "root folders" from Sonarr until I went into Sonarr, search for a series then defined a download path.
