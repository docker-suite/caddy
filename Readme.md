# ![](https://github.com/docker-suite/artwork/raw/master/logo/png/logo_32.png) caddy
[![Build Status](http://jenkins.hexocube.fr/job/docker-suite/job/caddy/badge/icon?color=green&style=flat-square)](http://jenkins.hexocube.fr/job/docker-suite/job/caddy/)
![Docker Pulls](https://img.shields.io/docker/pulls/dsuite/caddy.svg?style=flat-square)
![Docker Stars](https://img.shields.io/docker/stars/dsuite/caddy.svg?style=flat-square)
![MicroBadger Layers (tag)](https://img.shields.io/microbadger/layers/dsuite/caddy/latest.svg?style=flat-square)
![MicroBadger Size (tag)](https://img.shields.io/microbadger/image-size/dsuite/caddy/latest.svg?style=flat-square)
[![License: MIT](https://img.shields.io/badge/License-MIT-brightgreen.svg?style=flat-square)](https://opensource.org/licenses/MIT)

This is a docker image for [Caddy][caddy] server running on [dsuite/alpine-base][alpine-base] container.

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Volumes
- /config
- /data
- /var/www
- /var/log

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) Ports
- 80
- 443
- 2019

## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to use this image

```Dockerfile
docker build -t dsuite/caddy .
```

```Dockerfile
docker run -it -d --name=caddy \
        -p 8080:80 \
        -v $(PWD)/path/to/Caddyfile:/etc/caddy/Caddyfile \
        -v $(PWD)/path/to/www:/var/www \
            dsuite/caddy
```
Point your browser to `http://localhost:2015`.


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) How to add plugins

`dsuite/caddy` comes with an installer which download and intall the latest version from caddyserver.com  
Update the `PLUGINS` environment variable with a coma separated list of plugin and run `caddy-install.sh` to download and install the latest version of caddy with the desired plugins.

### with a docker file

```Dockerfile
FROM dsuite/caddy:latest

ENV PLUGINS[0]="github.com/gamalan/caddy-tlsredis"
ENV PLUGINS[1]="github.com/greenpau/caddy-auth-jwt"
```


## ![](https://github.com/docker-suite/artwork/raw/master/various/pin/png/pin_16.png) An example

Have a look at the [example folder](https://github.com/docker-suite/caddy/tree/master/.example). You'll find out how to create an image based on dsuite/caddy


[alpine]: http://alpinelinux.org/
[runit]: http://smarden.org/runit/
[alpine-base]: https://hub.docker.com/r/dsuite/alpine-base/
[caddy]: https://caddyserver.com/


