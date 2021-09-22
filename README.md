RPI Docker Compose stack including the following:

- [transmission / openvpn](https://github.com/haugene/docker-transmission-openvpn)
- [nefarious](https://github.com/lardbit/nefarious)
- [jackett](https://github.com/Jackett/Jackett)
- [samba](https://github.com/dperson/samba)
- [plex](https://docs.linuxserver.io/images/docker-plex)
- [pihole](https://github.com/pi-hole/pi-hole)
	
The base RPI image is best built from [hypriot](https://blog.hypriot.com/downloads/) since it's stripped down and supports Docker out of the box.
Download their [flash](https://github.com/hypriot/flash) tool to write the image.  Include *user-data* and a *network-config* to configure things like users and a static ip address.

Something like:
 
    flash --userdata user-data.yml --file network-config https://github.com/hypriot/image-builder-rpi/releases/download/v1.12.3/hypriotos-rpi-v1.12.3.img.zip

# Further Configuration

## External Hard Drive

Add something like this to `/etc/fstab`:

	# external hd
	LABEL=blackhole /media/pi/blackhole   ext4    nofail,x-systemd.device-timeout=1ms          0       2

## fail2ban

    sudo apt-update && apt-get install -y fail2ban

## Run

First, copy `.env.template` to `.env` and update accordingly.

    docker-compose up -d

## Autossh

If setting up a reverse ssh tunnel:

    sudo apt update && sudo apt install -y autossh

Copy your private ssh key `id_rsa` to `/home/pi/rpi-pirate`.

Create the following systemd service in `/etc/systemd/system/autossh.service`:

**NOTE: update the domain and port**.

    [Unit]
    Description=Autossh rpi
    After=network.target
    
    
    [Service]
    Type=simple
    User=pi
    Restart=always
    ExecStart=/usr/bin/autossh -N -M 10984  -o "StrictHostKeyChecking=no" -o "PubkeyAuthentication=yes" -o "PasswordAuthentication=no" -i /home/pi/rpi-pirate/id_rsa -R 2230:localhost:22 autossh@XXX.XXX.com
    RestartSec=3
    StartLimitBurst=5
    StartLimitIntervalSec=0
    
    [Install]
    WantedBy=multi-user.target


Start & enable the service:

    sudo systemctl start autossh
    sudo systemctl enable autossh

## Pihole

It's necessary to disable the existing dns server to run pihole:

    sudo systemctl stop systemd-resolved
    sudo systemctl disable systemd-resolved
