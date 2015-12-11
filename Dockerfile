# FROM base/archsinux:latest
FROM python:2.7

MAINTAINER libcrack <devnull@libcrack.so>

# RUN echo -e "[extra]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf && \
#     echo -e "[community]\nInclude = /etc/pacman.d/mirrorlist\n" >> /etc/pacman.conf && \
#     pacman -Syy --noconfirm && \
#     pacman -S --noconfirm archlinux-keyring && \
#     pacman-db-upgrade && \
#     pacman -S --noconfirm core/curl extra/git extra/python-pip \
#         extra/libxml2 extra/libxslt extra/python2-lxml extra/swig

RUN groupadd spiderfoot && \
    useradd -r -g spiderfoot -d /home/spiderfoot \
        -s /sbin/nologin -c "SpiderFoot User" spiderfoot

WORKDIR /home/spiderfoot

RUN curl -sSL https://github.com/smicallef/spiderfoot/archive/master.tar.gz \
  | tar -v -C /home/spiderfoot -xz \
  && mv /home/spiderfoot/spiderfoot-master /home/spiderfoot/spiderfoot \
  && chown -R spiderfoot:spiderfoot /home/spiderfoot \
  && pip install cherrypy lxml mako M2Crypto \
       netaddr dns socks pyPdf metapdf openxmllib stem

USER spiderfoot
WORKDIR /home/spiderfoot

EXPOSE 8080

ENTRYPOINT ["/usr/bin/python2"]
CMD ["sf.py", "0.0.0.0:8080"]
