FROM alpine:3.13.4
LABEL maintainer="rangh <rangh@foxmail.com>"

ENV VERSION 0.43.0
ENV TZ=Asia/Shanghai
WORKDIR /

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk add --no-cache tzdata \
    && ln -snf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && echo ${TZ} > /etc/timezone

RUN if [ "$(uname -m)" = "x86_64" ]; then export PLATFORM=amd64 ; else if [ "$(uname -m)" = "aarch64" ]; then export PLATFORM=arm64 ; fi fi \
	&& wget --no-check-certificate https://github.com/fatedier/frp/releases/download/v${VERSION}/frp_${VERSION}_linux_${PLATFORM}.tar.gz \ 
	&& tar xzf frp_${VERSION}_linux_${PLATFORM}.tar.gz \
	&& cd frp_${VERSION}_linux_${PLATFORM} \
	&& mkdir -p /var/app \
	&& mv frps /var/app \
	&& mv frpc /var/app \
	&& mkdir -p /var/app/config \
	&& mv frps.ini /var/app/config \
	&& cd .. \
	&& rm -rf *.tar.gz frp_${VERSION}_linux_${PLATFORM}

CMD /var/app/frps -c /var/app/config/frps.ini

EXPOSE 7000