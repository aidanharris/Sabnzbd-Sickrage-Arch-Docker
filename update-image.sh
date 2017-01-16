#!/bin/bash
CURRENT_TAG="$(head -n 3 Dockerfile | tail -n1 | sed 's/.*://g')"
LATEST_TAG="$(REPOSITORY='pritunl/archlinux' sudo -E bash list-tags.sh | head -n1)"
if [[ "$CURRENT_TAG" != "$LATEST_TAG" ]] ; then
  echo "Old Tag: $CURRENT_TAG"
  echo "New Tag: $LATEST_TAG"
  sed -i "s/FROM pritunl\/archlinux:.*/FROM pritunl\/archlinux:$LATEST_TAG/g" Dockerfile
  sudo docker build --rm -t local/sabnzbd-sickrage-arch .
  sudo docker tag local/sabnzbd-sickrage-arch aidanharris/sabnzbd-sickrage-arch:"$LATEST_TAG"
  sudo docker push aidanharris/sabnzbd-sickrage-arch:"$LATEST_TAG"
  sudo docker tag local/sabnzbd-sickrage-arch aidanharris/sabnzbd-sickrage-arch:latest
  sudo docker push aidanharris/sabnzbd-sickrage-arch:latest
fi
