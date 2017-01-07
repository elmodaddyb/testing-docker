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
    subversion \
    nodejs \
    npm

##--------------------------------------
## Create the jenkins user
##--------------------------------------
ENV JENKINS_DATA=/opt/jenkins
RUN useradd -r -u 201 -m -c "jenkins account" -d ${JENKINS_DATA} -s /bin/false jenkins \
    && chown -R jenkins:jenkins ${JENKINS_DATA}
    
VOLUME ${JENKINS_DATA}

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
##  requires post-build setup via docker exec
##  TODO: use Jenkins Docker method to download plugins directly

COPY jenkins-setup.sh ${JENKINS_DATA}/
RUN chmod u+x ${JENKINS_DATA}/jenkins-setup.sh


##--------------------------------------
## Install Google Chrome
##--------------------------------------
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get update && apt-get install -y google-chrome-stable


##--------------------------------------
## Set up the environment
##--------------------------------------

ENV SHELL /bin/bash
ENV JENKINS_HOME ${JENKINS_DATA}
WORKDIR ${JENKINS_DATA}
USER jenkins

ENTRYPOINT ["java", "-jar", "/usr/share/jenkins/jenkins.war", "--httpKeepAliveTimeout=30000"]
EXPOSE 8080
CMD [""]
