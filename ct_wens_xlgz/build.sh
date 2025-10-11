# 变量
tag=$(date +%Y%m%d%H%M)
image=ct_wens_xlgz

# 构建镜像
docker build --no-cache -t $image:$tag -f DockerFile --network host ./
echo "镜像标签: $image:$tag"

# 导出镜像
mkdir -p ../dist
docker save -o ../dist/${image}_$tag.tar $image:$tag