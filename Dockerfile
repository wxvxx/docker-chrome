FROM alpine:3.20

# 安装必要的依赖
RUN apk add --no-cache \
    bash \
    curl \
    sudo \
    xvfb \
    x11vnc \
    openbox \
    supervisor \
    ttf-dejavu \
    font-noto-cjk \
    fluxbox \
    xterm \
    mesa-dri-gallium \
    xf86-video-modesetting \
    udev \
    chromium \
    chromium-chromedriver

# 创建用户
RUN adduser -D chrome \
    && echo "chrome:chrome" | chpasswd \
    && adduser chrome wheel \
    && echo "chrome ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# 创建必要目录
RUN mkdir -p /home/chrome/.config/chromium \
    && mkdir -p /home/chrome/.vnc \
    && mkdir -p /home/chrome/Downloads \
    && chown -R chrome:chrome /home/chrome

# 复制配置文件
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY xinitrc /home/chrome/.xinitrc

# 设置权限
RUN chmod +x /home/chrome/.xinitrc \
    && chown chrome:chrome /home/chrome/.xinitrc

# 暴露VNC端口
EXPOSE 5900

# 切换到chrome用户
USER chrome

# 设置工作目录
WORKDIR /home/chrome

# 启动supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]