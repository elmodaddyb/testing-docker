#!/bin/bash

INIT_ADMIN_PWD="$(cat $JENKINS_HOME/secrets/initialAdminPassword)"
JENKINS_CLI_JAR=$JENKINS_HOME/war/WEB-INF/jenkins-cli.jar
JENKINS_URL=http://localhost:8080/

echo "Install Jenkins Plugins for Test Integration"
echo "--------------------------------------------"
echo "Jenkins URL: $JENKINS_URL"
echo "Jenkins CLI: $JENKINS_CLI_JAR"

java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin git --username admin --password $INIT_ADMIN_PWD 
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin ant --username admin --password $INIT_ADMIN_PWD
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin subversion --username admin --password $INIT_ADMIN_PWD
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin xvfb --username admin --password $INIT_ADMIN_PWD
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin nodejs --username admin --password $INIT_ADMIN_PWD
java -jar $JENKINS_CLI_JAR -s $JENKINS_URL install-plugin gradle --username admin --password $INIT_ADMIN_PWD

java -jar $JENKINS_CLI_JAR -s $JENKINS_URL restart --username admin --password $INIT_ADMIN_PWD