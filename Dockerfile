FROM centos:centos7

RUN yum update

# 安装工具
RUN yum install -y git epel-release
RUN yum groupinstall -y "fonts"

# 安装桌面
RUN yum install -y tigervnc-server openbox

# 安装浏览器
RUN yum install -y chromium

# 安装 Selenium
RUN yum install -y centos-release-scl
RUN yum install -y rh-python36 -y
RUN scl enable rh-python36 "pip install -U pip"
RUN scl enable rh-python36 "pip install selenium"

# 安装 noVNC
RUN cd /usr/local/src && \
    git clone --depth=1 https://github.com/novnc/noVNC.git novnc && \
	git clone --depth=1 https://github.com/novnc/websockify.git websockify

# 安装 Cloud9
RUN yum install -y gcc glibc-static make tmux which && \
	cd /usr/local/src && \
	git clone https://github.com/c9/core.git c9sdk && \
	cd c9sdk && \
	scripts/install-sdk.sh

# 安装 Caddy

# 安装 supervisor
RUN yum install -y python-setuptools
RUN easy_install pip
RUN pip install supervisor
ADD supervisord.d /etc/supervisord.d
RUN echo_supervisord_conf > /etc/supervisord.conf && \
	echo '[include]' >> /etc/supervisord.conf && \
	echo 'files = supervisord.d/*.ini' >> /etc/supervisord.conf

# 添加启动文件
ADD run.sh /app/run.sh

ENV DISPLAY=":1"
ENV VNC_PASSWD="12345678"

EXPOSE 8080

CMD bash /app/run.sh