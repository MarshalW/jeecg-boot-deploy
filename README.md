# jeecg boot deploy

下载本项目：

```sh
$ git clone https://github.com/MarshalW/jeecg-boot-deploy.git
```

## 在 jeecg-boot 项目的操作

这里使用的操作系统是：macOS

### 下载 jeecg-boot

下载 jeecg-boot 源代码：

```sh
$ git clone https://github.com/jeecgboot/jeecg-boot.git
```

### 需要准备的软件

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

### 构建后端

构建过程：

```sh
# install
$ mvn install -P prod

# package
$ mvn package -P prod
```

### 构建前端

构建过程：

```sh
# 安装依赖库
$ yarn install

# 构建生成前端文件
$ yarn run build
```

## 在本项目中的操作

### backend

#### 获取 jeecg-boot backend 文件

编辑 `./get_backend.sh`，设置 sql 脚本和 jar 文件的路径：

```sh
#!/bin/bash

script_path=../../../jeecg-boot/jeecg-boot/db/jeecgboot-mysql-5.7.sql
jar_path=../../../jeecg-boot/jeecg-boot/jeecg-boot-module-system/target/jeecg-boot-module-system-2.4.6.jar
```

在本项目下执行命令将 sql 脚本和 jar 文件下载到本项目的 backend 目录下：

```sh
$ ./get_backend.sh
```

#### 构建 jeecg-boot backend dockder image

构建 docker image：

```sh
$ cd backend

$ docker build \
    --no-cache \
    . \
    -t jeecg-boot-backend
```

### frontend

#### 获取 jeecg-boot frontend 文件

编辑 `./get_frontend.sh`，设置生成 dist 的路径：

```sh
$ ./get_frontend.sh
```

#### 构建 jeecg-boot frontend docker image

构建 docker image:

```sh
$ cd frontend

$ docker build \
    --no-cache \
    . \
    -t jeecg-boot-frontend
```

### 运行

运行 frontend/backend/mysql/redis:

```sh
$ docker-compose up -d
```

然后就可以通过：

- [http://localhost:8080/jeecg-boot](http://localhost:8080/jeecg-boot) 访问后端
- [http://localhost:3000/](http://localhost:3000/) 访问前端

### 释放

关闭所有服务（frontend/backend/mysql/redis）

```sh
# 关闭服务
$ docker-compose down

# 删除卷
$ docker volume rm jeecg-boot-deploy_mysqldb
```
