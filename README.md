# jeecg boot deploy

## backend

构建 docker image：

```sh
$ docker build \
    --no-cache \
    . \
    -t jeecg-boot-backend
```

运行 backend/mysql/redis:

```sh
docker-compose up -d
```

## frontend


