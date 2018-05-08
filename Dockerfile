FROM centos:centos7

RUN yum update

# 安装桌面
RUN yum groupinstall -y "Gnome"

# 安装 VNC
RUN yum install -y tigervnc tigervnc-server

# 安装浏览器
RUN yum install -y firefox fonts-chinese

# 安装 Selenium
RUN yum install -y centos-release-scl epel-release
RUN yum install -y rh-python36 -y
RUN scl enable rh-python36 "pip install -U pip"
RUN scl enable rh-python36 "pip install selenium"

# 安装 Cloud9
RUN yum install -y gcc glibc-static make tmux which && \
	cd /usr/local/src && \
	git clone https://github.com/c9/core.git c9sdk && \
	cd c9sdk && \
	scripts/install-sdk.sh

# 安装 Caddy

# 添加启动文件
ADD run.sh /app/run.sh

ENV DISPLAY=":1"
ENV VNC_PASSWD="12345678"

EXPOSE 8080

CMD bash /app/run.sh