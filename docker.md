# docker
- Docker 使用客户端-服务器 (C/S) 架构模式，使用远程API来管理和创建Docker容器。
- Docker 容器通过 Docker 镜像来创建。（image -> Container）
- 容器与镜像的关系类似于面向对象编程中的对象与类。
- docker repository (docker hub)


[阮一峰docker教程](http://www.ruanyifeng.com/blog/2018/02/docker-tutorial.html)
## 安装

- 安装（略）
- 修改仓库为国内仓库
	- 1 推荐官方 registry.docker-cn.com 或http://hub-mirror.c.163.com
	- $ sudo service docker restart

## 用法：

```
# 列出本机的所有 image 文件。
$ docker image ls

# 删除 image 文件
$ docker image rm [imageName]

#将 image 文件从仓库抓取到本地。
$ docker image pull library/hello-world
可写成
$ docker image pull hello-world

#运行image 命令会从 image 文件，生成一个正在运行的容器实例。如果发现本地没有指定的 image 文件，就会从仓库自动抓取。因此，前面的docker image pull命令并不是必需的步骤。
$ docker container run hello-world

进入交互模式运行
docker run -i -t ubuntu:15.10 /bin/bash


前面的docker container run命令是新建容器，每运行一次，就会新建一个容器。同样的命令运行两次，就会生成两个一模一样的容器文件。如果希望重复使用容器，就要使用
$ docker container start [containID]


#对于那些不会自动终止的容器，必须使用docker container kill 命令手动终止。
$ docker container kill [containID]


# 列出本机正在运行的容器
$ docker ps 
$ docker container ls

# 列出本机所有容器，包括终止运行的容器
$ docker ps -a 
$ docker container ls --all

# 终止运行的容器文件，依然会占据硬盘空间，可以使用docker container rm命令删除。
$ docker container rm [containerID]

# 查看 docker 容器的输出
$ docker container logs [containerID]


docker container exec命令用于进入一个正在运行的 docker 容器。如果docker run命令运行容器的时候，没有使用-it参数，就要用这个命令进入容器。一旦进入了容器，就可以在容器的 Shell 执行命令了。
$ docker container exec -it [containerID] /bin/bash


搜索仓库
docker search [OPTIONS] TERM

```


## 制作自己的image（docker容器）

```
略
```
