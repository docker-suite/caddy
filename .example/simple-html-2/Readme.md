# Caddy simple html example

This is a simple example where caddy serve a single html page

```Dockerfile
docker run -it --rm \
    -v $(pwd)/etc/caddy:/etc/caddy \
    -v $(pwd)/var/www:/var/www \
    -v $(pwd)/var/log:/var/log \
    -e LOGGER=false \
    -p 2015:2015 \
    --name caddy-simplehtml-2 \
    craftdock/caddy
```
