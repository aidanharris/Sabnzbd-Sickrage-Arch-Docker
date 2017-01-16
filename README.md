# Sabnzbd-Sickrage-Arch-Docker

An Archlinux Docker container for Sabnzbd and Sickrage.

## Usage:

```bash
git clone https://github.com/aidanharris/Sabnzbd-Sickrage-Arch-Docker.git Sabnzbd-Sickrage-Arch-Docker
cd Sabnzbd-Sickrage-Arch-Docker
sudo docker build --rm -t local/sabnzbd-sickrage-arch .
sudo docker run -d --name sabnzbd-sickrage-arch -v /srv/sickrage:/srv/sickrage -v /srv/sabnzbd:/srv/sabnzbd -p 8080:8080 -p 8081:8081 local/sabnzbd-sickrage-arch
```

This will be a lot easier after uploading to the Docker Hub (You won't have to build the container)...

## FAQ:

### I can't access sabnzbd on http://example.com:8080

Sabnzbd by default listens only on localhost which means you may not be able to access it outside of the container. To fix this edit the sabnzbd config file as follows:

```bash
sudo docker stop sabnzbd-sickrage-arch # Stop the docker container
sudo sed -i 's/host = 127.0.0.1/host = 0.0.0.0/g' /srv/sabnzbd/sabnzbd.ini # Listen on all interfaces
sudo docker start sabnzbd-sickrage-arch # Start the docker container
```

## Why Arch

The main reason is the Aur. Having access to the AUR makes it so much easier to install Sabnzbd and Sickrage. You only have to look at the [Dockerfile](https://github.com/aidanharris/Sabnzbd-Sickrage-Arch-Docker/blob/master/Dockerfile) to see this. Secondly it's not as bad as you might think! Because it's based on snapshots (See [pritunl/archlinux](https://hub.docker.com/r/pritunl/archlinux/)) the container should (hopefully) remain consistent overtime. Instead of updating the container with pacman (i.e `pacman -Syu`) you simply replace it with a newer container (see below).

## Updating

```bash
sudo docker stop sabnzbd-sickrage-arch
sudo docker rm sabnzbd-sickrage-arch
sudo docker pull local/sabnzbd-sickrage-arch # To Do: Change this to the docker image on the docker hub
sudo docker run -d --name sabnzbd-sickrage-arch -v /srv/sickrage:/srv/sickrage -v /srv/sabnzbd:/srv/sabnzbd -p 8080:8080 -p 8081:8081 local/sabnzbd-sickrage-arch
```

## To Do:

* Upload the image to the Docker Hub
* Look in to removing this repository to Gitlab. I may be able to get a nice workflow going where Gitlab CI builds and pushes the container to Docker Hub everytime something in the repo changes.
