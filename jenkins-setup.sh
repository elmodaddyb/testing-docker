#!/bin/bash

INIT_ADMIN_PWD="$(cat /usr/share/jenkins/secrets/initialAdminPassword)"
JENKINS_CLI_JAR=/usr/share/jenkins/war/WEB-INF/jenkins-cli.jar
JENKINS_URL=http://localhost:8080/

echo "Install Jenkins Plugins for Test Integration"
echo "--------------------------------------------"
echo "Jenkins URL: $JENKINS_URL"
echo "Jenkins CLI: $JENKINS_CLI_JAR"

java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin git --username admin --password $INIT_ADMIN_PWD 
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin ant --username admin --password $INIT_ADMIN_PWD
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin subversion --username admin --password $INIT_ADMIN_PWD
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin xvfb --username admin --password $INIT_ADMIN_PWD