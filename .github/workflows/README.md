# GitHub Actions 工作流说明

## 概述

本仓库使用 GitHub Actions 自动构建 Docker 镜像，支持多架构（amd64 和 arm64）构建。

## 工作流文件

### 现有工作流

- `build-cbi_priv.yml` - 构建 cbi_priv 镜像
- `build-ct_wens_xlgz.yml` - 构建 ct_wens_xlgz 镜像

### 模板文件

- `build-image-template.yml` - 可复用的工作流模板，用于快速创建新的镜像构建工作流

## 使用方法

### 触发构建

1. 进入 GitHub 仓库页面
2. 点击 **Actions** 标签
3. 在左侧选择要构建的镜像工作流（如 "Build Docker Image - cbi_priv"）
4. 点击右侧的 **Run workflow** 按钮
5. 可选择输入自定义标签（留空则使用当前北京时间）
6. 点击 **Run workflow** 开始构建

### 下载构建产物

1. 构建完成后，在 Actions 页面点击对应的运行记录
2. 滚动到底部的 **Artifacts** 部分
3. 下载对应的 `.tar` 文件

构建产物命名格式：`${image}_${tag}_${arch}.tar`

例如：
- `cbi_priv_202401011200_amd64.tar`
- `cbi_priv_202401011200_arm64.tar`

## 创建新的镜像构建工作流

当需要为新子镜像创建构建工作流时：

1. 复制模板文件：
   ```bash
   cp .github/workflows/build-image-template.yml .github/workflows/build-{新镜像名称}.yml
   ```

2. 编辑新文件，将所有 `IMAGE_NAME_PLACEHOLDER` 替换为实际的子文件夹名称：
   ```bash
   sed -i 's/IMAGE_NAME_PLACEHOLDER/{新镜像名称}/g' .github/workflows/build-{新镜像名称}.yml
   ```

3. 提交并推送更改

## 构建说明

- **镜像名称**：使用子文件夹名称
- **标签格式**：`YYYYMMDDHHMM`（北京时间）
- **支持的架构**：amd64 (x86) 和 arm64 (ARM)
- **构建参数**：`--no-cache` 和 `--network host`
- **产物保留时间**：30 天

## 注意事项

- 确保每个子镜像目录下都有 `DockerFile` 文件
- 构建产物会自动上传为 GitHub Artifacts，可在 Actions 页面下载
- 每个架构会生成独立的构建产物文件

