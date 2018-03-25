# Caddy simple html example

This is a simple example where caddy serve a single html page on port 80

```Dockerfile
docker run -it --rm \
    -v $(pwd)/etc/caddy:/etc/caddy \
    -v $(pwd)/var/www:/var/www \
    -v $(pwd)/var/log:/var/log \
    -e LOGGER=false \
    -p 80:80 \
    --name caddy-simplehtml-80 \
    craftdock/caddy
```
