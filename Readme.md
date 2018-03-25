# caddy

This is a docker image for [Caddy][caddy] server running on [Alpine container][alpine-runit] with [runit][runit] process supervisor.

## Volumes
- /etc/caddy
- /etc/caddy/certificates
- /var/www
- /var/log

## Ports
- 80
- 443
- 2015

## Available environment variables

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

## How to use this image

```Dockerfile
docker build -t craftdock/caddy .
```

```Dockerfile
docker run -it -d --name=caddy \
        -p 2015:2015 \
        -v $(PWD)/caddy/file/:/etc/caddy \
        -v $(PWD)/caddy/www/:/var/www \
            craftdock/caddy
```
Point your browser to `http://127.0.0.1:2015`.

### Saving Certificates

Save certificates on host machine to prevent regeneration every time container starts. Let's Encrypt has rate limit.

```Dockerfile
docker run -it -d --name=caddy \
        -p 80:80 -p 443:443 \
        -v $(PWD)/caddy/cert/:/root/.caddy \
        -v $(PWD)/caddy/file/:/etc/caddy \
        -v $(PWD)/caddy/www/:/var/www \
            craftdock/caddy
```
Here, `/root/.caddy` is the location inside the container where caddy will save certificates.

To start or stop caddy, get an sh command prompt inside the container:

```powershell
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

## An example

Have a look at the [example folder](https://github.com/CraftDock/caddy/tree/master/example). You'll find out how to create an image based on craftdock/caddy

This example folder contains:
- A simple web site (``simple-html`)
- A simple web site (``simple-html-2`)
- A simple web site on port 80 (``simple-html-80`)
- A simple web site on port 8080 (``simple-html-8080`)
- A simple web site (``simple-html-2`)


[alpine]: http://alpinelinux.org/
[runit]: http://smarden.org/runit/
[alpine-runit]: https://hub.docker.com/r/craftdock/alpine-runit/
[caddy]: https://caddyserver.com/


