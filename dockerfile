FROM alpine:latest

MAINTAINER sarvajeet

ENV MAVEN_VERSION 3.6.3
ENV MARIADB_SERVER_HOST localhost
ENV MAVEN_HOME /usr/lib/mvn

ARG HTTP_PROXY
ARG HTTP_PROXY_HOST
ARG HTTP_PROXY_PORT
ARG HTTP_PROXY_SET=false

ENV HTTP_PROXY=$HTTP_PROXY
ENV HTTPS_PROXY=$HTTP_PROXY

RUN apk add --no-cache openjdk8
RUN apk add --no-cache git
RUN apk add --no-cache curl

RUN curl https://apache.osuosl.org/maven/maven-3/3.6.3/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz --output /tmp/apache-maven-$MAVEN_VERSION-bin.tar.gz
WORKDIR /tmp 
RUN pwd 
RUN tar -zxvf apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  rm apache-maven-$MAVEN_VERSION-bin.tar.gz && \
  mv apache-maven-$MAVEN_VERSION $MAVEN_HOME

WORKDIR $MAVEN_HOME/bin
RUN ls -lrt

RUN git config --global http.proxy "$HTTP_PROXY"

RUN mkdir -p /tmp/src
WORKDIR /tmp/src
RUN git clone https://github.com/sarvajeetp/DockerDemo.git
RUN ls -lrt
WORKDIR /tmp/src/DockerDemo
RUN $MAVEN_HOME/bin/mvn package -DskipTests=true -DproxySet=$HTTP_PROXY_SET -DproxyHost=$HTTP_PROXY_HOST -DproxyPort=$HTTP_PROXY_PORT

RUN mkdir -p /opt/demoapp
RUN mv /tmp/src/DockerDemo/target/demo-1.0.jar /opt/demoapp
RUN rm -rf /tmp/src

ENTRYPOINT ["java","-jar","/opt/demoapp/demo-1.0.jar"]

