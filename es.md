# 安装
docker pull elasticsearch:7.2.0

docker run -d --name es -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" -p 9200:9200 -p 9300:9300 elasticsearch:7.2.0


docker start es

# 验证
docker exec -it es /bin/bash
