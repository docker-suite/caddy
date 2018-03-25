# Caddy simple html example

This is a simple example where caddy serve a single html page on port 8080

```Dockerfile
docker run -it --rm \
    -v $(pwd)/etc/caddy:/etc/caddy \
    -v $(pwd)/var/www:/var/www \
    -v $(pwd)/var/log:/var/log \
    -e LOGGER=false \
    -p 8080:80 \
    --name caddy-simplehtml-8080 \
    craftdock/caddy
```
