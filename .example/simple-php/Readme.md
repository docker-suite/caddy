# Caddy simple php example

This is a simple example where caddy serve a single php page.
The php page is provided by the [cratfdock/alpine-php7][alpine-php7] image.

```Dockerfile
docker-compose  --project-name simplephp \
                up
```

[alpine-php7]: https://hub.docker.com/r/craftdock/alpine-php7/
