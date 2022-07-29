## Docker lnmp 本地工作目录配置
通过docker-composer 编排容器从而构建lnmp环境

## 安装docker&docker-compose
赋予sh可执行权限 `chmod +x docker-docker-compose.install.sh`,
运行./docker-docker-compose.install.sh 来安装docker和docker-compose,
通过运行`docker -v` 和`docker-compose -v` 来验证是否安装成功。

## 工作目录相关配置
- php: 7.2
- mysql: 8.0.16
- nginx: 1.17.4
- redis: 4.2.0
- mongodb: 1.5.3
## 目录结构
```
project
|
|---app(项目目录)
|
|---lnmp
    |
    |--- mongo(mongo Dockerfile)
    |      
    |--- mount(mongo、mysql、redis数据挂载目录)
    |      
    |--- mysql(mysql Dockerfile、mysql配置文件)
    |
    |--- nginx
    |      |---conf.d(站点nginx配置目录)
    |      |---log(站点日志目录)
    |--- php(php.ini 配置文件、swoole、mongodb、redis压缩包)
    |
    |--- redis(redis.conf 配置文件)
    |
    |--- .env(环境配置文件)
    |
    |--- docker-compose.yml(docker编排文件)

```
## 环境配置
lnmp目录下有.env文件，该文件提供了一些简单的环境配置，参数如下
WORKER_DIR：工作目录（该路径为宿主机工作目录的绝对路径）。
DATA_PATH：本地数据存储的路径（该路径为宿主机的绝对路径）
NGINX_DIR：nginx配置的目录（该路径为宿主机的绝对路径）


## 使用说明
1. 把php项目放置到app目录下。
2. 创建php项目nginx站点配置信息，保存位置lnmp目录中nginx下conf.d中。
3. 终端进入到lmnp目录下执行:
```
# 当容器未运行时，直接运行一下命令
docker-compose up -d 启动各个容器
# 当容器运行时，先dwon容器然后在启动容器
docker-compose down 停止各个容器
```

:D