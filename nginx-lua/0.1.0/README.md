# nginx-lua


[![Github repo](images/GitHub.png "Github repo")](https://github.com/ctgpan/dockerfile/tree/master/nginx-lua/0.1.0)

This docker image's reference:

- [nginxinc/docker-nginx](https://github.com/nginxinc/docker-nginx/blob/3ba04e37d8f9ed7709fd30bf4dc6c36554e578ac/mainline/alpine/Dockerfile)
- [danday74/docker-nginx-lua](https://github.com/danday74/docker-nginx-lua/blob/master/Dockerfile)

## usage

```
$ docker run -d -p 80:80 nginx-lua:0.1.0
```

The docker image contains a `hello` api compiled with Lua and you can get the response like this.

```
$ curl -is http://localhost/hello
HTTP/1.1 200 OK
Server: nginx/1.13.6
Date: Mon, 06 Nov 2017 09:53:32 GMT
Content-Type: text/plain
Transfer-Encoding: chunked
Connection: keep-alive

Hello,world!
```