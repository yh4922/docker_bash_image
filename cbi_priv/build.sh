
# 变量
tag=$(date +%Y%m%d%H%M)
image=cbi_base_node16

# 构建镜像
docker build --no-cache -t $image:$tag -f DockerFile --network host ./
echo "镜像标签: $image:$tag"

# 导出镜像
docker save -o ./${image}_$tag.tar $image:$tag