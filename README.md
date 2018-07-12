RPI built from the [hypriot](https://blog.hypriot.com/downloads/) image.

The `docker-compose.yml` includes the following stack:

- [ombi](https://github.com/tidusjar/Ombi)
- [sonarr](https://github.com/Sonarr/Sonarr)
- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [samba](https://github.com/dperson/samba)
- [jackett](https://github.com/Jackett/Jackett)


## Swap space

Create swap since it's disabled by default:

	sudo dd if=/dev/zero of=/swapfile bs=1M count=1024
	sudo mkswap /swapfile
	sudo swapon /swapfile
	

Add to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    defaults          0       2

	# swap
	/swapfile    none    swap    sw    0   0

## Networking

For a static ip, add to `/etc/network/interfaces`:

	auto eth0
	iface eth0 inet static
	    address 192.168.1.222
	    netmask 255.255.255.0
	    gateway 192.168.1.1

## Run

    docker-compose up -d
