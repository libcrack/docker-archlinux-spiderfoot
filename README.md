# SpiderFoot Arch linux docker container

[![](https://badge.imagelayers.io/libcrack/archlinux-spiderfoot:latest.svg)](https://imagelayers.io/?images=libcrack/archlinux-spiderfoot:latest 'libcrack/archlinux-spiderfoot')

Build the image:

```bash
docker build -t archlinux-spiderfoot .
```

Run the container:

```bash
docker run -d -p 8000:8000 --name spiderfoot archlinux-spiderfoot
```

Alternatively, you can run the image pulling it directly from hub.docker.com:

```bash
docker run -d -p 8000:8000 --name spiderfoot libcrack/archlinux-spiderfoot
```

