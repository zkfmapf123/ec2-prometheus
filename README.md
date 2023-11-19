# EC2 + Prometheus + Grafana

## Common

```sh
    ## Install docker
    sudo yum update -y
    sudo yum install docker -y
    sudo systemctl restart docker

    ## docker permit
    sudo groupadd docker
    sudo usermod -aG docker $USER
    sudo newgrp docker

    ## Install docker-compose
    sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

    ## create network
    docker network create monitoring
```

## Prometheus

```sh
    # in local
    cd configs
    sh prometheus.sh

    # in instance
    cd /promethues && docker-compose up --build -d
    cd /grafana && docker-compose up --build -d
    cd /node-exporter && docker-compose up --build -d
```

## apiserver

```sh
    # in local
    cd configs
    sh apiserver.sh

    # in instance
    cd /node-exporter && docker-compose up --build -d
```

## Prometheus 1) 3개의 인스턴스를 직접 입력해서 사용하는 경우

- 근데 이러면... 매번 docker서비스를 올리고 내려야 함

```sh
    docker exec -it [prometehus-contianer-id] /bin/sh
    sudo vi /etc/prometheus/prometheus.yml

    ## static_configs 수정
    ...
    static_configs:
      - targets: ['172.31.2.115:9101', '172.31.3.214:9101', '172.31.7.73:9101']
    ...
```

## Prometheus 2) 자체적으로 Service Discovery를 운용해서 사용하는 경우

- localhost:9000 형태로 ServiceDiscovery를 운용해서 사용하는 방법
- [service-discovery](./service-discovery/README.md)
