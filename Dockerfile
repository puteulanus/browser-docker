FROM centos:centos7

RUN yum update -y

# 安装工具
RUN yum install -y wget git epel-release
RUN yum groupinstall -y "fonts"

# 安装桌面
RUN yum install -y tigervnc-server openbox

# 安装浏览器
RUN yum install -y chromium chromedriver

# 安装 Selenium
RUN yum install -y centos-release-scl
RUN yum install -y rh-python36 -y
RUN scl enable rh-python36 "pip install -U pip"
RUN scl enable rh-python36 "pip install selenium"
ADD conf/enable-rh-python36.sh /etc/profile.d/enable-rh-python36.sh

# 安装 Supervisor
RUN yum install -y python-setuptools
RUN easy_install pip
RUN pip install supervisor
ADD supervisord.d /etc/supervisord.d
RUN echo_supervisord_conf > /etc/supervisord.conf && \
	echo '[include]' >> /etc/supervisord.conf && \
	echo 'files = supervisord.d/*.ini' >> /etc/supervisord.conf && \
	sed -i 's/\/tmp\//\/var\/run\//' /etc/supervisord.conf

# 安装 noVNC
RUN cd /usr/local/src && \
    git clone --depth=1 https://github.com/novnc/noVNC.git novnc && \
	git clone --depth=1 https://github.com/novnc/websockify.git websockify
RUN pip install numpy

# 安装 Cloud9
RUN yum install -y gcc gcc-c++ glibc-static make \
	tmux which python-devel && \
	cd /usr/local/src && \
	git clone https://github.com/c9/core.git c9sdk && \
	cd c9sdk && \
	scripts/install-sdk.sh && \
	pip install -U virtualenv && \
	virtualenv --python=python2 /root/.c9/python2 && \
	source /root/.c9/python2/bin/activate && \
	mkdir /tmp/codeintel && \
	pip download -d /tmp/codeintel codeintel==0.9.3 && \
	cd /tmp/codeintel && \
	tar xf CodeIntel-0.9.3.tar.gz && \
	mv CodeIntel-0.9.3/SilverCity CodeIntel-0.9.3/silvercity && \
	tar czf CodeIntel-0.9.3.tar.gz CodeIntel-0.9.3 && \
	pip install -U --no-index --find-links=/tmp/codeintel codeintel
ADD workspace /root/workspace

# 安装 Caddy
RUN mkdir -p /tmp/caddy && \
	cd /tmp/caddy && \
	wget -q -O caddy.tar.gz 'https://caddyserver.com/download/linux/amd64?license=personal' && \
	tar zxf caddy.tar.gz && \
	mv caddy /usr/local/bin/ && \
	rm -rf /tmp/caddy
ADD conf/Caddyfile /etc/caddy/Caddyfile

# 添加启动文件
ADD run.sh /app/run.sh

WORKDIR /root/workspace

ENV DISPLAY=":1"
ENV VNC_PASSWD="12345678"

EXPOSE 80

CMD bash /app/run.sh
