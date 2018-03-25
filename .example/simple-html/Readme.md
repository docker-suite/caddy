# Caddy simple html example

This is a simple example where caddy serve a single html page


```Dockerfile
docker build -t caddy-simplehtml .
```


```Dockerfile
docker run -it --rm \
    -p 2015:2015 \
    --name caddy-simplehtml \
    caddy-simplehtml
```
