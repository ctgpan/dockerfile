FROM alpine:3.5

MAINTAINER cloudtogo

LABEL "alpine.version"=3.5 \
      "jre"=openjdk8-jre \
      "jre.version"=1.8.0_121 \

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre

RUN apk upgrade --update-cache && \
    apk add openjdk8-jre && \
    rm -rf /tmp/* /var/cache/apk/*

CMD ["java", "-version"]