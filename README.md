# Docker Tutorial

## Docker란 무엇인가?

OSX를 사용할 때 내가 현재 사용하지 않는 `ruby`, `node`, `mysql` 같은 것들이 뒤에서 돌아가면서 내 메모리와 CPU 파워를 차지하고 있으며, 이는 자원의 낭비이다.

그러나 Docker를 사용하게되면 이야기가 달라진다. 내 OS에 `ruby`나 `mysql`을 설치하는 대신 Docker Engine을 설치한다. 그리고 그 Docker Engine안에 `ruby`나 `mysql`을 설치하는 것이다. Docker Engine에 설치된 이미지들을 사용할 때에는 CPU나 메모리, 디스크등을 접근할 수 있는 OS의 `Kernel`을 이용한다.

Docker Image들은 OS를 거치지 않기 때문에 이를 실행하기 위해서는 OS로 Packageing 하는 과정이 필요하다. 내 OS와 각 이미지들이 Packaging된 OS는 같은 Kernel을 사용해야한다.

만약 Linux를 쓴다면, Debian이나 Ubuntu, Alpine 같은 Kernel을 쓸 것이고, MS를 쓴다면, Microsoft Server Core나 Microsoft Nano Server를 쓸 것이다.

추가적으로, ruby의 gem처럼 같이 추가적으로 필요한 과정이 있는 경우에도 OS와 함께 미리 Packaging 해놓는다.

## Dockerfile

`Code`와 `OS`, 다른 의존성들을 정의 해놓은 파일이다. 이 파일을 이용하여 Docker Image를 생성한다.

```shell
$ docker build
```

```shell
$ docker run -p 8000:8000 -it IMAGE ID node server.js
```

```shell
$ docker run -it IMAGE ID /bin/sh
```

### Dockerfile commands

FROM - Set the baseImage to use for subsequent instructions. FROM must be the first instruction in a Dockerfile.

WORKDIR - Set the working directory for any subsequent ADD, COPY, CMD, ENTRYPOINT, or RUN instructions that follow it in the Dockerfile.

ADD - Copy files, folders, or remote URLs from source to the dest path in the image's filesystem.

## Debug broken Docker builds

Docker는 `docker build`로 Dockerfile을 통해 이미지를 생성하면서 각 시행마다 임시 이미지인 **intermediate image**를 생성한다.

```shell
Step 4/6 : ADD . /app
 ---> d6522788204e // 이것이 intermediate image
```

따라서 docker에서 출력한 에러 메시지 이외에 좀 더 깊게 debug하고 싶다면 해당 이미지을 실행한 뒤

```shell
$ docker run -it d6522788204e /bin/sh
```

해당 shell안에서 다음 시행을 직접 해보면서 어떤 것이 문제였는 지, 문제가 생기지 않으려면 어떻게 해야하는 지 알 수 있다.

## Reference

- [📹 Docker Tutorial - Part 1 - What is Docker, and Key Concepts](https://youtu.be/T25Z4CUwYjE)
