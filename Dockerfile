

#FROM scratch
#ADD ubuntu-trusty-core-cloudimg-amd64-root.tar.gz /
FROM ubuntu:14.04
 
 
###### add source list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty main restricted" > /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-updates main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-updates universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-updates multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-security main restricted" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-security universe" >> /etc/apt/sources.list
RUN echo "deb http://mirror.kku.ac.th/ubuntu/ trusty-security multiverse" >> /etc/apt/sources.list
 
 
##### add mongodb repo
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-3.0.list
 
##### update repo
RUN apt-get update
 
##### install repo
RUN apt-get install -y mongodb-org
 
##### clean cache package
RUN apt-get autoclean
 
##### volumes for mongodb
RUN mkdir -p /data/db && chown -R mongodb:mongodb /data/db
 
##### open port
EXPOSE 27017
 
##### run mongo
CMD ["/usr/bin/mongod"]
 
 
#### command run docker
## docker run -ti -p port :port  -v hostPath:containerPath --name NAME_OF_CONTAINER -d REPOSITORY_OF_DOCKER MONGOD_COMMAND MONGOD_SMALFILE
## docker run -ti -p 27017:27017 -v /tmp/mongodb:/data/db --name mongo_instance_001 -d mymongo:latest mongod --smallfiles

