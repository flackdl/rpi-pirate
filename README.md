RPI Docker Compose stack including the following:

- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [nefarious](https://github.com/lardbit/nefarious)
- [jackett](https://github.com/Jackett/Jackett)
- [samba](https://github.com/dperson/samba)
- [docker-autossh](https://github.com/flackdl/rpi-docker-autossh)
	
The base RPI image is best built from [hypriot](https://blog.hypriot.com/downloads/) since it's stripped down and supports Docker out of the box.
Download their [flash](https://github.com/hypriot/flash) tool to write the image.  Include user-data to configure things like a static ip address. [static-config](https://github.com/hypriot/flash/blob/master/sample/static.yml) example.

Something like:
 
    flash --userdata static.yml https://github.com/hypriot/image-builder-rpi/releases/download/v1.11.2/hypriotos-rpi-v1.11.2.img.zip

# Further Configuration

## External Hard Drive

Add something like this to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    defaults          0       2

## Run

First, copy `.env.template` to `.env` and update accordingly.  Also, you'll need the private ssh key in `id_rsa` for the autossh feature to work.

    docker-compose up -d
