# docker
- Docker 使用客户端-服务器 (C/S) 架构模式，使用远程API来管理和创建Docker容器。
- Docker 容器通过 Docker 镜像来创建。（image -> Container）
- 容器与镜像的关系类似于面向对象编程中的对象与类。
- docker repository (docker hub)

[阮一峰docker教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)

[docker git book](https://yeasy.gitbooks.io/docker_practice/content/)

[docker 命令大全](https://www.runoob.com/docker/docker-command-manual.html)

## 安装

- 安装（略）
- 修改仓库为国内仓库
	- 1 推荐官方 registry.docker-cn.com 
	    - http://hub-mirror.c.163.com
	    - Azure 中国镜像 https://dockerhub.azk8s.cn
	    - 七牛云加速器 https://reg-mirror.qiniu.com
	- $ sudo service docker restart

## 用法：

### Image

```bash
docker command --help 查找帮助

# 拉镜像
$ docker search centos
$ docker image pull centos

# 列出本机的所有 image 文件。
$ docker image ls
$ docker images 

显示中间层镜像：
$ docker image ls -a

只显示镜像id
$ docker image ls -q

镜像摘要
docker image ls --digests 

# 列出指定镜像：
$ docker image ls ubuntu
$ docker image ls ubuntu:18.04

-f 参数 filter
$ docker image ls -f since=mongo:3.2
$ docker image ls -f before=mongo:3.2
$ docker image ls -f label=com.example.version=0.1



# 删除 image 文件
$ docker image rm [选项] <镜像1> [<镜像2> ...]
<镜像> 可以是 镜像短 ID、镜像长 ID、镜像名 或者 镜像摘要。

组合使用
$ docker image rm $(docker image ls -q redis)
$ docker image rm $(docker image ls -q -f before=mongo:3.2)

```

### run image

```bash
当我们创建一个容器的时候，docker会自动对它进行命名。另外，我们也可以使用--name标识来命名容器，
$ docker run --name webserver -d -p 80:80 nginx

ps. docker run和 docker container run是一样的


- 容器命名为 webserver
- 端口左边的是映射出来的端口，右边的是容器内的端口
- 最右边的是镜像名
###进入交互模式运行
docker run -i -t ubuntu:15.10 /bin/bash
or
docker run -it ubuntu:15.10 /bin/bash

docker run -it --rm  ubuntu:15.10 /bin/bash # 使用完后自动删除

exit  # 退出容器

对于那些不会自动终止的容器，必须使用docker container kill 命令手动终止。

## docker commit 
可以对正在运行中的容易使用docker exec命令
$ docker exec -it webserver bash
root@3729b97e8226:/# echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
root@3729b97e8226:/# exit
exit


$ docker diff 命令看到具体的改动

# 保存容器为心的镜像
$ docker commit --author "henry" --message "eidt" webserver nginx:v2

将webserver容器保存成 nginx:v2镜像

$ docker history nginx:v2

新的镜像定制好后，我们可以来运行这个镜像
$ docker run --name web2 -d -p 81:80 nginx:v2


慎用 docker commit

```


### Dockerfile
```bash
在一个空白目录中，建立一个文本文件，并命名为 Dockerfile：

$ mkdir mynginx
$ cd mynginx
$ touch Dockerfile

其内容为：

FROM nginx
RUN echo '<h1>Hello, Docker!</h1>' > /usr/share/nginx/html/index.html
这个 Dockerfile 很简单，一共就两行。涉及到了两条指令，FROM 和 RUN。

RUN 执行命令
- shell 格式：RUN <命令>
- exec 格式：RUN ["可执行文件", "参数1", "参数2"]，这更像是函数调用中的格式。

Dockerfile 中每一个指令都会建立一层，RUN 也不例外。
RUN buildDeps = 'gcc libc6-dev make wget' \
	&& apt-get update \
	...
	
真正需要添加的东西，任何无关的东西都应该清理掉。
在 Dockerfile 文件所在目录执行：
$ docker build -t nginx:v3 .
docker build [选项] <上下文路径/URL/->
docker build 命令得知这个路径后，会将路径下的所有内容打包，然后上传给 Docker 引擎。这样 Docker 引擎收到这个上下文包后，展开就会获得构建镜像所需的一切文件。

这并不是要复制执行 docker build 命令所在的目录下的 package.json，也不是复制 Dockerfile 所在目录下的 package.json，而是复制 上下文（context） 目录下的 package.json。

一般来说，应该会将 Dockerfile 置于一个空目录下，或者项目根目录下。如果该目录下没有所需文件，那么应该把所需文件复制一份过来,如果目录下有些东西确实不希望构建时传给 Docker 引擎，那么可以用 .gitignore 一样的语法写一个 .dockerignore，该文件是用于剔除不需要作为上下文传递给 Docker 引擎的。


docker build 还支持从 URL 构建，比如可以直接从 Git repo 中构建：
$ docker build https://github.com/twang2218/gitlab-ce-zh.git#:11.1

用给定的 tar 压缩包构建
$ docker build http://server/context.tar.gz
```


### 操作容器
```bash
启动容器有两种方式，一种是基于镜像新建一个容器并启动，另外一个是将在终止状态（stopped）的容器重新启动。

因为 Docker 的容器实在太轻量级了，很多时候用户都是随时删除和新创建容器。

# 创建并启动一个容器
$ docker run -t -i ubuntu:18.04 /bin/bash


$ docker container start [containID]
$ docker container start [name]

查看正在运行中的容器
$ docker ps 
$ docer container ls

查看包括停止的容器
$ docker ps -a
$ docker container ls --all#这个显示的内容比上面少？？

更多的时候，需要让 Docker 在后台运行而不是直接把执行命令的结果输出在当前宿主机下。此时，可以通过添加 -d 参数来实现。
这种情况下可以通过logs查看运行的日志
docker (container) logs [containID|name]

可以使用 docker container stop 来终止一个运行中的容器。
此外，当 Docker 容器中指定的应用终结时，容器也自动终止。

docker (container) stop [containID|name]
$ docker container stop 
$ docker stop 

$ docker container restart

# 终止运行的容器文件，依然会占据硬盘空间，可以使用docker container rm命令删除。
$ docker container rm [containerID]
如果要删除一个运行中的容器，可以添加 -f 参数。Docker 会发送 SIGKILL 信号给容器。

用下面的命令可以清理掉所有处于终止状态的容器。
$ docker container prune


docker container exec命令用于进入一个正在运行的 docker 容器。如果docker run命令运行容器的时候，没有使用-it参数，就要用这个命令进入容器。一旦进入了容器，就可以在容器的 Shell 执行命令了。
$ docker container exec -it [containerID] /bin/bash

```

### 进入容器

```bash
在使用 -d 参数时，容器启动后会进入后台。

某些时候需要进入容器进行操作，包括使用 docker attach 命令或 docker exec 命令，推荐大家使用 docker exec 命令，原因会在下面说明。

####不推荐
$ docker run -dit ubuntu
$ docker container ls
$ docker attach 243c
root@243c32535da7:/#
注意： 如果从这个 stdin 中 exit，会导致容器的停止。
####不推荐

$ docker run -dit ubuntu
69d137adef7a8a689cbcb059e94da5489d3cddd240ff675c640c8d96e84fe1f6

$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
69d137adef7a        ubuntu:latest       "/bin/bash"         18 seconds ago      Up 17 seconds                           zealous_swirles

$ docker exec -i 69d1 bash
ls
bin
boot
dev
...

$ docker exec -it 69d1 bash
root@69d137adef7a:/#


## 导出容器，导出到当前目录
$ docker export 7691a814370e > ubuntu.tar


## 可以使用 docker import 从容器快照文件中再导入为镜像，例如
$ cat ubuntu.tar | docker import - test/ubuntu:v1.0
此外，也可以通过指定 URL 或者某个目录来导入，例如
$ docker import http://example.com/exampleimage.tgz example/imagerepo
注：用户既可以使用 docker load 来导入镜像存储文件到本地镜像库，也可以使用 docker import 来导入一个容器快照到本地镜像库。这两者的区别在于容器快照文件将丢弃所有的历史记录和元数据信息（即仅保存容器当时的快照状态），而镜像存储文件将保存完整记录，体积也要大。此外，从容器快照文件导入时可以重新指定标签等元数据信息。
docker load 完整
docker import 快照

```

### 小案例 - jupyter notebook

```bash
# 
$ docker run -it centos:latest /bin/bash
yum install openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel  -y
yum install -y wget
yum -y install gcc automake autoconf libtool make
yum -y install zlib*
yum install libffi-devel -y 

wget https://www.python.org/ftp/python/3.7.4/Python-3.7.4.tar.xz

tar -xvJf Python-3.7.4.tar.xz 
mv Python-3.7.4 /usr/local
cd /usr/local/Python-3.7.4
./configure   
make && make install

########
pip3 install jupyter notebook

jupyter notebook --ip=0.0.0.0 --no-browser --allow-root

docker container start 2ad5de9a25d6

docker exec 2ad5de9a25d6 jupyter notebook --ip=0.0.0.0 --no-browser --allow-root 

'''
docker stop 2ad5de9a25d6
docker commit 2ad5de9a25d6 jupyter:v1
'''

docker run -d --name notebook -p 8888:8888 jupyter:v1 jupyter notebook --ip=0.0.0.0 --no-browser --allow-root 

# 启动
docker container start 650294077c45


```

### 数据管理

```bash
#创建一个数据卷
$ docker volume create my-vol

#查看所有的数据卷
$ docker volume ls

在用 docker run 命令的时候，使用 --mount 标记来将 数据卷 挂载到容器里。在一次 docker run 中可以挂载多个 数据卷。
$ docker run -d -P \
    --name web \
    # -v my-vol:/wepapp \
    --mount source=my-vol,target=/webapp \
    training/webapp \
    python app.py

#删除
$ docker volume rm my-vol

$ $ docker volume prune


    
```

### 网络

```bash
-p 标记可以多次使用来绑定多个端口
```

