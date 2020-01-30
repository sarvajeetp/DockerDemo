FROM alpine:latest

MAINTAINER sarvajeet

ENV MAVEN_VERSION 3.6.3
ENV MARIADB_SERVER_HOST localhost
ENV MAVEN_HOME /usr/lib/mvn

ARG HTTP_PROXY

RUN apk add --no-cache openjdk8
RUN apk add --no-cache git

RUN wget http://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION /usr/lib/mvn

RUN git config --global http.proxy "$HTTP_PROXY"

RUN mkdir -p /tmp/src && cd /tmp/src
RUN git clone https://github.com/sarvajeetp/DockerDemo.git

RUN export MAVEN_HOME="$MAVEN_HOME"
RUN mvn package

RUN mkdir -p /opt/demoapp
RUN mv /tmp/src/DockerDemo/target/demo1.0.jar /opt/demoapp

ENTRYPOINT["java","-jar","/opt/demoapp/demo1.0.jar"]