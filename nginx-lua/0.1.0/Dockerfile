FROM alpine:3.5

MAINTAINER cloudtogo

ENV VER_NGINX=1.13.6
ENV VER_LUAJIT=2.0.4
ENV VER_NGINX_DEVEL_KIT=0.3.0
ENV NGINX_DEVEL_KIT=ngx_devel_kit-${VER_NGINX_DEVEL_KIT}
ENV VER_LUA_NGINX_MODULE=0.10.11
ENV LUA_NGINX_MODULE=lua-nginx-module-${VER_LUA_NGINX_MODULE}

ENV NGINX_ROOT=/etc/nginx

ENV LUAJIT_LIB=/usr/local/lib
ENV LUAJIT_INC=/usr/local/include/luajit-2.0

RUN apk upgrade --update-cache && \
    apk add wget musl-dev && \
    apk add gcc libc-dev make openssl-dev  pcre-dev  zlib-dev  linux-headers  curl  gnupg  libxslt-dev  gd-dev  geoip-dev && \
    cd /home && \
    wget http://nginx.org/download/nginx-${VER_NGINX}.tar.gz  && \
    wget http://luajit.org/download/LuaJIT-${VER_LUAJIT}.tar.gz  && \
    wget --no-check-certificate https://github.com/simpl/ngx_devel_kit/archive/v${VER_NGINX_DEVEL_KIT}.tar.gz -O ${NGINX_DEVEL_KIT}.tar.gz  && \
    wget --no-check-certificate https://github.com/openresty/lua-nginx-module/archive/v${VER_LUA_NGINX_MODULE}.tar.gz -O ${LUA_NGINX_MODULE}.tar.gz && \
    tar -xzvf nginx-${VER_NGINX}.tar.gz && rm nginx-${VER_NGINX}.tar.gz && \
    tar -xzvf LuaJIT-${VER_LUAJIT}.tar.gz && rm LuaJIT-${VER_LUAJIT}.tar.gz && \
    tar -xzvf ${NGINX_DEVEL_KIT}.tar.gz && rm ${NGINX_DEVEL_KIT}.tar.gz && \
    tar -xzvf ${LUA_NGINX_MODULE}.tar.gz && rm ${LUA_NGINX_MODULE}.tar.gz && \
    cd LuaJIT-${VER_LUAJIT} && \
    make && make install && \
    cp ${LUAJIT_LIB}/libluajit-5.1.so ${LUAJIT_LIB}/libluajit-5.1.so.2 && \
    ln -s ${LUAJIT_LIB}/libluajit-5.1.so.2 /lib/libluajit-5.1.so.2 && \
    cd ../nginx-${VER_NGINX} && \
    ./configure --prefix=${NGINX_ROOT} --with-ld-opt="-Wl,-rpath,${LUAJIT_LIB}" --add-module=../${NGINX_DEVEL_KIT} --add-module=../${LUA_NGINX_MODULE} && \
    make -j2 && make install && \
    ln -s ${NGINX_ROOT}/sbin/nginx /usr/sbin/nginx && \
    cd .. && rm -rf * && \
    apk del gcc make openssl-dev gnupg gd-dev libxslt-dev && \
    mkdir -p /etc/nginx/conf/conf.d && \
    mkdir -p /var/log/nginx

COPY nginx.conf /etc/nginx/conf/nginx.conf
COPY nginx.vh.default.conf /etc/nginx/conf/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
