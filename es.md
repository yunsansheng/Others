# 安装
docker pull elasticsearch:7.2.0

docker run -it --name es -d -p 9200:9200 -p 9300:9300 -p 5601:5601 elasticsearch:7.2.0

# 验证
