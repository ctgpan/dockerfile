FROM alpine:3.6

MAINTAINER cloudtogo

LABEL alpine.version=3.6 \
      jdk=openjdk8 \
	  jdk.version=1.8.0_131 \
	  maven.version=3.3.9 \
	  maven.repository="user.home/.m2/repository" \
	  spring-boot-starter-parent=1.5.6.RELEASE \
	  io.k8s.description="cloudtogo spring boot builder image" \
	  io.k8s.display-name="Cloudtogo Spring Boot" \
	  io.openshift.expose-services="8080:http" \
	  io.openshift.s2i.scripts-url="image:///usr/libexec/s2i" \
	  io.s2i.scripts-url="image:///usr/libexec/s2i"

ADD repositories /etc/apk/repositories
	
ENV JAVA_HOME=/usr/lib/jvm/java-1.8-openjdk
ENV PATH=$PATH:$JAVA_HOME/bin:$JAVA_HOME/jre/bin

ENV MAVEN_VERSION=3.3.9
ENV MAVEN_HOME=/usr/lib/maven
ENV PATH=$PATH:$MAVEN_HOME/bin

ENV STI_SCRIPTS_URL=image:///usr/libexec/s2i
ENV STI_SCRIPTS_PATH=/usr/libexec/s2i

RUN mkdir -p $STI_SCRIPTS_PATH

COPY ./s2i/bin/ $STI_SCRIPTS_PATH

RUN apk upgrade --update-cache && \
    apk add openjdk8 && \
    rm -rf /tmp/* /var/cache/apk/* && \
	wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
	mv apache-maven-$MAVEN_VERSION $MAVEN_HOME && \
	ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn && \
	chmod -R +x $STI_SCRIPTS_PATH

# ADD repository /root/.m2/repository

# Modify the usage script in your application dir to inform the user how to run this image.
CMD $STI_SCRIPTS_PATH/usage
