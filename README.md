# Docker Chrome Browser

基于 Alpine 3.20 的轻量级 Docker 版 Chrome 浏览器，支持简体中文和插件。

## 特性

- 基于 Alpine 3.20，镜像轻量
- 简体中文界面支持
- 支持 Chrome 插件
- 通过 VNC 访问
- 支持持久化存储

## 构建镜像

```bash
docker build -t docker-chrome .
```

## 运行容器

### 基本运行

```bash
docker run -d -p 5900:5900 --name chrome docker-chrome
```

### 启用持久化存储

```bash
docker run -d -p 5900:5900 -v chrome-data:/home/chrome --name chrome docker-chrome
```

### 挂载本地目录进行持久化

```bash
docker run -d -p 5900:5900 -v /path/to/local/chrome/data:/home/chrome --name chrome docker-chrome
```

## 访问浏览器

使用任何 VNC 客户端连接到 `localhost:5900`，密码为 `chrome`。

## 插件安装

在 Chrome 浏览器中，可以通过以下方式安装插件：

1. 打开 Chrome 扩展页面 (chrome://extensions/)
2. 启用"开发者模式"
3. 选择"加载已解压的扩展程序"
4. 导航到插件目录并选择插件文件夹

## 自定义配置

可以通过修改 Dockerfile 和配置文件来自定义浏览器设置。