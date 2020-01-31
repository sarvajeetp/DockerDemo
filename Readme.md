# Spring Boot Maria DB Demo App

It is Spring Boot App which demonstrates starting app in one container and connecting to database residing in another container

## Pre-requsites
Install docker on your Linux flavour system. Use VM if your system is on Windows OS and configure proxy if you system is behind it.

## Source Code

Source code is available @ [https://github.com/sarvajeetp/DockerDemo](https://github.com/sarvajeetp/DockerDemo)

Docker Build file is also included in source code

## To Build App Image

If your machine is behind proxy

```sh
$ docker build -f Downloads/dockerfile --build-arg "HTTP_PROXY=http://username:password@proxy_server_host_name:proxy_server_port" --build-arg HTTP_PROXY_SET=true --build-arg HTTP_PROXY_HOST=proxy_server_host_name --build-arg HTTP_PROXY_PORT=proxy_server_host_port -t spring_mariadb_demo --force-rm .
```

If there is no proxy
```sh
$ docker build -f Downloads/dockerfile -t spring_mariadb_demo --force-rm .
```
> **Note** There is no need to build mariadb image.

## Run Maria DB Container

First run Mariadb container using below command
```sh
$ docker run --name mariadb -e MYSQL_ROOT_PASSWORD=MyNewPass -v ~/Downloads/mariadb:/var/lib/mysql -d mariadb
```

Then execute below command one by one to create database inside the container
```sh
$ docker exec -it mariadb bash
$ mysql -uroot -pMyNewPass
CREATE DATABASE DOCKERDB;
SHOW DATABASES;
exit;
$ exit
```

## Running App Container

```sh
$ docker run --link mariadb -d -e MARIADB_SERVER_HOST=172.17.0.2 -p 8080:8080 --name demo-app spring-mariadb-demo
```

## Access Application
There are two actions available

* if you access below URL, the DB entry will get created
http://localhost:8080/add/your_id/your-name
e.g.
http://localhost:8080/add/1/sarvajeet
* you can retrieve an entry using below url
http://localhost:8080/get/your_id
e.g.
http://localhost:8080/get/1

# **Thank you!!**