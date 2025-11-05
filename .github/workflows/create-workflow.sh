#!/bin/bash
# 快速创建新的镜像构建工作流脚本
# 使用方法: ./create-workflow.sh <镜像名称>
# 例如: ./create-workflow.sh my_new_image

if [ -z "$1" ]; then
    echo "错误: 请提供镜像名称（子文件夹名称）"
    echo "使用方法: $0 <镜像名称>"
    exit 1
fi

IMAGE_NAME="$1"
TEMPLATE_FILE=".github/workflows/build-image-template.yml"
OUTPUT_FILE=".github/workflows/build-${IMAGE_NAME}.yml"

if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "错误: 模板文件不存在: $TEMPLATE_FILE"
    exit 1
fi

if [ -f "$OUTPUT_FILE" ]; then
    echo "警告: 工作流文件已存在: $OUTPUT_FILE"
    read -p "是否覆盖? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "已取消操作"
        exit 1
    fi
fi

# 复制模板并替换占位符
sed "s/IMAGE_NAME_PLACEHOLDER/${IMAGE_NAME}/g" "$TEMPLATE_FILE" > "$OUTPUT_FILE"

echo "✓ 成功创建工作流文件: $OUTPUT_FILE"
echo ""
echo "下一步:"
echo "1. 检查生成的文件: cat $OUTPUT_FILE"
echo "2. 提交更改: git add $OUTPUT_FILE"
echo "3. 提交: git commit -m 'Add workflow for ${IMAGE_NAME}'"
echo "4. 推送: git push"

