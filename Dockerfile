# Dockerfile for Integration Testing
# Created by: Eamonn Buss
# Created on: 01/01/2017
# Purpose: A docker file to create a docker container for Integrated Build Machine

##--------------------------------------
## Start with UBUNTU image as the base
##--------------------------------------
FROM ubuntu:16.10

##--------------------------------------
## Maintainer - Eamonn Buss
##--------------------------------------
MAINTAINER Eamonn Buss <eamonn@srcdevbin.com>

##--------------------------------------
## Install Testing Prerequisites
##--------------------------------------

RUN apt-get update && apt-get install -y \
    git-all \
    xvfb \
    ant \
    gradle \
    subversion

##--------------------------------------
## Create the dev user
##--------------------------------------

RUN groupadd cideveloper -g 1001\
  && useradd -g cideveloper -s /bin/bash cideveloper -d /home/cideveloper

RUN echo "cideveloper:changeit" | chpasswd

##--------------------------------------
## Install Jenkins
##--------------------------------------

RUN apt-get update && apt-get install wget
RUN wget -q -O - https://jenkins-ci.org/debian/jenkins-ci.org.key | apt-key add -
RUN sh -c 'echo deb http://pkg.jenkins-ci.org/debian binary/ > /etc/apt/sources.list.d/jenkins.list'
RUN apt-get update && apt-get install -y jenkins

##--------------------------------------
## Configure Jenkins
##--------------------------------------
COPY jenkins-setup.sh /home/cideveloper/
RUN chmod u+x /home/cideveloper/jenkins-setup.sh


##--------------------------------------
## Set up the environment
##--------------------------------------
ENV SHELL /bin/bash
ENV JENKINS_HOME /usr/share/jenkins
WORKDIR /usr/share/jenkins
RUN ["chown", "cideveloper:cideveloper", "-R", "/usr/share/jenkins"]
USER cideveloper

ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war", "--httpKeepAliveTimeout=15000"]
EXPOSE 8080
CMD [""]
