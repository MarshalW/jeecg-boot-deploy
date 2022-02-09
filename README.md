# jeecg boot deploy

## 和 jeecg-boot 项目的衔接

这里使用的操作系统是：macOS

### 下载 jeecg-boot

下载 jeecg-boot 源代码：

```sh
$ git clone https://github.com/jeecgboot/jeecg-boot.git
```

### 需要的软件

确保已经安装了：

- java sdk
- maven
- node.js
- docker / docker-compose

### 编辑配置文件

修改配置文件 `jeecg-boot/jeecg-boot-module-system/src/main/resources/application-prod.yml `

mysql:

```yml
..
datasource:
        master:
          url: "jdbc:mysql://${MYSQL_HOST:localhost}:3306/jeecg-boot?characterEncoding=UTF-8&useUnicode=true&useSSL=false&tinyInt1isBit=false&allowPublicKeyRetrieval=true&serverTimezone=Asia/Shanghai"
..
```

redis:

```yml
..
redis:
    database: 0
    host: "${REDIS_HOST:localhost}"
..
```

目的是便于后面部署的时候通过环境变量在运行时传递参数。

同理可用于动态设置数据库密码等，这里没有做。

设置`knife4j.production`为`false`，默认是`true`（屏蔽访问）

```yml
knife4j:
  #开启增强配置
  enable: true
  #开启生产环境屏蔽
  production: false
```

### 构建

构建过程：

```sh
# install 
$ mvn install -P prod 

# package
$ mvn package -P prod
```

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
