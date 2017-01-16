# Sabnzbd-Sickrage-Arch-Docker

An Archlinux Docker container for Sabnzbd and Sickrage.

## Usage:

First create the volume locations to store sickrage and sabnzbd configuration and data:

```bash
sudo mkdir -p /srv/sickrage /srv/sabnzbd
```

This is important to ensure that your configuration / data persists when updating the container with a new one.



```bash
sudo docker run -d --name sabnzbd-sickrage-arch \
-v /srv/sickrage:/srv/sickrage \
-v /srv/sabnzbd:/srv/sabnzbd \
-p 8080:8080 \
-p 8081:8081 \
aidanharris/sabnzbd-sickrage-arch
```

## Building:

```bash
git clone https://github.com/aidanharris/Sabnzbd-Sickrage-Arch-Docker.git Sabnzbd-Sickrage-Arch-Docker
cd Sabnzbd-Sickrage-Arch-Docker
sudo docker build --rm -t local/sabnzbd-sickrage-arch .
```

## FAQ:

### I can't access sabnzbd on http://example.com:8080

Sabnzbd by default listens only on localhost which means you may not be able to access it outside of the container. To fix this edit the sabnzbd config file as follows:

```bash
sudo docker stop sabnzbd-sickrage-arch # Stop the docker container
sudo sed -i 's/host = 127.0.0.1/host = 0.0.0.0/g' /srv/sabnzbd/sabnzbd.ini # Listen on all interfaces
sudo docker start sabnzbd-sickrage-arch # Start the docker container
```

## Why Arch

The main reason is the Aur. Having access to the AUR makes it so much easier to install Sabnzbd and Sickrage. You only have to look at the [Dockerfile](https://github.com/aidanharris/Sabnzbd-Sickrage-Arch-Docker/blob/master/Dockerfile) to see this. Secondly it's not as bad as you might think! Because it's based on snapshots (See [pritunl/archlinux](https://hub.docker.com/r/pritunl/archlinux/)) the container should (hopefully) remain consistent over time. Instead of updating the container with pacman (i.e `pacman -Syu`) you simply replace it with a newer container (see below).

## Updating

```bash
sudo docker stop sabnzbd-sickrage-arch # stop the container
sudo docker rm sabnzbd-sickrage-arch # remove the old container
sudo docker pull aidanharris/sabnzbd-sickrage-arch # pull the latest container
sudo docker run -d --name sabnzbd-sickrage-arch \
-v /srv/sickrage:/srv/sickrage \
-v /srv/sabnzbd:/srv/sabnzbd \
-p 8080:8080 \
-p 8081:8081 \
aidanharris/sabnzbd-sickrage-arch # create the new container
```

For maximum productivity you could add the above to an `@daily` cronjob or a System D timer (if that's your thing).

## To Do:

* Upload the image to the Docker Hub
* Look in to moving this repository to Gitlab. I may be able to get a nice workflow going where Gitlab CI builds and pushes the container to Docker Hub everytime something in the repo changes.
* Reduce the size of the container:
```bash
docker run --rm --entrypoint=/bin/sh local/sabnzbd-sickrage-arch -c 'du -sh / 2>/dev/null | cut -f1'
```

The above comes in at 1.3G which isn't too large but could still be made smaller.
