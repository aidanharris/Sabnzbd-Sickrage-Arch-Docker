# Sabnzbd-Sickrage-Arch-Docker

An Archlinux Docker container for Sabnzbd and Sickrage.

## Usage:

```
git clone https://github.com/aidanharris/Sabnzbd-Sickrage-Arch-Docker.git Sabnzbd-Sickrage-Arch-Docker
cd Sabnzbd-Sickrage-Arch-Docker
sudo docker build --rm -t local/sabnzbd-sickrage-arch .
sudo docker run -d --name sabnzbd-sickrage-arch -v /srv/sickrage:/srv/sickrage -v /srv/sabnzbd:/srv/sabnzbd -p 8080:8080 -p 8081:8081 local/sabnzbd-sickrage-arch
```

This will be a lot easier after uploading to the Docker Hub

## Why Arch

The main reason is the Aur. Having access to the AUR makes it so much easier to install Sabnzbd and Sickrage. You only have to look at the [Dockerfile](https://github.com/aidanharris/Sabnzbd-Sickrage-Arch-Docker/blob/master/Dockerfile) to see this. Secondly it's not as bad as you might think! Because it's based on snapshots (See [pritunl/archlinux](https://hub.docker.com/r/pritunl/archlinux/)) the container should (hopefully) remain consistent overtime. Instead of updating the container with pacman (i.e `pacman -Syu`) you simply replace it with a newer container (see below).

## Updating

```
sudo docker stop sabnzbd-sickrage-arch
sudo docker rm sabnzbd-sickrage-arch
sudo docker pull local/sabnzbd-sickrage-arch # To Do: Change this to the docker image on the docker hub
sudo docker run -d --name sabnzbd-sickrage-arch -v /srv/sickrage:/srv/sickrage -v /srv/sabnzbd:/srv/sabnzbd -p 8080:8080 -p 8081:8081 local/sabnzbd-sickrage-arch
```

## To Do:

Upload the image to the Docker Hub
