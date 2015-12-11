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
    useradd -r -g spiderfoot -d /spiderfoot \
        -s /sbin/nologin -c "SpiderFoot User" spiderfoot

WORKDIR /

RUN curl -sSL https://github.com/smicallef/spiderfoot/archive/master.tar.gz \
  | tar -v -C / -xz \
  && mv /spiderfoot-master /spiderfoot \
  && chown -R spiderfoot:spiderfoot /spiderfoot \
  && pip install cherrypy lxml mako M2Crypto \
       netaddr dns socks pyPdf metapdf openxmllib stem


USER spiderfoot
WORKDIR /spiderfoot

EXPOSE 8080

# Run the application.
ENTRYPOINT ["/usr/bin/python2"]
CMD ["sf.py", "0.0.0.0:8080"]
