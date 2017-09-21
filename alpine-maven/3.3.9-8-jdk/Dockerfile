FROM alpine:3.6

MAINTAINER cloudtogo

LABEL "alpine.version"=3.6 \
      "jdk"=openjdk8 \
	  "jdk.version"="1.8.0_131"

# ADD repositories /etc/apk/repositories
	
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

ENV MAVEN_VERSION=3.3.9
ENV MAVEN_HOME=/usr/lib/maven
ENV PATH=$PATH:$MAVEN_HOME/bin

RUN apk upgrade --update-cache && \
    apk add openjdk8 && \
    rm -rf /tmp/* /var/cache/apk/* && \
	wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	mv apache-maven-$MAVEN_VERSION $MAVEN_HOME

CMD ["mvn", "-v"]