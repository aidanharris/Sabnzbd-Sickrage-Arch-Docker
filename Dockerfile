# ------------------------------------------------------------------------------
# Pull base image.
FROM pritunl/archlinux:2017-01-07
MAINTAINER Aidan Harris <mail@aidanharris.io>

# ------------------------------------------------------------------------------
# Install base
RUN pacman -S --needed --noconfirm \
      base \
      base-devel \
      git \
      supervisor \
      python2-mako \
      python2-cheetah \
      par2cmdline \
      unrar \
      unzip \
      python2-feedparser \
      python2-pyopenssl \
      intel-tbb && \
    mkdir -p /srv/sickrage /srv/sabnzbd && \
    chsh nobody -s /bin/bash && \
    su nobody -c '/bin/bash -c "cd /tmp && git clone https://aur.archlinux.org/sabnzbd.git"' && \
    su nobody -c '/bin/bash -c "cd /tmp && git clone https://aur.archlinux.org/sickrage.git"' && \
    su nobody -c '/bin/bash -c "cd /tmp && git clone https://aur.archlinux.org/python2-yenc.git"' && \
    su nobody -c '/bin/bash -c "cd /tmp && git clone https://aur.archlinux.org/par2cmdline-tbb.git"' && \
    su nobody -c '/bin/bash -c "cd /tmp/python2-yenc && makepkg"' && \
    pacman -U --noconfirm /tmp/python2-yenc/*.pkg.* && \
    su nobody -c '/bin/bash -c "cd /tmp/par2cmdline-tbb && makepkg"' && \
    su nobody -c '/bin/bash -c "cd /tmp/sabnzbd && makepkg"' && \
    su nobody -c '/bin/bash -c "cd /tmp/sickrage && makepkg"' && \
    pacman -R --noconfirm par2cmdline && \
    pacman -U --noconfirm /tmp/par2cmdline-tbb/*.pkg.* && \
    pacman -U --noconfirm /tmp/sabnzbd/*.pkg.* && \
    pacman -U --noconfirm /tmp/sickrage/*.pkg.*

# Add supervisord conf
ADD conf/sabnzbd.ini /etc/supervisor.d/
ADD conf/sickrage.ini /etc/supervisor.d/

# Add entrypoint
ADD entrypoint.sh /

# ------------------------------------------------------------------------------
# Start Container Entrypoint
CMD ["sh","/entrypoint.sh"]
