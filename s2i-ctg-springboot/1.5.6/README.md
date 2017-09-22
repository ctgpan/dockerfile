## 1.5.6

```
<parent>
	<groupId>org.springframework.boot</groupId>
	<artifactId>spring-boot-starter-parent</artifactId>
	<version>1.5.6.RELEASE</version>
	<relativePath/> <!-- lookup parent from repository -->
</parent>
```

```
$ docker run -d s2i-ctg-springboot:1.5.6 sh -c "while true; do echo hello ...; sleep 2; done"

$ docker rmi s2i-ctg-springboot:1.5.6

$ docker build -t s2i-ctg-springboot:1.5.6 .

$ s2i build https://code.aliyun.com/k8s/service01.git s2i-ctg-springboot:1.5.6 service01:2017.09.22.03 --loglevel=5
```

```
$ docker rmi s2i-alpine-openjdk:8-jre 

$ docker build -t s2i-alpine-openjdk:8-jre .

$ s2i build https://code.aliyun.com/k8s/service01.git s2i-ctg-springboot:1.5.6 service01:2017.09.22.04 --runtime-image=s2i-alpine-openjdk:8-jre --runtime-artifact=/target/service01.jar --loglevel=5
```
