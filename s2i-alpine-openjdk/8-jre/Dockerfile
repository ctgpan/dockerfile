FROM alpine:3.6

MAINTAINER cloudtogo

LABEL "alpine.version"=3.6 \
      "jre"=openjdk8-jre \
      "jre.version"=1.8.0_121 \
	  io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
	  io.s2i.scripts-url="image:///usr/libexec/s2i"

ENV JAVA_HOME=/usr/lib/jvm/default-jvm/jre
COPY repositories /etc/apk/repositories
	
ENV STI_SCRIPTS_PATH=/usr/libexec/s2i

RUN mkdir -p $STI_SCRIPTS_PATH

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN apk upgrade --update-cache && \
    apk add openjdk8-jre && \
    rm -rf /tmp/* /var/cache/apk/* && \
	chmod -R +x $STI_SCRIPTS_PATH

CMD ["java", "-version"]
