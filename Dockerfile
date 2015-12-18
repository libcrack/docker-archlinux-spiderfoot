FROM base/archlinux:latest

MAINTAINER libcrack <devnull@libcrack.so>

RUN echo -e "[extra]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf && \
    echo -e "[community]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf && \
    pacman -Syy --noconfirm && \
    pacman -S --noconfirm archlinux-keyring && \
    pacman-db-upgrade && \
    pacman -S --noconfirm core/gcc core/openssl core/curl \
        extra/git extra/python-pip extra/python-pyopenssl \
        extra/libxml2 extra/libxslt extra/python-lxml  \
        extra/swig extra/python-lxml extra/python-mako \
        community/python-cherrypy community/python-netaddr && \
    pip install --upgrade pip && \
    pip install metapdf openxmllib stem pyPdf M2Crypto

## Collecting socks
##   Could not find a version that satisfies the requirement socks (from versions: )
## No matching distribution found for socks
#    pip install --allow-all-external --allow-unverified socks socks && \
#    pip install --allow-all-external --allow-unverified dns dns

RUN groupadd spiderfoot && \
    useradd -m -r -g spiderfoot -d /home/spiderfoot \
      -s /sbin/nologin -c "SpiderFoot User" spiderfoot

RUN curl -sSL https://github.com/smicallef/spiderfoot/archive/master.tar.gz \
      | tar -v -C /home/spiderfoot -xz && \
    mv /home/spiderfoot/spiderfoot-master/* /home/spiderfoot/ && \
    rm -rf /home/spiderfoot-master && \
    chown -R spiderfoot:spiderfoot /home/spiderfoot

USER spiderfoot

WORKDIR /home/spiderfoot

EXPOSE 8008

CMD "/bin/bash"

# ENTRYPOINT ["/usr/bin/python2"]
# CMD ["sf.py", "0.0.0.0:8008"]
