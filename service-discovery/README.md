# Service-Discovery

## Docker Command

```sh
    docker build -t service-discovery -f Dockerfile .
    docker run -p 8080:8080 --restart=always -d service-discovery
```

## Test

```sh
    ## health check
    curl localhost:8080/health

    ## add to targets
    curl -X POST http://localhost:8080/add \
    -H "Content-Type: application/json" \
    -d '{"key": "a", "host": "10.0.100.1", "port": "3000"}' \

    curl -X POST http://localhost:8080/add \
    -H "Content-Type: application/json" \
    -d '{"key": "b", "host": "10.0.100.2", "port": "3000"}' \

    curl -X POST http://localhost:8080/add \
    -H "Content-Type: application/json" \
    -d '{"key": "c", "host": "10.0.100.3", "port": "3000"}'

    ## delete to targtes
    curl -X POST http://localhost:8080/remove \
    -H "Content-Type: application/json" \
    -d '{"key": "a"}'

    ## targets
    curl localhost:8080/targets
```
