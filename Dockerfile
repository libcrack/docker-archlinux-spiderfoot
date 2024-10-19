FROM archlinux:latest

MAINTAINER libcrack <devnull@libcrack.so>

RUN echo -e "[community]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf && \
    pacman-key --init && \
    pacman-key --populate && \
    pacman-db-upgrade && \
    pacman -Syy --noconfirm && \
    pacman -S --noconfirm archlinux-keyring && \
    pacman -S --noconfirm core/gcc core/libxml2 core/openssl core/curl \
        extra/git extra/python-pip extra/python-pyopenssl extra/libxslt \
        extra/python-lxml extra/swig extra/python-lxml extra/python-mako \
        extra/python-cherrypy extra/python-netaddr && \
        extra/python-stem extra/python-pyPdf extra/python-M2Crypto

        # extra/python-metapdf extra/python-openxmllib && \ 

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

EXPOSE 8000

ENTRYPOINT ["/usr/bin/python"]
CMD ["sf.py", "0.0.0.0:8000"]
