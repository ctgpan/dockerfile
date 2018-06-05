FROM node:9-alpine

MAINTAINER <CloudToGo>

# https://hackerlite.xyz/2017/09/18/alpine-docker-image-with-node-sass/

RUN apk update && \
    apk upgrade && \
    apk add git g++ gcc libgcc libstdc++ linux-headers make python nginx && \
    apk update && \
    mkdir -p /run/nginx && \
    chmod +x /home/startup.sh

# install libsass
RUN git clone https://github.com/sass/sassc && cd sassc && \
    git clone https://github.com/sass/libsass && \
    SASS_LIBSASS_PATH=/sassc/libsass make && \
    mv bin/sassc /usr/bin/sassc && \
    cd ../ && rm -rf /sassc

# created node-sass binary
ENV SASS_BINARY_PATH=/usr/lib/node_modules/node-sass/build/Release/binding.node
RUN git clone --recursive https://github.com/sass/node-sass.git && \
    cd node-sass && \
    git submodule update --init --recursive && \
    npm install && \
    node scripts/build -f && \
    cd ../ && rm -rf node-sass

# add binary path of node-sass to .npmrc
RUN touch $HOME/.npmrc && echo "sass_binary_cache=${SASS_BINARY_PATH}" >> $HOME/.npmrc

ENV SKIP_SASS_BINARY_DOWNLOAD_FOR_CI true
ENV SKIP_NODE_SASS_TESTS true
ENV PORT=80

COPY default.conf /etc/nginx/conf.d/default.conf

WORKDIR /home

CMD ["nginx", "-g", "daemon off;"]
