FROM alpine:3.6

MAINTAINER cloudtogo

LABEL "alpine.version"=3.6 \
      "jre.version"=openjdk8

# ADD repositories /etc/apk/repositories

RUN apk upgrade --update-cache; \
    apk add openjdk8; \
    rm -rf /tmp/* /var/cache/apk/*
	
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

CMD ["java", "-version"]