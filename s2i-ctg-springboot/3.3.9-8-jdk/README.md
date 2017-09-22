## 3.3.9-8-jdk


```
$ docker rmi s2i-ctg-springboot:1.0 && 

$ docker build -t s2i-ctg-springboot:1.0 .

$ s2i build https://code.aliyun.com/k8s/service01.git s2i-ctg-springboot:1.0 service01:2017.09.22.02 --loglevel=5

$ s2i build . s2i-ctg-springboot:1.0 service01 --loglevel=5
```
