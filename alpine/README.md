# Alpine

## 软件源

repositories

```
http://mirrors.aliyun.com/alpine/v3.5/main/
http://mirrors.aliyun.com/alpine/v3.5/community/
http://mirrors.aliyun.com/alpine/v3.5/releases/
```

```
ADD repositories /etc/apk/repositories
```

## 常用工具

### curl

```
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*
```

### jre

```
FROM alpine:3.5

MAINTAINER cloudtogo

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre

ADD repositories /etc/apk/repositories

RUN apk upgrade --update-cache; \
    apk add openjdk8-jre; \
    rm -rf /tmp/* /var/cache/apk/*

CMD ["java", "-version"]
```

### git

```
$ apk update && \
    apk upgrade && \
    apk add git
```