# Docker Tutorial

## Docker란 무엇인가?

Docker는 container 기반의 가상화 도구이다. 계층화된 파일 시스템을 사용하여 가상화된 container의 변경사항을 모두 추적하고 관리한다. 이를 통해 container의 특정 상태를 항상 보존해두고, 필요할 때 언제 어디서나 실행할 수 있도록 도와주는 도구이다. docker는 가상 머신의 단점은 극복하면서 장점만을 극대하는 결과로 나온 가상화 어플리케이션이다.

Docker는 단순 가상 머신을 넘어서 환경에 구애 받지 않고 어느 플랫폼에서나 재현가능한 **Application Container**를 만드는 것이 목표이다.

예를 들어보자, OSX를 사용할 때 내가 현재 사용하지 않는 `ruby`, `node`, `mysql` 같은 것들이 뒤에서 돌아가면서 내 메모리와 CPU 파워를 차지하고 있으며, 이는 자원의 낭비이다.

그러나 Docker를 사용하게되면 이야기가 달라진다. 내 OS에 `ruby`나 `mysql`을 설치하는 대신 Docker Engine을 설치한다. 그리고 그 Docker Engine안에 `ruby`나 `mysql`을 설치하는 것이다. Docker Engine에 설치된 이미지들을 사용할 때에는 CPU나 메모리, 디스크등을 접근할 수 있는 OS의 `Kernel`을 이용한다.

## Image

Image는 Container를 만들기 위해 사용하는 추상적인 개념이다. 따라서 고정된 이미지이며 불변^Immutable^한 저장 매체이다.

Docker Image들은 OS를 거치지 않기 때문에 이를 실행하기 위해서는 OS로 Packageing 하는 과정이 필요하다. 내 OS와 각 이미지들이 Packaging된 OS는 같은 Kernel을 사용해야한다.

만약 Linux를 쓴다면, Debian이나 Ubuntu, Alpine 같은 Kernel을 쓸 것이고, MS를 쓴다면, Microsoft Server Core나 Microsoft Nano Server를 쓸 것이다. 추가적으로, ruby의 gem처럼 같이 추가적으로 필요한 과정이 있는 경우에도 OS와 함께 미리 Packaging 해놓는다.

### Command

**docker image 확인**

```shell
$ docker images
```

**docker image 삭제**

```shell
$ docker rmi
```

⚠️ 종료상태를 포함한 image에서 파생된 container가 하나라도 있다면, 해당 image는 삭제할 수 없습니다. 따라서 그러한 image를 삭제하고 싶다면, 먼저 파생된 container들을 모두 종료하고, 삭제까지 해주어야 합니다.

## Container

Container는 추상적인 Docker Image를 이용해서 실행된 우리가 실제로 실행하는 가상머신을 뜻한다. 따라서 변경가능^Mutable^하다. 특정한 이미지로부터 생성된 컨테이너에 어떤 변경사항을 더하고, 변경된 상태를 이미지로 만들어내는 것도 가능하다.

**docker container 확인**

```shell
$ docker ps
```

**docker container 삭제**

```shell
$ docker rm
```

## Dockerfile

`Code`와 `OS`, 다른 의존성들을 정의 해놓은 파일이다. 이 파일을 이용하여 Docker Image를 생성한다. 과거에 사용된 서버 운영 기록들을 코드화 해놓은 것이다.

```shell
$ docker build
```

```shell
$ docker run -p 8000:8000 -it IMAGE ID node server.js
```

```shell
$ docker run -it IMAGE ID /bin/sh
```

### Dockerfile instructions

FROM - 이후의 instruction에 사용할 Base Image를 설정한다. FROM 명령어는 항상 Dockerfile의 첫 instruction이어야한다..

WORKDIR - 이후에 나올 ADD, COPY, CMD, ENTRYPOINT나 RUN같은 instruction들의 작업 위치를 설정한다.

ADD - 파일이나 폴더 외부 URL들을 소스에서 복사하여 image의 파일시스템에 복사한다.

## Docker build의 Debugging

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

## TDD 관점에서 Dockerfile 바라보기

**TDD 과정**

1. TDD에서는 먼저 테스트를 작성하고,
2. 테스트에 실패하고,
3. 코드를 작성/수정한 후,
4. 테스트를 성공합니다.
5. 중복된 코드 등을 리팩터링합니다.
6. 1번으로 돌아갑니다.

Dockerfile도 같은 식으로 생각할 수 있다.

1. 도커 파일을 만들고
2. 도커 이미지 만들기에 실패하고,
3. 도커 파일을 작성/수정한 후,
4. 도커 이미지 만드는 데 성공합니다.
5. 필요 없는 부분은 지우고 합칠 수 있는 명령은 합칩니다. (=효율화)
6. 1번으로 돌아갑니다.

## Reference

- [📹 Docker Tutorial - Part 1 - What is Docker, and Key Concepts](https://youtu.be/T25Z4CUwYjE)
- [📄 도커(Docker) 튜토리얼 : 깐 김에 배포까지](https://blog.nacyot.com/articles/2014-01-27-easy-deploy-with-docker/)
