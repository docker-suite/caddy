# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) caddy
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/caddy/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/caddy/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/caddy.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/caddy.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/caddy/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/caddy/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)

This is a docker image for [Caddy][caddy] server running on [Alpine container][alpine-runit] with [runit][runit] process supervisor.

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes
- /etc/caddy
- /etc/caddy/certificates
- /var/www
- /var/log

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports
- 80
- 443
- 2015

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Available environment variables

Name                | Default value 
--------------------|-------------------------------------------------
CADDY_AGREE         | `false`
CADDY_CA            | `https://acme-v01.api.letsencrypt.org/directory`
CADDY_CA_TIMEOUT    | `10s`
CADDY_CPU           | `100%`
CADDY_EMAIL         | [empty]
CADDY_GRACE         | `5s`
CADDY_HTTP2         | `true`
CADDY_QUIET         | `false`
CADDY_PORT          | `2015`
CADDY_HTTP_PORT     | `80`
CADDY_HTTPS_PORT    | `443`
PGID                | `1050`
PUID                | `1050`

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to use this image

```Dockerfile
docker build -t dsuite/caddy .
```

```Dockerfile
docker run -it -d --name=caddy \
        -p 2015:2015 \
        -v $(PWD)/path/to/Caddyfile:/etc/caddy/Caddyfile \
        -v $(PWD)/path/to/www:/var/www \
            dsuite/caddy:1.0
```
Point your browser to `http://localhost:2015`.

### Saving Certificates

Save certificates on host machine to prevent regeneration every time container starts. Let's Encrypt has rate limit.

```Dockerfile
docker run -it -d --name=caddy \
        -p 80:80 -p 443:443 \
        -v $(PWD)/path/to/certs:/etc/caddy/certificates \
        -v $(PWD)/path/to/Caddyfile:/etc/caddy/Caddyfile \
        -v $(PWD)/path/to/www:/var/www \
            dsuite/caddy:1.0
```
Here, `/etc/caddy/certificates` is the location inside the container where caddy will save certificates.

To start or stop caddy, get an sh command prompt inside the container:

```bash
docker exec -it caddy sh

# Start caddy
runit service caddy start
# Stop caddy
runit service caddy stop
# Restart caddy
runit service caddy restart
# Status of caddy
runit service caddy status

# Stop the container
runit stop
```

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) An example

Have a look at the [example folder](https://github.com/docker-suite/caddy/tree/master/.example). You'll find out how to create an image based on dsuite/caddy


[alpine]: http://alpinelinux.org/
[runit]: http://smarden.org/runit/
[alpine-runit]: https://hub.docker.com/r/dsuite/alpine-runit/
[caddy]: https://caddyserver.com/


