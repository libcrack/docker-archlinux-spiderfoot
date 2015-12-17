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
    pip install metapdf openxmllib stem pyPdf M2Crypto && \
    pip install socks --allow-all-external socks --allow-unverified socks && \
    pip install dns --allow-all-external dns --allow-unverified dns

RUN groupadd spiderfoot && \
    useradd -r -g spiderfoot -d /home/spiderfoot \
      -s /sbin/nologin -c "SpiderFoot User" spiderfoot

RUN curl -sSL https://github.com/smicallef/spiderfoot/archive/master.tar.gz \
      | tar -v -C /home/spiderfoot -xz && \
    mv /home/spiderfoot/spiderfoot-master/* /home/spiderfoot/ && \
    rm -rf /home/spiderfoot-master && \
    chown -R spiderfoot:spiderfoot /home/spiderfoot

USER spiderfoot

WORKDIR /home/spiderfoot

EXPOSE 8008

ENTRYPOINT ["/usr/bin/python2"]
CMD ["sf.py", "0.0.0.0:8008"]
