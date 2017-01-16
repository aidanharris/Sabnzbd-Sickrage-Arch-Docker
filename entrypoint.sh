#!/bin/sh
chown -R sickrage:sickrage /srv/sickrage
chown -R sabnzbd:sabnzbd /srv/sabnzbd
supervisord -n -c /etc/supervisord.conf
